import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class ChangeNamePage extends StatefulWidget {
  final String initialFirstName;
  final String initialLastName;

  const ChangeNamePage({super.key, required this.initialFirstName, required this.initialLastName});

  @override
  State<ChangeNamePage> createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialFirstName);
    _lastNameController = TextEditingController(text: widget.initialLastName);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
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
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Имя',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Пожалуйста, Введите имя';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Фамилия',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 4,),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Пожалуйста, Введите Фамилию';
                      }
                      return null;
                    },
                  ),
                ],
              ),
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
                  if (_formKey.currentState!.validate()) {
                    final result = '${_lastNameController.text} ${_firstNameController.text}'.trim();
                    Navigator.pop(context, result);
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
    );
  }
}
