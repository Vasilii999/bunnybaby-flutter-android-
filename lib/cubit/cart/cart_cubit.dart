import 'package:figma21/core/exports_models.dart';
import 'package:figma21/core/exports_cubit.dart';
import 'package:figma21/cubit/cart/cart_state.dart';


class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState(items: []));

  void addToCart(ProductFirebase product) {
    final existingIndex = state.items.indexWhere((item) => item.product.id == product.id);
    List<CartItem> updatedItems = List.from(state.items);

    if (existingIndex >= 0) {
      // Если товар уже в корзине — увеличиваем количество
      final existingItem = updatedItems[existingIndex];
      updatedItems[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity + 1);
    } else {
      // Если товара ещё нет — добавляем с количеством 1
      updatedItems.add(CartItem(product: product, quantity: 1));
    }

    emit(CartState(items: updatedItems));
  }

  void removeFromCart(ProductFirebase product) {
    final existingIndex = state.items.indexWhere((item) => item.product.id == product.id);
    if (existingIndex == -1) return;

    List<CartItem> updatedItems = List.from(state.items);
    final existingItem = updatedItems[existingIndex];

    if (existingItem.quantity > 1) {
      // Уменьшаем количество, если больше 1
      updatedItems[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity - 1);
    } else {
      // Если количество 1 — удаляем товар из корзины
      updatedItems.removeAt(existingIndex);
    }

    emit(CartState(items: updatedItems));
  }

  void clearCart() {
    emit(CartState(items: []));
  }
}