import 'package:alex_uni_new/constants/constants.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        lang == 'en' ? 'Notification Screen' : 'صفحه الاشعارات',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}