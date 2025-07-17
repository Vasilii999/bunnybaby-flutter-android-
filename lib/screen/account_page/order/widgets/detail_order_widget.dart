
import 'package:flutter/material.dart';

import '../../../../models/order_models.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';

class DetailOrderWidget extends StatelessWidget {
  final OrderModels order;
  const DetailOrderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text('Детали доставки',style: f16w700.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
          const SizedBox(height: 12,),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                border: Border.all(color: light, width: 1)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('Дата заказа',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
                    Text(order.formattedDate,style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
                  ],),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('№ Заказа',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
                      Text(order.id,style: f16w700.copyWith(height: 1.5, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
                    ],),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Адрес',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
                      Text('г.${order.address['city'] ?? ''}, ${order.address['address'] ?? ''}',
                          style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
                    ],),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
          ),
      ],
      ),
    );
  }
}
