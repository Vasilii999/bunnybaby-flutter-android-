import 'package:figma21/core/exports.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'input_number.dart';

class CartProduct extends StatelessWidget {
  final ProductFirebase product;
  final int quantity;

  const CartProduct({super.key, required this.product, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 104,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: light),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          product.imageUrls.first,
                          width: 70,
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.name,
                              style: f14w700.copyWith(
                                  color: dark,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.5,
                                  height: 0.5),
                            ),
                            SizedBox(
                              height: 24,
                              width: 56,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {},
                                      child: SvgPicture.asset(
                                        'assets/svg/system_icon/24px/love.svg',
                                        height: 24,
                                        width: 24,
                                      )),
                                  GestureDetector(
                                      onTap: () {
                                        context
                                            .read<CartCubit>()
                                            .removeFromCart(product);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/svg/system_icon/24px/Trash.svg',
                                        height: 24,
                                        width: 24,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${(product.price * (100 - product.discount) / 100).round()} сом',
                              style: f14w700.copyWith(
                                  color: pink,
                                  height: 1.5,
                                  letterSpacing: 0.5,
                                  fontFamily: 'Poppins'),
                            ),
                            InputNumber(
                              quantity: quantity,
                              onDecrement: () {context.read<CartCubit>().addToCart(product);},
                              onIncrement: () {context.read<CartCubit>().removeFromCart(product);},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
