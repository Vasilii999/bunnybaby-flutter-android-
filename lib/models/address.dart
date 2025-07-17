import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String id;
  final String address;
  final String? address2;
  final String region;
  final String city;
  final String index;
  final String? phone;

  Address({
    required this.id,
    required this.address,
    this.address2,
    required this.city,
    required this.region,
    required this.index,
    this.phone,
  });

  Address copyWith({
    String? id,
    String? address,
    String? address2,
    String? region,
    String? city,
    String? index,
    String? phone,
  }) {
    return Address(
      id: id ?? this.id,
      address: address ?? this.address,
      address2: address2 ?? this.address2,
      region: region ?? this.region,
      city: city ?? this.city,
      index: index ?? this.index,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'address2': address2,
      'region': region,
      'city': city,
      'index': index,
      'phone': phone,
    };
  }

  factory Address.fromFirestore(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return Address(
      id: doc.id,
      address: map['address'],
      address2: map['address2'] ?? '',
      region: map['region'] ?? '',
      city: map['city'] ?? '',
      index: map['index'] ?? '',
      phone: map['phone'],
    );
  }



}