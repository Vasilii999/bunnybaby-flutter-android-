import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../theme/colors.dart';

class EditAddressPage extends StatefulWidget {
  final String addressId;
  final String userId;
  final Map<String, String> initialData;

  const EditAddressPage({super.key, required this.initialData, required this.addressId, required this.userId});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController _addressNameController = TextEditingController();

  late TextEditingController _address2NameController = TextEditingController();


  late TextEditingController _cityNameController = TextEditingController();


  late TextEditingController _regionNameController = TextEditingController();


  late TextEditingController _indexNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _addressNameController = TextEditingController(text: widget.initialData['address']);
    _address2NameController = TextEditingController(text: widget.initialData['address2']);
    _cityNameController = TextEditingController(text: widget.initialData['city']);
    _regionNameController = TextEditingController(text: widget.initialData['region']);
    _indexNameController = TextEditingController(text: widget.initialData['index']);
  }

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
      appBar: AppBar(title: Text('Редактирование адреса',style: f16w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
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
                  Text('Адрес',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _addressNameController,
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
                        return 'Пожалуйста, Введите Адрес';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Адрес 2 (необязательно)',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _address2NameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
                  ),
                  const SizedBox(height: 16),
                  Text('Город',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _cityNameController,
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
                        return 'Пожалуйста, Введите Город';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Область/Регион',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _regionNameController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Пожалуйста, Введите Область/Регион';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text('Индекс',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                  const SizedBox(height: 12,),
                  TextFormField(
                    controller: _indexNameController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    maxLength: 6,
                    decoration: const InputDecoration(
                      counterText: '',
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: light,width: 1)),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: f12w700.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
                    validator: (value) {
                      if(value == null || value.isEmpty){
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
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    final address = _addressNameController.text;
                    final address2 = _address2NameController.text;
                    final city =_cityNameController.text;
                    final region =_regionNameController.text;
                    final index = _indexNameController.text;

                    try{
                    await FirebaseFirestore.instance.collection('users').doc(widget.userId).collection('addresses').doc(widget.addressId).update({
                      'address': address,
                      'address2': address2,
                      'city': city,
                      'region': region,
                      'index': index,
                    });
                    if (!context.mounted) return;
                    Navigator.pop(context,{'update' : true});
                  } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Ошибка сохранения: $e'),
                      ));
                    }
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
