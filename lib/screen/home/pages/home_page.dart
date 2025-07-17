import 'package:figma21/screen/account_page/account_page.dart';
import 'package:figma21/screen/cart_page/pages/cart_page.dart';
import 'package:figma21/screen/categories/pages/categories_page.dart';
import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_content_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Обновляем текущий индекс
    });
  }

  late List<Widget> _pages;

    @override
    void initState() {
      super.initState();
      _pages = [
        HomeContent(
          onCategorySelected: (int index) {
            _onTabTapped(index);
          },
        ),
        const CategoriesPage(),
        const BasketPage(),
        const AccountPage(),
      ];
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar:
      Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            selectedItemColor: pink,
            selectedIconTheme: const IconThemeData(color: pink),
            selectedLabelStyle: f10w400.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins'),
            unselectedItemColor: grey,
            unselectedLabelStyle: f10w400.copyWith(height: 1.5,letterSpacing: 0.5,fontFamily: 'Poppins'),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/system_icon/24px/Home.svg',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Главная'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/system_icon/24px/Search.svg',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Категории'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/system_icon/24px/Cart.svg',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Корзина'),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/system_icon/24px/User.svg',
                    width: 24,
                    height: 24,
                  ),
                  label: 'Аккаунт'),
            ],
          ),
      ),

    );
  }
}


