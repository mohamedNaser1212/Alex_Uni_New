import 'package:flutter/material.dart';


class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key});


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 2.6 / 4,
        child: Image.asset(
          'assets/images/Waiting-image.png',
          fit: BoxFit.cover,

        ),

      ),

    );

  }
}

