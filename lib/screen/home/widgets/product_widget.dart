import 'package:figma21/core/exports.dart';
import 'package:figma21/screen/home/widgets/product_detail_page.dart';
import 'package:figma21/screen/home/widgets/evaluation_star.dart';
import 'package:flutter/material.dart';


class ProductWidget extends StatelessWidget {
  final List<ProductFirebase> products;

  const ProductWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1 / 2,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductDetailPage(product: product),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: light,width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1, // квадратное изображение
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        product.imageUrls.first,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    product.name,
                  style: f15w700.copyWith(color: dark,fontFamily: 'Poppins',height: 1.5,letterSpacing: 0.5),
                  ),
                  const SizedBox(height: 8,),
                  EvaluationStar(rating: product.rating),
                  const SizedBox(height: 8,),
                  Text('${(product.price * (100 - product.discount) / 100).round()} сом',
                      style: f14w700.copyWith(color: pink,fontFamily: 'Poppins',height: 1.5,letterSpacing: 0.5)),
                  const SizedBox(height: 8,),
                  Row(
                    children: [
                      Text('${product.price}',style: f14w700.copyWith(color: grey,height: 1.5,letterSpacing: 0.5,decoration: TextDecoration.lineThrough,fontFamily: 'Poppins')),
                      const SizedBox(width: 8,),
                      Text('${product.discount}%',style: f14w700.copyWith(color: pink,fontFamily: 'Poppins',height: 1.5,letterSpacing: 0.5)),
                    ],
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
