import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import '../../home/pages/home_page.dart';

class SuccessScreenCart extends StatelessWidget {
  const SuccessScreenCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/icon_checked.png',width: 72,),
            const SizedBox(height: 15,),
            Text('Успешная оплата',style: f24w700.copyWith(color: dark,fontFamily: 'Poppins',height: 1.5,letterSpacing: 0.5),),
            const SizedBox(height: 10,),
            Text('Спасибо за покупку',style: f13w400.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    'Вернуться на главную',
                    style: f14w700.copyWith(color: white,letterSpacing: 0.5,height: 1.8,fontFamily: 'Poppins',),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
