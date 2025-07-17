import 'package:figma21/core/exports.dart';
import 'package:figma21/screen/home/widgets/color_widget.dart';
import 'package:figma21/screen/home/widgets/evaluation_star.dart';
import 'package:figma21/screen/home/widgets/photo_swiper.dart';
import 'package:figma21/screen/home/widgets/size_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ProductDetailPage extends StatefulWidget {
  final ProductFirebase product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;
  String? selectedColor;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<String> sizesNumber = ['6', '6.5', '7', '7.5', '8', '8.5', '9', '9.5', '10'];
  final List<String> colors = ['Red', 'Black', 'White'];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: f16w700.copyWith(
              color: dark,
              fontFamily: 'Poppins',
              letterSpacing: 0.5,
              height: 1.5),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/svg/system_icon/24px/Search.svg',
                width: 24,
                height: 24,
              )),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/svg/system_icon/24px/More.svg')),
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhotoSwiper(imagePaths: product.imageUrls),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: f20w700.copyWith(
                              color: dark,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                              height: 1.5),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                                'assets/svg/system_icon/24px/love.svg')),
                      ],
                    ),
                    EvaluationStar(rating: product.rating),
                    const SizedBox(height: 8,),
                    Text('${(product.price * (100 - product.discount) / 100).round()} сом',
                        style: f20w700.copyWith(color: pink,fontFamily: 'Poppins',height: 1.5,letterSpacing: 0.5)),
                    const SizedBox(height: 16,),
                    SizeWidget(size: sizesNumber),
                    const SizedBox(height: 16,),
                    const ColorWidget(),
                    const SizedBox(height: 16,),
                    Text('Описание',style: f14w700.copyWith(color: dark,height: 1.5,letterSpacing: 0.5, fontFamily: 'Poppins'),),
                    const SizedBox(height: 16,),
                    Text('${product.description}',style: f12w400.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.5),),
                    const SizedBox(height: 16,),
                    Text('Отзывы',style: f14w700.copyWith(color: dark,height: 1.5,letterSpacing: 0.5, fontFamily: 'Poppins'),),
                  ],
                ),
              ),
            ),
          ),
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
                context.read<CartCubit>().addToCart(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Товар добалвен в корзину')),
                );
              },
              child: Text(
                'Добавить в корзину',
                style: f14w700.copyWith(
                  color: white,
                  letterSpacing: 0.5,
                  height: 1.8,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }
}
