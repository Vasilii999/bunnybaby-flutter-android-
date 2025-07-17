import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../theme/colors.dart';

class PhoneNumberChangePage extends StatefulWidget {
  final String? initialPhone;
  const PhoneNumberChangePage({super.key, this.initialPhone});

  @override
  State<PhoneNumberChangePage> createState() => _PhoneNumberChangePageState();
}

class _PhoneNumberChangePageState extends State<PhoneNumberChangePage> {
  String? selectedPhone;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  final maskFormatter = MaskTextInputFormatter(
    mask: '+996 (###) ###-###',
    filter: {"#": RegExp(r'\d')},
  );

  @override
  void initState(){
    super.initState();
    selectedPhone = widget.initialPhone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Мои данные',style: f16w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark),),
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
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Номер телефона',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [maskFormatter],
                    style: f12w400.copyWith(color: grey),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      hintText: selectedPhone,
                      hintStyle: f12w700.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
                      prefixIcon: Padding(padding: const EdgeInsets.all(12), child: SvgPicture.asset('assets/svg/system_icon/24px/Phone.svg',width: 24,height: 24,)),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: light,width: 1,),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: light,width: 1,),
                      ),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Пожалуйста, Введите номер';
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
                    shadowColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.24)),
                    backgroundColor: WidgetStateProperty.all(pink),
                    fixedSize: WidgetStateProperty.all(
                        const Size(double.maxFinite, 57)),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      final result = _phoneController.text;
                      Navigator.pop(context,result);
                    }
                  },
                  child: Text(
                    'Сохранить',
                    style: f14w700.copyWith(color: white,letterSpacing: 0.5,height: 1.8,fontFamily: 'Poppins',),
                  )
              ),
            ),
            const SizedBox(height: 24,)
          ],
        ),
      ),
    );
  }
}

