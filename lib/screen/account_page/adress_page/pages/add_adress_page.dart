import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/cubit/address/address_cubit.dart';
import 'package:figma21/models/address.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/colors.dart';

class AddAddressPage extends StatefulWidget {
  final String phone;
  const AddAddressPage({super.key, required this.phone});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {


  final _formKey = GlobalKey<FormState>();

  final TextEditingController _addressNameController = TextEditingController();

  final TextEditingController _address2NameController = TextEditingController();

  final TextEditingController _cityNameController = TextEditingController();

  final TextEditingController _regionNameController = TextEditingController();

  final TextEditingController _indexNameController = TextEditingController();

  @override
  void dispose() {
    _addressNameController.dispose();
    _address2NameController.dispose();
    _cityNameController.dispose();
    _regionNameController.dispose();
    _indexNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление адреса',
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
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Адрес',
                      style: f14w700.copyWith(
                          height: 1.5,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          color: dark)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _addressNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(
                        color: grey,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                        height: 1.8),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, Введите адрес';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Адрес 2 (необязательно)',
                      style: f14w700.copyWith(
                          height: 1.5,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          color: dark)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _address2NameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(
                        color: grey,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                        height: 1.8),
                  ),
                  const SizedBox(height: 16),
                  Text('Город',
                      style: f14w700.copyWith(
                          height: 1.5,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          color: dark)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _cityNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(
                        color: grey,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                        height: 1.8),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, Введите адрес';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Область/Регион',
                      style: f14w700.copyWith(
                          height: 1.5,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          color: dark)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _regionNameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(
                        color: grey,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                        height: 1.8),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, Введите Область/Регион';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Индекс',
                      style: f14w700.copyWith(
                          height: 1.5,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          color: dark)),
                  const SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _indexNameController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    decoration: const InputDecoration(
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(
                        color: grey,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                        height: 1.8),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, Введите Индекс';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
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
                    final address1 = _addressNameController.text;
                    final address2 = _address2NameController.text;
                    final city = _cityNameController.text;
                    final region = _regionNameController.text;
                    final index = _indexNameController.text;

                    final userId = FirebaseAuth.instance.currentUser?.uid;
                    if (userId != null) {
                      final address = Address(
                          id: FirebaseFirestore.instance
                              .collection('tmp')
                              .doc()
                              .id,
                          address: address1,
                          address2: address2,
                          city: city,
                          region: region,
                          index: index,
                        phone: widget.phone,
                      );
                      await context.read<AddressCubit>().addAddress(address,userId);
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
                )),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
