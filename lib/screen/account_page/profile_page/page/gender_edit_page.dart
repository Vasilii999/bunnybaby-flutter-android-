import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../../theme/colors.dart';

class GenderPage extends StatefulWidget {
  final String? initialGender;
  const GenderPage({super.key, this.initialGender});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? selectedGender;
  final List<String> genders = ['Мужской', 'Женский'];

  @override
  void initState() {
    super.initState();
    selectedGender = widget.initialGender;
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Выберите пол',
                    style: f14w700.copyWith(
                        height: 1.5,
                        letterSpacing: 0.5,
                        fontFamily: 'Poppins',
                        color: dark)),
                const SizedBox(
                  height: 4,
                ),
                DropdownButtonFormField2<String>(
                  value: selectedGender,
                  isExpanded: true,
                  hint: Text(
                    'Не выбрано',
                    style: f12w700.copyWith(
                      color: grey,
                      fontFamily: 'Poppins',
                      letterSpacing: 0.5,
                      height: 1.8,
                    ),
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: light, width: 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: pink, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  style: f12w700.copyWith(
                    color: grey,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.5,
                    height: 1.8,
                  ),
                  dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: light, width: 1),
                      ),
                      elevation: 0,
                      offset: const Offset(0, -8),
                      padding: const EdgeInsets.only(left: 8)),
                  items: genders.map((String gender) {
                    final isSelected = selectedGender == gender;
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(
                          gender,
                        style: f12w700.copyWith(
                          color: isSelected ? pink : grey,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          height: 1.8,
                        ),
                      ),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return genders.map((String gender) {
                      return Text(
                        gender,
                        style: f12w700.copyWith(
                          color: grey,
                          fontFamily: 'Poppins',
                          letterSpacing: 0.5,
                          height: 1.8,
                        ),
                      );
                    }).toList();
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.only(left: 12),
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
                  shadowColor:
                      WidgetStateProperty.all(Colors.blue.withOpacity(0.24)),
                  backgroundColor: WidgetStateProperty.all(pink),
                  fixedSize:
                      WidgetStateProperty.all(const Size(double.maxFinite, 57)),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
                ),
                onPressed: () {
                  if (selectedGender != null) {
                    Navigator.pop(context, selectedGender);
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
    );
  }
}
