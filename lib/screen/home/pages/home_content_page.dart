import 'package:figma21/cubit/product/product_cubit.dart';
import 'package:figma21/cubit/product/product_state.dart';
import 'package:figma21/screen/notifications/pages/notification_activity_pages.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:figma21/widgets/categories_widget.dart';
import 'package:figma21/screen/home/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme/colors.dart';
import '../widgets/offer_banner.dart';
import 'package:figma21/core/exports_cubit.dart';

class HomeContent extends StatefulWidget {
  final Function(int)? onCategorySelected;
  const HomeContent({super.key, this.onCategorySelected});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  int notificationCount = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

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
            prefixIcon: Padding(padding: const EdgeInsets.all(14),
                child: SvgPicture.asset(
                    'assets/svg/system_icon/16px/Search.svg', width: 14,
                    height: 14,
                    colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn))),
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
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/system_icon/24px/love.svg', width: 24,
                height: 24,)),
          // уведомления notificationCount для примера, если уведомления есть то в стеке, если нет просто иконка
          notificationCount > 0
              ? Stack(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/svg/system_icon/24px/Notification.svg', width: 24,
                  height: 24,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (
                      context) => const NotificationActivityPages(),));
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
            icon: SvgPicture.asset(
              'assets/svg/system_icon/24px/Notification.svg', width: 24,
              height: 24,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => const NotificationActivityPages(),));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Padding(padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator(),),
                    );
                  } else if (state is ProductLoaded) {
                    return Column(
                      children: [
                        OfferBanner(productList: state.products),
                        CategoriesWidget(
                          contextSource: 'home',
                          onCategorySelected: widget.onCategorySelected,
                        ),
                        ProductWidget(products: state.products),
                      ],
                    );
                  } else if (state is ProductError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: red),
                      ));
                  }
                  return const SizedBox();
                }
            )
          ],
        ),
      ),
    );
  }
}

