import 'package:flutter/material.dart';

import '../../constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isArabic = lang == 'ar';
    return  Center(
      child: Text(
        isArabic?'صفحه الدردشات':'Chat Screen',
        style:const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
