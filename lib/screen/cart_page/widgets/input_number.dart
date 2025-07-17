
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../theme/colors.dart';

class InputNumber extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const InputNumber({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 104,
      decoration: BoxDecoration(border: Border.all(color: light, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onIncrement,
              child: SvgPicture.asset(
                'assets/svg/system_icon/16px/Minus.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: light,
              alignment: Alignment.center,
              child: Text(
                '$quantity',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: onDecrement,
              child: SvgPicture.asset(
                'assets/svg/system_icon/16px/Plus.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}