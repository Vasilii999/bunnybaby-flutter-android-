import 'package:flutter/material.dart';

import '../../../../models/order_models.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';

class OrderPaymentDetails extends StatelessWidget {
  final OrderModels order;
  const OrderPaymentDetails({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:[
      Text('Детали оплаты',style: f16w700.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
    const SizedBox(height: 12,),
    Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
    border: Border.all(color: light, width: 1)),
    child: Padding(
    padding: const EdgeInsets.all(16),
        child: Column(
    children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Товары (${order.itemCount})', style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
              Text('${order.totalPrice.round()} сом',  style: f12w400.copyWith(height: 1.5, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Доставка', style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
              Text('250 сом', style: f12w400.copyWith(height: 1.5, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Итого', style: f14w400.copyWith(color: dark,fontFamily: 'Poppins')),
              Text('${order.totalAmount.round()} сом', style: f14w700.copyWith(color: pink)),
            ],
          ),
        ],
      ),
    ),
    ),
      ],
    )
    );
  }
}
