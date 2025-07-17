import 'package:figma21/models/address.dart';
import 'package:figma21/screen/account_page/adress_page/pages/add_adress_page.dart';
import 'package:figma21/screen/account_page/adress_page/widgets/address_widget.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/address/address_cubit.dart';
import '../../../../theme/colors.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children:
                        addresses.map((address) => AddressWidget(
                          userId: uid!,
                          address: address,
                        )).toList(),
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
                        WidgetStateProperty.all(
                            const Size(double.maxFinite, 57)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push<
                            Map<String, dynamic>>(
                          context,
                          MaterialPageRoute(builder: (_) => AddAddressPage(phone: phoneNumber)),
                        );
                        if (result != null) {
                          final uid = FirebaseAuth.instance.currentUser?.uid;
                          if (uid != null) {
                            if (!context.mounted) return;
                            context.read<AddressCubit>().loadAddresses(uid);
                          }
                        }
                      },
                      child: Text(
                        'Добавить адрес',
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
              );
            }
        )
    );
  }

}
