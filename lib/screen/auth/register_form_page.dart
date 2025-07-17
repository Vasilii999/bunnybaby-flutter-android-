import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../theme/colors.dart';
import 'login_page.dart';
import 'otp_enter_page.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  
  final maskFormatter = MaskTextInputFormatter(
    mask: '+996 (###) ###-###',
    filter: {"#": RegExp(r'\d')},
  );

  // Переменные для хранения ошибок
  String? _nameError;
  String? _emailError;
  String? _phoneError;

  // Валидация имени
  void _validateName(String value) {
    if (value.isEmpty) {
      setState(() => _nameError = 'Введите имя');
    } else if (value.length < 2) {
      setState(() => _nameError = 'Слишком короткое имя');
    } else {
      setState(() => _nameError = null);
    }
  }

  // Валидация email
  void _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.isEmpty) {
      setState(() => _emailError = 'Введите email');
    } else if (!emailRegex.hasMatch(value)) {
      setState(() => _emailError = 'Некорректный email');
    } else {
      setState(() => _emailError = null);
    }
  }

  // Валидация телефона
  void _validatePhone(String value) {
    final unmasked = maskFormatter.getUnmaskedText();
    if (unmasked.isEmpty) {
      setState(() => _phoneError = 'Введите телефон');
    } else if (unmasked.length < 9) {
      setState(() => _phoneError = 'Некорректный номер');
    } else {
      setState(() => _phoneError = null);
    }
  }

  // Общая проверка формы
  void _submitForm() {
    _validateName(_nameController.text);
    _validateEmail(_emailController.text);
    _validatePhone(_phoneController.text);

    if (_nameError == null && _emailError == null && _phoneError == null) {
      final phone = maskFormatter.getUnmaskedText();
      final fullPhone = '+996$phone';

      context.read<AuthCubit>().sendCode(fullPhone);

      // Переход на OTP будет через слушатель в UI, при AuthCodeSent
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
      if (state is AuthCodeSent) {
        final phone = maskFormatter.getUnmaskedText();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpEnter(
              phone: '+996$phone',
              name: _nameController.text,
              email: _emailController.text,
              isLogin: false,
            ),
          ),
        );
      } else if (state is AuthFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children:[
              const SizedBox(height: 39,),
              Image.asset('assets/images/logo.png',width: 206,),
              Text('Регистрация',style: f16w700.copyWith(color: dark,letterSpacing: 0.5,height: 1.5,fontFamily: 'Poppins',),),
              const SizedBox(height: 10),
              Text('Создание профиля',style: f12w400.copyWith(color: grey,letterSpacing: 0.5,height: 1.8),),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  onChanged: _validateName,
                  style: f12w400.copyWith(color: grey),
                  decoration: InputDecoration(
                    errorText: _nameError,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: 'Айгуль Айбекова',
                    hintStyle: f13w400.copyWith(color: grey),
                    prefixIcon: const Icon(Icons.person_outline_outlined,color: pink,size: 24,),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: light,width: 1,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: light,width: 1,),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: _validateEmail,
                  style: f12w400.copyWith(color: grey),
                  decoration: InputDecoration(
                    errorText: _emailError,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: 'aigul@bunny-baby.kg',
                    hintStyle: f13w400.copyWith(color: grey),
                    prefixIcon: const Icon(Icons.email_outlined,color: pink,),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: light,width: 1,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: light,width: 1,),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [maskFormatter],
                  onChanged: _validatePhone,
                  style: f12w400.copyWith(color: grey),
                  decoration: InputDecoration(
                    errorText: _phoneError,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintText: '+996(123) 456-789',
                    hintStyle: f13w400.copyWith(color: grey),
                    prefixIcon: const Icon(Icons.phone_android_sharp,color: pink,),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: light,width: 1,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: light,width: 1,),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(15),
                      shadowColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.24)),
                      backgroundColor: WidgetStateProperty.all(pink),
                      fixedSize: WidgetStateProperty.all(
                          const Size(double.maxFinite, 57)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    onPressed:_submitForm,
                    child: Text(
                      'Зарегистрироваться',
                      style: f14w700.copyWith(color: white,letterSpacing: 0.5,height: 1.8,fontFamily: 'Poppins',),
                    )
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Уже зарегистрированы ?',
                    style: f12w700.copyWith(letterSpacing: 0.5,height: 1.5,color: grey,fontFamily: 'Poppins'),),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: Text('Войти',style: f12w700.copyWith(letterSpacing: 0.5,height: 1.5,color: pink,fontFamily: 'Poppins'),),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}