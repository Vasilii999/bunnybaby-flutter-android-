import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:figma21/widgets/categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../notifications/pages/notification_activity_pages.dart';

class CategoriesPage extends StatefulWidget {
  final Function(int)? onCategorySelected;

  const CategoriesPage({super.key, this.onCategorySelected});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  int notificationCount = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          keyboardType: TextInputType.text,
          style: f12w400.copyWith(color: grey),
          decoration: InputDecoration(
            hintText: 'Поиск продуктов',
            hintStyle: f13w400.copyWith(color: grey),
            prefixIcon: Padding( padding: const EdgeInsets.all(14),child: SvgPicture.asset('assets/svg/system_icon/16px/Search.svg',width: 16,height: 16,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn))),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: light,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: light,
                )),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {

              },
              icon: SvgPicture.asset('assets/svg/system_icon/24px/love.svg',width: 24,height: 24,)),
          // уведомления notificationCount для примера, если уведомления есть то в стеке, если нет просто иконка
          notificationCount > 0
              ? Stack(
            children: [
              IconButton(
                icon: SvgPicture.asset('assets/svg/system_icon/24px/Notification.svg',width: 24,height: 24,),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const NotificationActivityPages(),));
                  setState(() {
                    notificationCount = 0;
                  });
                },
              ),
              Positioned(
                right: 14,
                top: 14,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: pink,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 5,
                    minHeight: 5,
                  ),
                ),
              ),
            ],
          )
              : IconButton(
            icon: SvgPicture.asset('assets/svg/system_icon/24px/Notification.svg',width: 24,height: 24,),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const NotificationActivityPages(),));
              setState(() {
                notificationCount = 3;
              });
            },
          ),
        ],
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
          Expanded(
            child: Column(
              children: [
                CategoriesWidget(contextSource: 'categories', onCategorySelected: widget.onCategorySelected),
              ],
            ),
          )
        ],
      ),
    );
  }
}
