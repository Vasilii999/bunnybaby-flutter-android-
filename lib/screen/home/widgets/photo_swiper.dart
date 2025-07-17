import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import '../../../theme/colors.dart';

class PhotoSwiper extends StatelessWidget {
  final List<String> imagePaths;

  const PhotoSwiper({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 250, // Высота свайпера
        child: Swiper(
          itemCount: imagePaths.length,
          autoplay: false,
          pagination: const SwiperPagination(
            margin: EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: pink,
              color: light,
              size: 8,
              activeSize: 8,
            ),
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  imagePaths[index],
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
