// ignore_for_file: must_be_immutable

import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewImagesScreen extends StatefulWidget {
  ViewImagesScreen(
      {Key? key,
        required this.view,
        required this.index1,
        required this.id,
        this.index2})
      : super(key: key);

  final List? view;
  int? index1;
  final List? id;
  int? index2;

  @override
  State<ViewImagesScreen> createState() => _ViewImagesScreenState();
}

class _ViewImagesScreenState extends State<ViewImagesScreen> {
  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage:widget.index2!);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: PhotoViewGallery.builder(
              itemCount: widget.view![widget.index1!].values.single.image.length ,
              loadingBuilder: (context, index) => const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
              pageController: pageController,
              onPageChanged: (index) {
                setState(() {
                  widget.index2 = index;
                });
              },
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: NetworkImage(widget.view![widget.index1!].values.single
                      .image[widget.index2!]) ,
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
