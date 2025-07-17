import 'package:card_swiper/card_swiper.dart';
import 'package:figma21/core/exports.dart';
import 'package:flutter/material.dart';
import 'product_detail_page.dart';
import 'countdown_timer.dart';

class OfferBanner extends StatelessWidget {

  final List<ProductFirebase> productList;

  const OfferBanner({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 256,
      child: Swiper(
          itemCount: productList.length,
          autoplay: true,
          pagination: const SwiperPagination(
            margin: EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: pink,
              color: light,
              size: 8,
              activeSize: 8,
            ),
          ),
          //onTap: (){},
          itemBuilder: (context, index) {
            final product = productList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(product: product),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrls.first),
                      fit: BoxFit.cover,
                      colorFilter:
                          const ColorFilter.mode(Colors.grey, BlendMode.modulate),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24, top: 32),
                        child: Text(
                          '${product.name}\n${product.discount}% скидка',
                          style: f24w700.copyWith(
                              color: white, fontFamily: 'Poppins'),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        child: Row(
                          children: [
                            CountdownTimer(hours: 8),
                          ],
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}