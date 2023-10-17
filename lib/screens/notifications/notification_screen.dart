import 'package:alex_uni_new/constants/constants.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/University.png"),
          const SizedBox(
            height: 25,
          ),
          Text(
            lang == 'en' ? 'Empty Notifications' : 'لا يوجد اشعارات',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: defaultColor,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
            ),
          ),
          const SizedBox(
            height: 55,
          ),
        ],
      ),
    );
  }
}
