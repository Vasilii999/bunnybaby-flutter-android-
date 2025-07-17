import 'package:figma21/core/exports.dart';
import 'package:figma21/cubit/cart/cart_state.dart';
import 'package:figma21/screen/cart_page/order/ship_to.dart';
import 'package:figma21/screen/cart_page/widgets/cart_product.dart';
import 'package:figma21/screen/cart_page/widgets/cart_total.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ваша корзина',
            style: f16w700.copyWith(
                height: 1.5,
                letterSpacing: 0.5,
                fontFamily: 'Poppins',
                color: dark),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              height: 1,
              thickness: 1,
              color: light,
            ),
          ),
        ),
        body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('Корзина пуста'));
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: state.items
                        .map((cartItem) => CartProduct(product: cartItem.product, quantity: cartItem.quantity)).toList(),
                  ),
                ),
              ),
              const CartTotal(),
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ShipTo()));
                  },
                  child: Text(
                    'Оформить заказ',
                    style: f14w700.copyWith(
                      color: white,
                      letterSpacing: 0.5,
                      height: 1.8,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
