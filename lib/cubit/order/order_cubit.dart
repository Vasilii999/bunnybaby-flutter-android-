import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/cubit/order/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../models/address.dart';
import '../../models/cart_item.dart';
import '../../models/order_models.dart';
import '../../models/payment_card.dart';
import '../cart/cart_cubit.dart';

class OrderCubit extends Cubit<OrderState> {
  final CartCubit cartCubit;
  OrderCubit(this.cartCubit) : super(OrderState());


  void setAddress(Address address) {
    emit(state.copyWith(address: address));
  }

  void setCard(PaymentCard card) {
    emit(state.copyWith(card: card));
  }

  void setItems(List<CartItem> items) {
    final total = items.fold<double>(
        0.0, (acc, item) => acc + item.product.price * item.quantity);
    emit(state.copyWith(items: items, total: total));
  }

  Future<void> placeOrder(String uid) async {
    final cartState = cartCubit.state;

    if (state.address == null || state.card == null || cartState.items.isEmpty) {
      emit(state.copyWith(
          status: OrderStatus.error,
          error: 'Address, payment method and items are required'));
      return;
    }

    emit(state.copyWith(status: OrderStatus.loading, error: null));

    try {
      final orderId = const Uuid().v4().substring(0, 8).toUpperCase();

      final order = OrderModels(
        id: orderId,
        items: cartState.items,
        totalPrice: cartState.totalPrice,
        totalAmount: cartState.grandTotal,
        itemCount: cartState.itemCount,
        createdAt: DateTime.now(),
        status: OrderStatus.processing,
        address: state.address!.toMap(),
        cardLast4: state.card!.cardNumber.substring(state.card!.cardNumber.length - 4),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc(orderId)
          .set(order.toMap());

      emit(state.copyWith(
        orderNumber: orderId,
        status: OrderStatus.success,
        currentOrder: order, // Сохраняем текущий заказ в состоянии
      ));
    } catch (e) {
      emit(state.copyWith(
        status: OrderStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> loadOrders(String userId) async {
    emit(state.copyWith(status: OrderStatus.loading));

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .get();


      final orders = snapshot.docs.map((doc) {
        final data = doc.data();
        return OrderModels.fromMap(data);
      }).toList();

      emit(state.copyWith(allOrders: orders, status: OrderStatus.success));
    } catch (e) {
      emit(state.copyWith(status: OrderStatus.error, error: e.toString()));
    }
  }

  void setStatus(OrderStatus status) {
    emit(state.copyWith(status: status));
  }

  void reset() {
    emit(OrderState());
  }
}
