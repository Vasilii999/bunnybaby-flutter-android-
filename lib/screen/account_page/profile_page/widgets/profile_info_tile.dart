import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';

class ProfileInfoTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  const ProfileInfoTile({
      super.key,
      required this.icon,
      required this.title,
      required this.value,
      this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 16,),
            Expanded(
                child: Text(title,
                style: f14w700.copyWith(color: dark,fontFamily: 'Poppins',height: 1.5,letterSpacing: 0.5),
                ),
            ),
            Text(value,
            style: f12w400.copyWith(color: grey,fontFamily: 'Poppins',letterSpacing: 0.5,height: 1.8),
            ),
            const SizedBox(width: 8,),
            const Icon(Icons.chevron_right,color: Colors.grey,),
          ],
        ),
      ),
    );
  }
}
