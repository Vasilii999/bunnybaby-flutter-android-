import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCard extends StatefulWidget {
  final String cardNumber;
  final String cvv;
  final String date;
  final String name;

  const CreditCard(
      {super.key,
      required this.cardNumber,
      required this.cvv,
      required this.date,
      required this.name});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: widget.cardNumber,
      obscureCardNumber: false,
      expiryDate: widget.date,
      cardHolderName: widget.name,
      cvvCode: widget.cvv,
      obscureCardCvv: false,
      showBackView: false,
      onCreditCardWidgetChange: (CreditCardBrand brand) {},
      isHolderNameVisible: true,
      cardBgColor: const Color(0xFFFB7181),
    );
  }
}
