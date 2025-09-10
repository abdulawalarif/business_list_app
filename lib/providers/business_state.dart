import '../models/business.dart';

class BusinessState {
  final bool isLoading;
  final List<Business> businesses;
  final String? error;

  const BusinessState({
    this.isLoading = false,
    this.businesses = const [],
    this.error,
  });

  BusinessState copyWith({
    bool? isLoading,
    List<Business>? businesses,
    String? error,
  }) {
    return BusinessState(
      isLoading: isLoading ?? this.isLoading,
      businesses: businesses ?? this.businesses,
      error: error ?? this.error,
    );
  }
}
