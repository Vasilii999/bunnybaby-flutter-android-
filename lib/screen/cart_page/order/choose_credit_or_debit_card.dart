import 'package:figma21/cubit/payment/payment_cubit.dart';
import 'package:figma21/models/payment_card.dart';
import 'package:figma21/screen/cart_page/order/success_screen_cart.dart';
import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:figma21/screen/account_page/payment_methods/widgets/credit_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../cubit/cart/cart_cubit.dart';
import '../../../cubit/order/order_cubit.dart';
import '../../account_page/payment_methods/pages/add_card_page.dart';

class ChooseCreditOrDebitCard extends StatefulWidget {
  const ChooseCreditOrDebitCard({super.key});

  @override
  State<ChooseCreditOrDebitCard> createState() =>
      _ChooseCreditOrDebitCardState();
}

class _ChooseCreditOrDebitCardState extends State<ChooseCreditOrDebitCard> {
  PaymentCard? selectedCard;

  @override
  void initState() {
    super.initState();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      context.read<PaymentCubit>().loadPaymentCards(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = context.watch<CartCubit>().state.grandTotal;
    return Scaffold(
      appBar: AppBar(
        title: Text('Кредитные карты',
            style: f16w700.copyWith(
                height: 1.5,
                letterSpacing: 0.5,
                fontFamily: 'Poppins',
                color: dark)),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await Navigator.push<Map<String, dynamic>>(
                context,
                MaterialPageRoute(builder: (_) => const AddCardPage()),
              );
              if (result != null) {
                final uid = FirebaseAuth.instance.currentUser?.uid;
                if (uid != null) {
                  if (!context.mounted) return;
                  context.read<PaymentCubit>().loadPaymentCards(uid);
                }
              }
            },
            icon: SvgPicture.asset('assets/svg/system_icon/24px/Plus.svg',
                colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: light,
          ),
        ),
      ),
      body: BlocBuilder<PaymentCubit, List<PaymentCard>>(
        builder: (context, cards) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: cards.map((card) {
                      final isSelected =
                          selectedCard?.cardNumber == card.cardNumber;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedCard = card;
                          });
                        },
                        child: Stack(children: [
                          IgnorePointer(
                            ignoring: true,
                            child: CreditCard(
                              cardNumber: card.cardNumber,
                              cvv: card.cvv,
                              date:
                                  '${card.date.month.toString().padLeft(2, '0')}/${card.date.year}',
                              name: card.name,
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: pink,
                                  size: 24,
                                ),
                              ),
                            ),
                        ]),
                      );
                    }).toList(),
                  ),
                ),
              ),
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
                  onPressed: () async {

                    final uid = FirebaseAuth.instance.currentUser?.uid;
                    if (uid == null || selectedCard == null) return;

                    final cartState = context.read<CartCubit>().state;
                    final selectedAddress =
                        context.read<OrderCubit>().state.address;
                    if (selectedAddress == null) return;

                    context.read<OrderCubit>().setItems(cartState.items);
                    context.read<OrderCubit>().setCard(selectedCard!);
                    context.read<OrderCubit>().setAddress(selectedAddress);

                    await context.read<OrderCubit>().placeOrder(uid);
                    if (!context.mounted) return;
                    context.read<CartCubit>().clearCart();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SuccessScreenCart()),
                    );
                  },
                  child: Text(
                    'Оплатить ${total.round()} сом',
                    style: f14w700.copyWith(
                      color: white,
                      letterSpacing: 0.5,
                      height: 1.8,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          );
        },
      ),
    );
  }
}
