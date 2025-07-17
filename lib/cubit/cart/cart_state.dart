import 'package:figma21/core/exports_models.dart';

class CartState {
  final List<CartItem> items;
  final double deliveryCost;

  CartState({
    required this.items,
    this.deliveryCost = 250.0,// фиксированная доставка

  });

  // Сумма без скидки
  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

  // Сумма со скидкой
  double get totalPrice =>
      items.fold(0.0, (sum, item) => sum + (item.product.price - (item.product.price * item.product.discount / 100)) * item.quantity);

  int get itemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  double get grandTotal => totalPrice + deliveryCost;

  CartState copyWith({
    List<CartItem>? items,
    double? deliveryCost,
  }) {
    return CartState(
      items: items ?? this.items,
      deliveryCost: deliveryCost ?? this.deliveryCost,
    );
  }
}