import 'package:intl/intl.dart';

import '../cubit/order/order_state.dart';
import 'cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModels {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final double totalPrice;
  final int itemCount;
  final DateTime createdAt;
  final OrderStatus status;
  final Map<String, dynamic> address; // Адрес теперь обязателен
  final String cardLast4; // Последние 4 цифры карты тоже
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy');

  OrderModels({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.itemCount,
    required this.createdAt,
    required this.status,
    required this.address,
    required this.cardLast4,
    required this.totalPrice,
  });


  String get formattedDate => _dateFormat.format(createdAt);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'items': items.map((item) => item.toMap()).toList(),
      'totalAmount': totalAmount,
      'totalPrice': totalPrice,
      'itemCount': itemCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'status': status.name,
      'address': address,
      'cardLast4': cardLast4,
    };
  }

  factory OrderModels.fromMap(Map<String, dynamic> map) {
    final items = (map['items'] as List<dynamic>)
        .map((item) => CartItem.fromMap(item as Map<String, dynamic>))
        .toList();

    final double totalAmount = (map['totalAmount'] as num?)?.toDouble() ??
        (map['total'] as num?)?.toDouble() ?? // старое поле
        items.fold<double>(
          0.0,
              (acc, item) => acc + item.product.price * item.quantity,
        );

    final double totalPrice = (map['totalAmount'] as num?)?.toDouble() ??
        (map['total'] as num?)?.toDouble() ?? // старое поле
        items.fold<double>(
          0.0,
              (acc, item) => acc + item.product.price * item.quantity,
        );


    final int itemCount = (map['itemCount'] as int?) ??
        items.fold<int>(
          0,
              (acc, item) => acc + item.quantity,
        );

    return OrderModels(
      id: map['id'] as String,
      totalAmount: totalAmount,
      totalPrice: totalPrice,
      itemCount: itemCount,
      items: items,
      status: OrderStatus.values.firstWhere(
              (e) => e.name == map['status'],
          orElse: () => OrderStatus.initial),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      address: map['address'] as Map<String, dynamic>,
      cardLast4: map['cardLast4'] as String,
    );
  }
}