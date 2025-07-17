import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/cubit/payment/payment_cubit.dart';
import 'package:figma21/models/payment_card.dart';
import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _cvvController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();


  @override
  void dispose() {
    _cardController.dispose();
    _dateController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  final maskFormatterCard = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: { "#": RegExp(r'\d')},
  );

  final maskFormatterCvv = MaskTextInputFormatter(
    mask: '###',
    filter: { "#": RegExp(r'\d')},
  );

  final maskFormatterDate = MaskTextInputFormatter(
    mask: '##/####',
    filter: { "#": RegExp(r'\d')},
  );

  TextInputFormatter upperCaseInputFormatter() {
    return TextInputFormatter.withFunction(
          (oldValue, newValue) =>
          newValue.copyWith(
            text: newValue.text.toUpperCase(),
            selection: newValue.selection,
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить карту',
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Номер карты',
                        style: f14w700.copyWith(
                            height: 1.5,
                            letterSpacing: 0.5,
                            fontFamily: 'Poppins',
                            color: dark)),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _cardController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [maskFormatterCard],
                      style: f12w400.copyWith(color: grey),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        hintText: '4129 4456 7685 1594',
                        hintStyle: f12w400.copyWith(
                            color: grey,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5,
                            height: 1.8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: light,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: light,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, Введите Номер карты';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Действителен До',
                                  style: f14w700.copyWith(
                                      height: 1.5,
                                      letterSpacing: 0.5,
                                      fontFamily: 'Poppins',
                                      color: dark)),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: _dateController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [maskFormatterDate],
                                style: f12w400.copyWith(color: grey),
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                                  hintText: '19/2029',
                                  hintStyle: f12w400.copyWith(
                                      color: grey,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.5,
                                      height: 1.8),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: light,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: light,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста, Введите дату';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CVV/CVE',
                                  style: f14w700.copyWith(
                                      height: 1.5,
                                      letterSpacing: 0.5,
                                      fontFamily: 'Poppins',
                                      color: dark)),
                              const SizedBox(
                                height: 12,
                              ),
                              TextFormField(
                                controller: _cvvController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [maskFormatterCvv],
                                style: f12w400.copyWith(color: grey),
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                                  hintText: '000',
                                  hintStyle: f12w400.copyWith(
                                      color: grey,
                                      fontFamily: 'Poppins',
                                      letterSpacing: 0.5,
                                      height: 1.8),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: light,
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: light,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Пожалуйста, Введите CVV';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Имя держателя карты',
                        style: f14w700.copyWith(
                            height: 1.5,
                            letterSpacing: 0.5,
                            fontFamily: 'Poppins',
                            color: dark)),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      inputFormatters: [upperCaseInputFormatter()],
                      style: f12w400.copyWith(color: grey),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        hintText: 'AIBEKOV AIBEK',
                        hintStyle: f12w400.copyWith(
                            color: grey,
                            fontFamily: 'Poppins',
                            letterSpacing: 0.5,
                            height: 1.8),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: light,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: light,
                            width: 1,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста, Введите имя';
                        }
                        return null;
                      },
                    ),
                  ],
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
                  fixedSize:
                  WidgetStateProperty.all(const Size(double.maxFinite, 57)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final cardNumber = _cardController.text;
                    final dateParts = _dateController.text.split('/');
                    final month = int.parse(dateParts[0]);
                    final year = int.parse(dateParts[1]);
                    final expirationDate = DateTime(year, month);
                    final cvv = _cvvController.text;
                    final name = _nameController.text;

                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    if (userId != null) {
                      final card = PaymentCard(
                          id: FirebaseFirestore.instance.collection('tmp').doc().id,
                          userId: userId,
                          cardNumber: cardNumber,
                          cvv: cvv,
                          name: name,
                          date: expirationDate
                      );
                      await context.read<PaymentCubit>().addCard(card);
                      if (!context.mounted) return;
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  'Сохранить',
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
        ),
      ),
    );
  }
}
