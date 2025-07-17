import 'package:figma21/theme/colors.dart';
import 'package:figma21/theme/text_style.dart';
import 'package:flutter/material.dart';

class NotificationActivityPages extends StatefulWidget {
  const NotificationActivityPages({super.key});

  @override
  State<NotificationActivityPages> createState() => _NotificationActivityPagesState();
}

class _NotificationActivityPagesState extends State<NotificationActivityPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Уведомления',style: f16w700.copyWith(color: dark,fontFamily: 'Poppins'),),
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
            Text('Уведомлений нет'),
          ],
        ),
      ),
    );
  }
}
