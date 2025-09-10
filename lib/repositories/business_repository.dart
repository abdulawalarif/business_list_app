import 'package:hive/hive.dart';
import '../models/business.dart';
import '../services/business_api_service.dart';

class BusinessRepository {
  final BusinessApiService _apiService;
  final Box<Business> _businessBox; // Hive box to store businesses

  BusinessRepository(this._apiService, this._businessBox);

  Future<List<Business>> fetchBusinesses() async {
    try {
      // 1. Try to fetch from network
      final businesses = await _apiService.fetchBusinesses();
      // 2. Clear old data and save new data to Hive
      await _businessBox.clear();
      await _businessBox.addAll(businesses);
      // 3. Return the new data
      return businesses;
    } catch (e) {
      // If network fails, try to load from local database (Hive)
      final localBusinesses = _businessBox.values.toList();
      if (localBusinesses.isNotEmpty) {
        return localBusinesses;
      } else {
        // If local data is also empty, rethrow the error
        rethrow;
      }
    }
  }
}
