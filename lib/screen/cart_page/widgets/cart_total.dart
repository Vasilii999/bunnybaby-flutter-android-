import 'package:figma21/core/exports.dart';
import 'package:flutter/material.dart';


class CartTotal extends StatelessWidget {
  const CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    final cartState = context.watch<CartCubit>().state;
    final totalPrice = cartState.totalPrice;
    final deliveryCost = cartState.deliveryCost;
    final grandTotal = cartState.grandTotal;
    final itemCount = cartState.itemCount;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Товары ($itemCount)', style: f12w400.copyWith(color: grey)),
              Text('${totalPrice.round()} сом', style: f12w400.copyWith(color: dark)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Доставка', style: f12w400.copyWith(color: grey)),
              Text('${deliveryCost.round()} сом', style: f12w400.copyWith(color: dark)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Итого', style: f14w700.copyWith(color: dark)),
              Text('${grandTotal.round()} сом', style: f14w700.copyWith(color: pink)),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
