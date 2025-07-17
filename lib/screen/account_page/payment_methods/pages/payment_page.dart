import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:figma21/screen/account_page/payment_methods/widgets/payment_menu.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment',
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
      body: const Column(
        children: [
          Expanded(
            child: PaymentMenu(),
          ),
        ],
      ),
    );
  }
}
