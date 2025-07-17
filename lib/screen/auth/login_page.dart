import 'package:figma21/theme/colors.dart';
import 'package:figma21/screen/auth/otp_enter_page.dart';
import 'package:figma21/screen/auth/register_form_page.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../cubit/auth/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    mask: '+996 (###) ###-###',
    filter: {"#": RegExp(r'\d')},
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthCodeSent) {
          final phone =
              _phoneController.text.replaceAll(RegExp(r'[^0-9+]'), '');
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => OtpEnter(
                      phone: phone,
                      name: '',
                      email: '',
                      isLogin: true,
                    )),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              const SizedBox(
                height: 39,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: 206,
              ),
              Text(
                'Добро пожаловать в BunnyBaby',
                style: f16w700.copyWith(
                  color: dark,
                  letterSpacing: 0.5,
                  height: 1.5,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Войти',
                style: f12w400.copyWith(
                    color: grey, letterSpacing: 0.5, height: 1.8),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [maskFormatter],
                  style: f12w400.copyWith(color: grey),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '+996(123) 456-789',
                    hintStyle: f13w400.copyWith(color: grey),
                    prefixIcon: const Icon(
                      Icons.phone_android_sharp,
                      color: pink,
                    ),
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
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const SizedBox(
                          height: 57,
                          child: Center(
                              child: CircularProgressIndicator(color: pink)),
                        );
                      }
                      return ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(15),
                          shadowColor: WidgetStateProperty.all(
                              Colors.blue.withOpacity(0.24)),
                          backgroundColor: WidgetStateProperty.all(pink),
                          fixedSize: WidgetStateProperty.all(
                              const Size(double.maxFinite, 57)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                        ),
                        onPressed: () {
                          final phone = _phoneController.text
                              .replaceAll(RegExp(r'[^0-9+]'), '');
                          context.read<AuthCubit>().sendCode(phone);
                        },
                        child: Text(
                          'Войти',
                          style: f14w700.copyWith(
                            color: white,
                            letterSpacing: 0.5,
                            height: 1.8,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      );
                    },
                  )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: light,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'или',
                        style: f15w700.copyWith(color: grey),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: light,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(15),
                      shadowColor: WidgetStateProperty.all(
                          Colors.blue.withOpacity(0.24)),
                      backgroundColor: WidgetStateProperty.all(pink),
                      fixedSize: WidgetStateProperty.all(
                          const Size(double.maxFinite, 57)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterForm()),
                      );
                    },
                    child: Text(
                      'Зарегистрироваться',
                      style: f14w700.copyWith(
                        color: white,
                        letterSpacing: 0.5,
                        height: 1.8,
                        fontFamily: 'Poppins',
                      ),
                    )),
              ),
              const SizedBox(
                height: 60,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Проблема со входом?',
                  style: f12w700.copyWith(
                      color: pink, height: 1.5, letterSpacing: 0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
