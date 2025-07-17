import 'package:flutter/material.dart';

class EvaluationStar extends StatelessWidget {
  final double rating;

  const EvaluationStar({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        return Icon(
          Icons.star,
          size: 17,
          color: i < rating ? Colors.amber : Colors.grey.shade300,
        );
      }),
    );
  }
}