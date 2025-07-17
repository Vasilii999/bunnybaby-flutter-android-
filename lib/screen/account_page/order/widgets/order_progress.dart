import 'package:figma21/core/exports.dart';
import 'package:flutter/material.dart';

import '../../../../cubit/order/order_state.dart';

class OrderProgress extends StatelessWidget {
  final OrderStatus status;

  OrderProgress({super.key, required this.status});


  final List<String> steps = ['Обработка', 'Отправка', 'Доставка', 'Получение'];

  int get currentStep {
    switch (status) {
      case OrderStatus.processing:
        return 0;
      case OrderStatus.shipped:
        return 1;
      case OrderStatus.delivered:
        return 2;
      case OrderStatus.cancelled:
        return -1; // спец. случай — отмена
      default:
        return 0; // initial, loading, success, error — как начало
    }
  }

  @override
  Widget build(BuildContext context) {
    if (status == OrderStatus.cancelled) {
      return const Center(
        child: Text(
          'Заказ отменён',
          style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(steps.length, (index) {
                  final isCompleted = index <= currentStep;
                  return Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: isCompleted ? pink : light,
                          child: const Icon(Icons.check, size: 16, color: Colors.white),
                        ),
                        if (index != steps.length - 1)
                          Expanded(
                            child: Container(
                              height: 2,
                              color: index < currentStep ? pink : light,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: steps
                  .map((label) => Expanded(
                child: Text(
                  label,
                  style: f12w400.copyWith(color: grey),
                ),
              ))
                  .toList(),
            )
          ],
        ),
      );
  }
}