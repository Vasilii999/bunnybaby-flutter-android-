import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../theme/colors.dart';

class BirthdayChangePage extends StatefulWidget {
  final DateTime? initialBirthday;
  const BirthdayChangePage({super.key, this.initialBirthday});

  @override
  State<BirthdayChangePage> createState() => _BirthdayChangePageState();
}

class _BirthdayChangePageState extends State<BirthdayChangePage> {

  DateTime? selectedDate;

  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialBirthday;
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
          Padding(
            padding: const EdgeInsets.all(16),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Дата Вашего рождения',style: f14w700.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins',color: dark)),
                const SizedBox(height: 4,),
                GestureDetector(
                  onTap: () async{
                    DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime(2000, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      builder: (context,child){
                          return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: pink,
                                  onPrimary: white,
                                  onSurface: dark,
                                ),
                              ),
                              child: child!,
                          );
                      },
                    );
                    if(picked != null){
                      setState(() {
                        selectedDate = picked;
                        _dateController.text = '${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        hintText: selectedDate != null
                        ? DateFormat('dd.MM.yyyy').format(selectedDate!)
                        : 'Не выбрано',
                        hintStyle: f12w700.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: light,width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: grey,width: 1),
                        ),
                        suffixIcon: Padding(padding: const EdgeInsets.all(12), child: SvgPicture.asset('assets/svg/system_icon/24px/Date.svg',width: 24,height: 24,)),
                      ),
                      style: f12w400.copyWith(
                        color: grey,fontFamily: 'Poppins', height: 1.8,letterSpacing: 0.5
                      ),
                    ),
                  ),
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
                  if (selectedDate != null) {
                    Navigator.pop(context,selectedDate);
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

