import '../../models/address.dart';
import '../../models/cart_item.dart';
import '../../models/order_models.dart';
import '../../models/payment_card.dart';

enum OrderStatus { initial, loading, success, error, processing, shipped, delivered, cancelled, }

class OrderState {
  final OrderStatus status;
  final String? error;
  final String? orderNumber;
  final OrderModels? currentOrder;
  final List<CartItem> items;
  final double total;
  final Address? address;
  final PaymentCard? card;
  final List<OrderModels> allOrders;

  OrderState({
    this.status = OrderStatus.initial,
    this.error,
    this.orderNumber,
    this.currentOrder,
    this.items = const [],
    this.total = 0.0,
    this.address,
    this.card,
    this.allOrders = const [],
  });

  OrderState copyWith({
    OrderStatus? status,
    String? error,
    String? orderNumber,
    OrderModels? currentOrder,
    List<CartItem>? items,
    double? total,
    Address? address,
    PaymentCard? card,
    List<OrderModels>? allOrders,
  }) {
    return OrderState(
      status: status ?? this.status,
      error: error ?? this.error,
      orderNumber: orderNumber ?? this.orderNumber,
      currentOrder: currentOrder ?? this.currentOrder,
      items: items ?? this.items,
      total: total ?? this.total,
      address: address ?? this.address,
      card: card ?? this.card,
      allOrders: allOrders ?? this.allOrders,
    );
  }
}