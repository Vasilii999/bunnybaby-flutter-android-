import 'package:figma21/screen/account_page/profile_page/widgets/account_menu.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Аккаунт',style: f16w700.copyWith(color: dark,fontFamily: 'Poppins'),),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: light,
          ),
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            Expanded(
                child: AccountMenu(),
            ),
          ],
        ),
      ),
    );
  }
}
