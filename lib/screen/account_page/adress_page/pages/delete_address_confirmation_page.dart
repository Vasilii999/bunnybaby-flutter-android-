import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class DeleteAddressConfirmation extends StatelessWidget {
  const DeleteAddressConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error,size: 124,color: pink,),
            const SizedBox(height: 15,),
            Text('Внимание!',style: f24w700.copyWith(color: dark,fontFamily: 'Poppins',height: 1.5,letterSpacing: 0.5),),
            const SizedBox(height: 10,),
            Text('Вы действительно хотите удалить адрес?',style: f13w400.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),),
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
                    Navigator.pop(context, true);
                  },
                  child: Text(
                    'Удалить',
                    style: f14w700.copyWith(color: white,letterSpacing: 0.5,height: 1.8,fontFamily: 'Poppins',),
                  )
              ),
            ),
            const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStateProperty.all(0),
                fixedSize: WidgetStateProperty.all(
                    const Size(double.maxFinite, 57)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),side: const BorderSide(width: 1,color: light)),),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                'Отмена',
                style: f14w700.copyWith(color: grey,letterSpacing: 0.5,height: 1.8,fontFamily: 'Poppins',),
              )
          ),
          ),
          ],
        ),
      ),
    );
  }
}
