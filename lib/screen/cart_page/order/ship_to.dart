import 'package:figma21/core/exports.dart';
import 'package:figma21/cubit/order/order_cubit.dart';
import 'package:figma21/cubit/order/order_state.dart';
import 'package:figma21/screen/account_page/adress_page/pages/add_adress_page.dart';
import 'package:figma21/screen/account_page/adress_page/widgets/address_widget.dart';
import 'package:figma21/screen/cart_page/order/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShipTo extends StatefulWidget {
  const ShipTo({super.key});

  @override
  State<ShipTo> createState() => _ShipToState();
}

class _ShipToState extends State<ShipTo> {
  late String phoneNumber;
  String? uid;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    phoneNumber = user?.phoneNumber ?? '';
    uid = user?.uid;
    if (uid != null) {
      context.read<AddressCubit>().loadAddresses(uid!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Мои адреса',
              style: f16w700.copyWith(
                  height: 1.5,
                  letterSpacing: 0.5,
                  fontFamily: 'Poppins',
                  color: dark)),
          actions: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.push<Map<String, dynamic>>(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AddAddressPage(phone: phoneNumber)),
                );
                if (result != null) {
                  final uid = FirebaseAuth.instance.currentUser?.uid;
                  if (uid != null) {
                    if (!context.mounted) return;
                    context.read<AddressCubit>().loadAddresses(uid);
                  }
                }
              },
              icon: SvgPicture.asset('assets/svg/system_icon/24px/Plus.svg',
                  colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
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
        body: BlocBuilder<AddressCubit, List<Address>>(
            builder: (context, addresses) {
          if (uid == null) {
            return const Center(child: Text('Пользователь не найден'));
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<OrderCubit, OrderState?>(
                    builder: (context, orderState) {
                      final selectedAddress = orderState?.address;
                      return Column(
                        children: addresses.map((address) {
                          final isSelected = selectedAddress?.id == address.id;
                          return GestureDetector(
                            onTap: () {
                              context.read<OrderCubit>().setAddress(address);
                            },
                            child: AddressWidget(
                              userId: uid!,
                              address: address,
                              isSelected: isSelected,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<OrderCubit, OrderState?>(
                    builder: (context, orderState) {
                      final selectedAddress = orderState?.address;
                  return ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(15),
                      shadowColor: WidgetStateProperty.all(
                          Colors.blue.withOpacity(0.24)),
                      backgroundColor: WidgetStateProperty.all(pink),
                      fixedSize: WidgetStateProperty.all(
                          const Size(double.maxFinite, 57)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    onPressed: selectedAddress == null ? null : () {
                            context.read<OrderCubit>().setAddress(selectedAddress);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const PaymentMethod()),
                            );
                          },
                    child: Text(
                      'Далее',
                      style: f14w700.copyWith(
                        color: white,
                        letterSpacing: 0.5,
                        height: 1.8,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
            ],
          );
        }));
  }
}
