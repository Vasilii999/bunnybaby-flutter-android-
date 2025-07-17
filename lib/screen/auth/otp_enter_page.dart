import 'package:figma21/screen/home/pages/home_page.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../cubit/profile/profile_cubit.dart';
import '../../theme/colors.dart';

class OtpEnter extends StatefulWidget {
  final String phone;
  final String name;
  final String email;
  final bool isLogin;

  const OtpEnter({
    required this.phone,
    required this.name,
    required this.email,
    required this.isLogin,
    super.key,
  });

  @override
  State<OtpEnter> createState() => _OtpEnterState();
}

class _OtpEnterState extends State<OtpEnter> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthSuccess) {
          final authCubit = context.read<AuthCubit>();
          final profileCubit = context.read<ProfileCubit>();

          await authCubit.fetchProfileAfterAuth(profileCubit);

          if (!context.mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
            (_) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Center(
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
                'Введите одноразовый пароль из СМС',
                style: f12w400.copyWith(
                    color: grey, letterSpacing: 0.5, height: 1.8),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  //inputFormatters: [],
                  style: f12w400.copyWith(color: grey),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '001122',
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
              const SizedBox(height: 70),
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
                        if (widget.isLogin) {
                          context.read<AuthCubit>().verifyCodeForLogin(
                                smsCode: _otpController.text,
                                phone: widget.phone,
                              );
                        } else {
                          context.read<AuthCubit>().verifyCodeForRegistration(
                                smsCode: _otpController.text,
                                name: widget.name,
                                email: widget.email,
                                phone: widget.phone,
                                gender: '', // пустое, добавишь потом
                              );
                        }
                      },
                      child: Text(
                        'Продолжить',
                        style: f14w700.copyWith(
                          color: white,
                          letterSpacing: 0.5,
                          height: 1.8,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    );
                  })),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Не получили смс-код',
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
