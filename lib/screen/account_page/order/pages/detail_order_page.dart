import 'package:figma21/core/exports.dart';
import 'package:figma21/models/order_models.dart';
import 'package:figma21/screen/account_page/order/widgets/order_progress.dart';
import 'package:flutter/material.dart';
import 'package:figma21/core/exports_theme.dart';
import '../../../cart_page/widgets/cart_product.dart';
import '../widgets/detail_order_widget.dart';
import '../widgets/order_payment_details.dart';

class DetailOrderPage extends StatelessWidget {
  final OrderModels order;
  const DetailOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали заказа',
            style: f16w700.copyWith(
                height: 1.5,
                letterSpacing: 0.5,
                fontFamily: 'Poppins',
                color: dark)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: light,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderProgress(status: order.status),
            Padding(padding:const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Product',style: f16w700.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark))),
            ...order.items
                .map((cartItem) => CartProduct(product: cartItem.product, quantity: cartItem.quantity)),
            const SizedBox(height: 16,),
            DetailOrderWidget(order: order),
            const SizedBox(height: 16,),
            OrderPaymentDetails(order: order),
            const SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStateProperty.all(15),
                  shadowColor:
                  WidgetStateProperty.all(Colors.blue.withOpacity(0.24)),
                  backgroundColor: WidgetStateProperty.all(pink),
                  fixedSize: WidgetStateProperty.all(
                      const Size(double.maxFinite, 57)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                ),
                onPressed: () {Navigator.pop(context);},
                child: Text(
                  'Назад',
                  style: f14w700.copyWith(
                    color: white,
                    letterSpacing: 0.5,
                    height: 1.8,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }
}