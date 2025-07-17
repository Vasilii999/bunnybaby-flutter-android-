import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../theme/colors.dart';

class EmailChangePage extends StatefulWidget {
  final String? initialEmail;
  const EmailChangePage({super.key, this.initialEmail});


  @override
  State<EmailChangePage> createState() => _EmailChangePageState();
}

class _EmailChangePageState extends State<EmailChangePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  String? email;

  @override
  void initState(){
    super.initState();
    email = widget.initialEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Мои данные',
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Смена электронной почты',
                      style: f14w700.copyWith(
                          height: 1.5,
                          letterSpacing: 0.5,
                          fontFamily: 'Poppins',
                          color: dark)),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: light, width: 1)),
                      contentPadding: const EdgeInsets.all(16),
                      hintText: email,
                      hintStyle: f12w700.copyWith(
                          color: grey,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          height: 1.8),
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            'assets/svg/system_icon/24px/Message.svg',
                            width: 24,
                            height: 24,
                          )),
                    ),
                    style: f12w700.copyWith(
                        color: grey,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                        height: 1.8),
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
            const Spacer(),
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
                    if (_formKey.currentState!.validate()) {
                      final result = _emailController.text;
                      Navigator.pop(context,result);
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
      ),
    );
  }
}
