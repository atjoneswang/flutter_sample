import '../data/crypto_data.dart';

abstract class CryptoListViewContract {
  void onLoadCryptoComplete(List items);
  void onLoadCryptoError();
}

class CryptoListPresenter {
  CryptoListViewContract _view;
  CryptoRepository _repository;

  CryptoListPresenter(this._view) {
    _repository = new Injector().cryptoRepository;
  }

  void loadCurrencies() {
    _repository
    .fetchCurrencies()
    .then((c) => _view.onLoadCryptoComplete(c))
    .catchError((onError) => _view.onLoadCryptoError());
  }
}