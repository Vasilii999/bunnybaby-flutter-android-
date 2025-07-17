import 'package:figma21/screen/account_page/payment_methods/pages/credit_card_page.dart';
import 'package:figma21/screen/cart_page/order/choose_credit_or_debit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/colors.dart';
import '../../../theme/text_style.dart';

class PaymentMethodMenu extends StatefulWidget {
  const PaymentMethodMenu({super.key});

  @override
  State<PaymentMethodMenu> createState() => _PaymentMethodMenuState();
}

class _PaymentMethodMenuState extends State<PaymentMethodMenu> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': SvgPicture.asset('assets/svg/system_icon/24px/Credit Card.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Кредитная карта VISA/MasterCard',
      'page' : const ChooseCreditOrDebitCard(),
    },
    {
      'icon':Image.asset('assets/images/Paypal.png',height: 24,width: 24),
      'label': 'Paypal',
      'page' : const CreditCardAndDebitPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context,index) {
          bool isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: (){
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => menuItems[index]['page']),
                );
                _selectedIndex = index;
              });
            },
            child: Container(
              color: isSelected ? Colors.lightBlue.withOpacity(0.04) : Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Row(
                children: [
                  menuItems[index]['icon'],
                  const SizedBox(width: 16,),
                  Text(
                    menuItems[index]['label'],
                    style: f12w700.copyWith(color: dark,letterSpacing: 0.5,height: 1.5,fontFamily: 'Poppins'),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}

