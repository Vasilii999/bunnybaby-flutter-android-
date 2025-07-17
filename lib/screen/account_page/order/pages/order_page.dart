import 'package:figma21/screen/account_page/order/widgets/orders_widget.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/text_style.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мои заказы',
            style: f16w700.copyWith(
                height: 1.5,
                letterSpacing: 0.5,
                fontFamily: 'Poppins',
                color: dark)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: light,
          ),
        ),
      ),
      body: const OrdersWidget(),
    );
  }
}