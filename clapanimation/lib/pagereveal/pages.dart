import 'package:flutter/material.dart';

final pages = [
  new PageViewModel(
      const Color(0xff678fb4),
      'assets/pagereveal/hotels.png',
      'Hotels',
      'All hotels and hostels are sorted by hospitality rating',
      'assets/pagereveal/key.png'),
  new PageViewModel(
      const Color(0xff65b0b4),
      'assets/pagereveal/banks.png',
      'Banks',
      'We carefully verify all banks before adding theme into the app',
      'assets/pagereveal/wallet.png'),
  new PageViewModel(
      const Color(0xff9b90bc),
      'assets/pagereveal/stores.png',
      'Store',
      'All local stores are categorized for your convenience',
      'assets/pagereveal/shopping_cart.png'),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;
  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: viewModel.color,
      width: double.infinity,
      child: Opacity(
        opacity: percentVisible,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 50.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Image.asset(
                  viewModel.heroassetPath,
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1.0 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  viewModel.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Flamante',
                    fontSize: 34.0,
                  ),
                ),
              ),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, 30.0 * (1 - percentVisible), 0.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: Text(
                  viewModel.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageViewModel {
  final Color color;
  final String heroassetPath;
  final String title;
  final String body;
  final String iconAssetIcon;

  PageViewModel(
    this.color,
    this.heroassetPath,
    this.title,
    this.body,
    this.iconAssetIcon,
  );
}
