
import 'package:figma21/core/exports.dart';
import 'package:figma21/screen/account_page/order/pages/detail_order_page.dart';
import 'package:flutter/material.dart';

import '../../../../cubit/order/order_cubit.dart';
import '../../../../cubit/order/order_state.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  String? uid;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    uid = user?.uid;
    if (uid != null) {
      context.read<OrderCubit>().loadOrders(uid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderCubit>().state;
    if (state.status == OrderStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if ( state.allOrders.isEmpty) {
      return const Center(child: Text('У вас нет заказов'));
    }

    return ListView.builder(
      itemCount: state.allOrders.length,
      itemBuilder: (context, index) {
        final order = state.allOrders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DetailOrderPage(order: order)));
            },
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: light, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.id,style: f16w700.copyWith(height: 1.5, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
                    const SizedBox(height: 16,),
                    Text('Дата заказа: ${order.formattedDate}',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
                    const SizedBox(height: 24,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Статус',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
                        Text(order.status.name,style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
                      ],),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Количество',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
                        Text('${order.itemCount}',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: dark)),
                      ],),
                    const SizedBox(height: 8,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Цена',style: f12w400.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: grey)),
                        Text('${order.totalAmount.round()} сом',style: f14w700.copyWith(height: 1.8, letterSpacing: 0.5, fontFamily: 'Poppins', color: red)),
                      ],),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
