import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'business.g.dart'; // Required for Hive code generation

@HiveType(typeId: 0) // Assign a unique typeId
class Business extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String location;
  @HiveField(2)
  final String contactNumber;

  const Business({
    required this.name,
    required this.location,
    required this.contactNumber,
  });

  // Factory constructor to create a Business object from messy JSON
  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      name: json['biz_name'] as String? ?? '',
      location: json['bss_location'] as String? ?? '',
      contactNumber: json['contct_no'] as String? ?? '',
    );
  }

  // Converts a Business object to a map (useful for debugging or other operations)
  Map<String, dynamic> toJson() => {
    'name': name,
    'location': location,
    'contactNumber': contactNumber,
  };

  @override
  List<Object> get props => [name, location, contactNumber];
}
