import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/screen/account_page/adress_page/pages/delete_address_confirmation_page.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../cubit/address/address_cubit.dart';
import '../../../../models/address.dart';
import '../../../../theme/colors.dart';
import '../pages/edit_address_page.dart';

class AddressWidget extends StatelessWidget {
  final Address address;
  final String userId;
  final bool isSelected;

  const AddressWidget({
    super.key,
    required this.address,
    required this.userId,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final address1 = address.address;
    final address2 = address.address2;
    final city = address.city;
    final region = address.region;
    final phone = address.phone ?? '';
    final index = address.index;

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 8, top: 8),
      child: Container(
        width: double.infinity,
        height: 218,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: pink)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Дом',
                    style: f14w700.copyWith(
                        color: dark,
                        fontFamily: 'Poppins',
                        letterSpacing: 0.5,
                        height: 1.5),
                  ),
                  if (isSelected)
                    const Icon(Icons.check_circle,color: pink,size: 20,),
                ],
              ),

              const SizedBox(height: 10),
              Text(
                'г.$city, $address1${(address2 != null && address2.trim().isNotEmpty) ? ', $address2' : ''}',
                style: f12w400.copyWith(
                    color: grey,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.5,
                    height: 1.8),
              ),
              const SizedBox(height: 10),
              Text(
                phone,
                style: f12w400.copyWith(
                    color: grey,
                    fontFamily: 'Poppins',
                    letterSpacing: 0.5,
                    height: 1.8),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        elevation: WidgetStateProperty.all(15),
                        shadowColor: WidgetStateProperty.all(
                            Colors.blue.withOpacity(0.24)),
                        backgroundColor: WidgetStateProperty.all(pink),
                        fixedSize: WidgetStateProperty.all(const Size(185, 57)),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditAddressPage(initialData: {
                              'address': address1,
                              'address2': address2 ?? '',
                              'city': city,
                              'region': region,
                              'index': index,
                            }, addressId: address.id, userId: userId),
                          ),
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
                        'Редактировать',
                        style: f14w700.copyWith(
                          color: white,
                          letterSpacing: 0.5,
                          height: 1.8,
                          fontFamily: 'Poppins',
                        ),
                      )),
                  const SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    onPressed: () async {
                      final confirm = await Navigator.push<bool>(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DeleteAddressConfirmation()),
                      );

                      if (confirm == true) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('addresses')
                            .doc(address.id)
                            .delete();
                        if (!context.mounted) return;
                        context.read<AddressCubit>().loadAddresses(userId);
                      }
                    },
                    icon: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          'assets/svg/system_icon/24px/Trash.svg',
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
