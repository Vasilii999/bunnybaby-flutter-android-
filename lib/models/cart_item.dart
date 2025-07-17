import 'package:figma21/models/product_firebase.dart';

class CartItem {
  final ProductFirebase product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
    };
  }

  CartItem copyWith({ProductFirebase? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
        product: ProductFirebase.fromMap(map['product'] as Map<String, dynamic>),
        quantity: map['quantity'] as int,
    );
  }


}