import 'package:flutter/foundation.dart';
import '../repositories/business_repository.dart';
import 'business_state.dart';

class BusinessProvider with ChangeNotifier {
  final BusinessRepository _repository;
  BusinessState _state = const BusinessState();

  BusinessProvider(this._repository);

  BusinessState get state => _state;

  Future<void> loadBusinesses() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final businesses = await _repository.fetchBusinesses();
      _state = _state.copyWith(isLoading: false, businesses: businesses);
    } catch (e) {
      _state = _state.copyWith(isLoading: false, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  // A method to retry fetching, used by the error screen
  void retry() {
    loadBusinesses();
  }
}
