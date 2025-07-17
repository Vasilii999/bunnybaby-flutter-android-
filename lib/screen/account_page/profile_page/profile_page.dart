import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:figma21/screen/account_page/profile_page/page/birthday_edit_page.dart';
import 'package:figma21/screen/account_page/profile_page/page/edit_name_page.dart';
import 'package:figma21/theme/colors.dart';
import 'package:figma21/screen/account_page/profile_page/page/email_edit_page.dart';
import 'package:figma21/screen/account_page/profile_page/page/gender_edit_page.dart';
import 'package:figma21/screen/account_page/profile_page/page/phone_number_edit_page.dart';
import 'package:figma21/screen/account_page/profile_page/widgets/profile_info_tile.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:figma21/cubit/profile/profile_cubit.dart';
import 'package:figma21/models/user_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    final profileCubit = context.read<ProfileCubit>();
    if (profileCubit.state == null) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        FirebaseFirestore.instance.collection('users').doc(uid).get().then((doc) {
          if (doc.exists) {
            final userProfile = UserProfile.fromMap(doc.data()!);
            profileCubit.setProfile(userProfile);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, UserProfile?>(
      builder: (context, profile){
        if (profile == null){
          return const Center(child: CircularProgressIndicator());
        }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Профиль',
          style: f16w700.copyWith(fontFamily: 'Poppins', color: dark),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: light,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
            child: Row(
              children: [
                (profile.avatarUrl ?? '').isNotEmpty ? CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(profile.avatarUrl!),
                  backgroundColor: Colors.grey[200],
                )
                    : CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person_outline, size: 60),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () async {
                    final nameParts = profile.name.split(' ');
                    final lastName = nameParts.length > 1 ? nameParts.sublist(0, nameParts.length - 1).join(' ') : '';
                    final firstName = nameParts.isNotEmpty ? nameParts.last : '';

                    final result = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNamePage(
                          initialFirstName: firstName,
                          initialLastName: lastName,
                        ),
                      ),
                    );

                    if (result != null) {
                      if (!context.mounted) return;
                      context.read<ProfileCubit>().updateName(name: result);
                    }
                  },

                  child: Text(
                    profile.name,
                    style: f14w700.copyWith(
                      color: dark,
                      height: 1.5,
                      letterSpacing: 0.5,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProfileInfoTile(
              icon: SvgPicture.asset('assets/svg/system_icon/24px/Gender.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
              title: 'Пол',
              value: profile.gender,
              onTap: () async {
                final selectedGender = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(builder: (context) => GenderPage(initialGender: profile.gender,)),
                );
                if (selectedGender != null) {
                  if (!context.mounted) return;
                  context.read<ProfileCubit>().updateGender(selectedGender);
                }
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProfileInfoTile(
              icon: SvgPicture.asset('assets/svg/system_icon/24px/Date.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
              title: 'День рождения',
              value: profile.birthday != null
                  ? '${profile.birthday!.day.toString().padLeft(2, '0')}/${profile.birthday!.month.toString().padLeft(2, '0')}/${profile.birthday!.year}'
                  : 'Не указан',
              onTap: () async {
                final selectedBirthday = await Navigator.push<DateTime>(
                    context,
                    MaterialPageRoute(builder: (context) => BirthdayChangePage(initialBirthday: profile.birthday)),
                );
                if(selectedBirthday != null){
                  if (!context.mounted) return;
                  context.read<ProfileCubit>().updateBirthday(selectedBirthday);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProfileInfoTile(
              icon: SvgPicture.asset('assets/svg/system_icon/24px/Message.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
              title: 'E-Mail',
              value: profile.email,
              onTap: () async {
                final email = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmailChangePage(initialEmail: profile.email,)),
                );
                  if(email != null) {
                    if (!context.mounted) return;
                    context.read<ProfileCubit>().updateEmail(email);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProfileInfoTile(
              icon: SvgPicture.asset('assets/svg/system_icon/24px/Phone.svg',width: 24,height: 24,colorFilter: const ColorFilter.mode(pink, BlendMode.srcIn)),
              title: 'Номер телефона',
              value: profile.phone,
              onTap: () async {
                final phone = await Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => PhoneNumberChangePage(initialPhone: profile.phone)),
                );
                if(phone != null) {
                  if (!context.mounted) return;
                  context.read<ProfileCubit>().updatePhone(phone);
                }
              },
            ),
          ),
        ],
      ),
    );
      }
    );
  }
}
