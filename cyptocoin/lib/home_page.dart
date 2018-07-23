import 'package:flutter/material.dart';
import 'data/crypto_data.dart';
import 'modules/cypto_presenter.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage>
    implements CryptoListViewContract, WidgetsBindingObserver {
  CryptoListPresenter _presenter;
  List<Crypto> _currencies;
  bool _isLoading;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];
  
  Timer timer;
  AppLifecycleState _lastLifecycleState;

  _MyHomePageState() {
    _presenter = new CryptoListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isLoading = true;
    _presenter.loadCurrencies();
    startTimer();
  }
  @override
    void dispose() {
      super.dispose();
      WidgetsBinding.instance.removeObserver(this);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text("Crypto Coins"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _isLoading
          ? Center(
              child: new CircularProgressIndicator(),
            )
          : _cryptoWidget(),
    );
  }

  void startTimer(){
    final tenSec = const Duration(seconds: 10);
    timer = new Timer.periodic(tenSec, (Timer t) => _presenter.loadCurrencies());
    debugPrint("Set repeat function");
  }
  Widget _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: _currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final int i = index ~/ 2;
                final Crypto currency = _currencies[index];
                final MaterialColor color = _colors[i % _colors.length];
                return Column(
                  children: <Widget>[
                    _getListItemUi(currency, color),
                    new Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getListItemUi(Crypto currency, MaterialColor color) {
    return new ListTile(
      leading: new Image.network(
          "https://s2.coinmarketcap.com/static/img/coins/32x32/${currency.id}.png"),
      title: new Text(
        currency.name,
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      //subtitle: _getSubtitleText(currency.priceUsd, currency.percentChange1h),
      trailing: _getSubtitleText(currency.priceUsd, currency.percentChange1h),
    );
  }

  Widget _getSubtitleText(double priceUsd, double percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
      text: "\$$priceUsd\n",
      style: new TextStyle(color: Colors.black),
    );
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;
    if (percentageChange > 0) {
      percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText,
        style: new TextStyle(color: Colors.green),
      );
    } else {
      percentageChangeTextWidget = new TextSpan(
        text: percentageChangeText,
        style: TextStyle(color: Colors.red),
      );
    }

    return new RichText(
      text:
          new TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }

  @override
  void onLoadCryptoComplete(List items) {
    setState(() {
      _currencies = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadCryptoError() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
          _lastLifecycleState = state;
        });

    if(state == AppLifecycleState.inactive){
        timer.cancel();
        debugPrint("cancel timer");
    }

    if(state == AppLifecycleState.resumed){
      startTimer();
      debugPrint("resume timer");
    }
  }

  @override
  void didChangeLocale(Locale locale) {
    debugPrint(locale.countryCode);
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
  }

  @override
  void didChangeTextScaleFactor() {
    // TODO: implement didChangeTextScaleFactor
  }

  @override
  void didHaveMemoryPressure() {
    // TODO: implement didHaveMemoryPressure
  }

  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
  }
}
