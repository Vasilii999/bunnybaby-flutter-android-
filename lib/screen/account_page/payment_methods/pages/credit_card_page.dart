import 'package:figma21/cubit/payment/payment_cubit.dart';
import 'package:figma21/models/payment_card.dart';
import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:figma21/screen/account_page/payment_methods/widgets/credit_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_card_page.dart';

class CreditCardAndDebitPage extends StatefulWidget {
  const CreditCardAndDebitPage({super.key});

  @override
  State<CreditCardAndDebitPage> createState() => _CreditCardAndDebitPageState();
}

class _CreditCardAndDebitPageState extends State<CreditCardAndDebitPage> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Кредитные карты',
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
      body: BlocBuilder<PaymentCubit, List<PaymentCard>>(
        builder: (context, cards) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:
                    cards.map((card) =>
                        CreditCard(
                          cardNumber: card.cardNumber,
                          cvv: card.cvv,
                          date: '${card.date.month.toString().padLeft(2, '0')}/${card.date.year}',
                          name: card.name,
                        )).toList(),
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
                  child: Text(
                    'Добавить карту',
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
              )
            ],
          );
        },
      ),
    );
  }
}
