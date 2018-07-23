import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Crypto {
  int id;
  String name;
  double priceUsd;
  double percentChange1h;
  String symbol;

  Crypto(
      {this.id, this.name, this.priceUsd, this.percentChange1h, this.symbol});

  Crypto.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        priceUsd = map['quotes']['USD']['price'],
        percentChange1h = map['quotes']['USD']['percent_change_1h'],
        symbol = map['symbol'];
}

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCurrencies();
}

class FetchDataexception implements Exception {
  final String _message;
  FetchDataexception([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  CryptoRepository get cryptoRepository {
    return new ProdCryptoRepository();
  }
}

class ProdCryptoRepository implements CryptoRepository {
  final String url = "https://api.coinmarketcap.com/v2/ticker/?limit=20";
  @override
  Future<List<Crypto>> fetchCurrencies() async {
    http.Response response = await http.get(url);
    final Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode != 200 || responseBody == null) {
      throw new FetchDataexception(
          "An error ocurred: [Status Code: $response.statusCode]");
    }
    final Map<String, dynamic> child = responseBody['data'];
    debugPrint("fetch done");
    return child.values.map((c) => new Crypto.fromMap(c)).toList();
  }
}
