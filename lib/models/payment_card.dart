import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentCard {
  final String id;
  final String userId;
  final String cardNumber;
  final String cvv;
  final String name;
  final DateTime date;

  PaymentCard({
    required this.id,
    required this.userId,
    required this.cardNumber,
    required this.cvv,
    required this.name,
    required this.date,
  });

  PaymentCard copyWith({
    String? id,
    String? userId,
    String? cardNumber,
    String? cvv,
    String? name,
    DateTime? date,
  }) {
    return PaymentCard(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cardNumber: cardNumber ?? this.cardNumber,
      cvv: cvv ?? this.cvv,
      name: name ?? this.name,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'cardNumber': cardNumber,
      'cvv': cvv,
      'name': name,
      'date': Timestamp.fromDate(date),
    };
  }

  factory PaymentCard.fromMap(Map<String, dynamic> map) {
    return PaymentCard(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      cvv: map['cvv'] ?? '',
      name: map['name'] ?? '',
      date: (map['date'] as Timestamp).toDate(),
    );
  }



}