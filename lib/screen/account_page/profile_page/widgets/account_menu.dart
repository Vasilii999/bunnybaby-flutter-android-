import 'package:figma21/screen/account_page/payment_methods/pages/payment_page.dart';
import 'package:figma21/screen/account_page/adress_page/pages/address_page.dart';
import 'package:figma21/theme/colors.dart';
import 'package:figma21/screen/account_page/order/pages/order_page.dart';
import 'package:figma21/screen/account_page/profile_page/profile_page.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountMenu extends StatefulWidget {
  const AccountMenu({super.key});

  @override
  State<AccountMenu> createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {

  int _selectedIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {'icon':SvgPicture.asset('assets/svg/system_icon/24px/User.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),'label': 'Профиль','page' : const ProfilePage()},
    {'icon':SvgPicture.asset('assets/svg/system_icon/24px/bag.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),'label': 'Мои заказы','page' : const OrderPage()},
    {'icon':SvgPicture.asset('assets/svg/system_icon/24px/Location.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),'label': 'Адреса','page' : const AddressPage()},
    {'icon':SvgPicture.asset('assets/svg/system_icon/24px/Credit Card.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),'label': 'Методы оплаты','page' : const PaymentPage()},
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
