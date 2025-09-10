import '../models/business.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class BusinessApiService {
  //final Dio _dio = Dio();

  Future<List<Business>> fetchBusinesses() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    // Load from local asset
    final String response = await rootBundle.loadString(
      'assets/businesses.json',
    );
    final List<dynamic> businessesJson = jsonDecode(response);
    return businessesJson
        .map((jsonItem) => Business.fromJson(jsonItem))
        .toList();
  }
}
