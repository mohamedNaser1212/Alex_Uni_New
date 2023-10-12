import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_image_screen.dart';

// PhotoScreen
class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key,required this.photos});

  final List<String> photos;

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(lang=='en'?'Photos':'الصور'),
          ),
          body: widget.photos.isNotEmpty
              ? GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.69,
            children: widget.photos
                .asMap()
                .entries
                .map((entry) => buildPhotoItem(entry.key, entry.value))
                .toList(),
          )
              : const Center(
            child: Text(
              'No Photos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPhotoItem(int index, String image) => InkWell(
    onTap: () {
      navigateTo(
        context: context,
        screen: ViewImagesScreen(
          photos: widget.photos,
          selectedIndex: index,
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(1),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    ),
  );
}