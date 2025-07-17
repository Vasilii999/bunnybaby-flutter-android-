import 'package:figma21/screen/categories/pages/categories_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/colors.dart';
import '../theme/text_style.dart';

class CategoriesWidget extends StatefulWidget {
  final String contextSource;
  final Function(int)? onCategorySelected;

  const CategoriesWidget({super.key, this.contextSource = 'home', this.onCategorySelected});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final List<Map<String, dynamic>> categories = [
    {
      'icon': SvgPicture.asset('assets/svg/product_category/man/man pants.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Мужские\nштаны',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/man/shirt.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Мужские\nрубашки',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/man/man shoes.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Мужская\nобувь',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/man/Tshirt.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Мужские\nфутболки',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/man/man underwear.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Мужское\nнижнее бельё',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/woman/bikini.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Бикини',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/woman/dress.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Платья',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/woman/skirt.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Юбки',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/woman/woman bag.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Женские\nсумки',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/woman/woman pants.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Женские\nштаны',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/woman/woman shoes.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Женская\nОбувь',
      'page': const CategoriesPage(),
    },
    {
      'icon': SvgPicture.asset('assets/svg/product_category/woman/woman tshirt.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
      'label': 'Женские\nфутболки',
      'page': const CategoriesPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isInHome = widget.contextSource == 'home';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isInHome)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Категории',
                  style: f14w700.copyWith(
                      color: dark,
                      height: 1.5,
                      letterSpacing: 0.5,
                      fontFamily: 'Poppins'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Больше категорий',
                    style: f14w700.copyWith(
                        color: pink,
                        height: 1.5,
                        letterSpacing: 0.5,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Категории',
                  style: f14w700.copyWith(
                      color: dark,
                      height: 1.5,
                      letterSpacing: 0.5,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: SizedBox(
            height: 110,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return GestureDetector(
                    onTap: () {
                      if (widget.onCategorySelected != null) {
                        widget.onCategorySelected?.call(1); // например, 1 - индекс вкладки "Категории" в BottomNavigationBar
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: light, width: 1),
                            ),
                            child: Center(
                              child:
                                categories[index]['icon'],
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            item['label'],
                            style: f10w400.copyWith(
                              color: grey,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
