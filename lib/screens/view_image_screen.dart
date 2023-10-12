// ignore_for_file: must_be_immutable

import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// ViewImagesScreen
class ViewImagesScreen extends StatefulWidget {
  ViewImagesScreen({
    Key? key,
    required this.photos,
    this.selectedIndex = 0,
  }) : super(key: key);

  final int selectedIndex;
  final List<String> photos;

  @override
  State<ViewImagesScreen> createState() => _ViewImagesScreenState();
}


class _ViewImagesScreenState extends State<ViewImagesScreen> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: PhotoViewGallery.builder(
              itemCount: widget.photos.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.photos[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              backgroundDecoration: const BoxDecoration(
                color: Color(0xffE6EEFA),
              ),
              pageController: pageController,
              onPageChanged: (index) {

              },
            ),
          ),
        );
      },
    );
  }
}
