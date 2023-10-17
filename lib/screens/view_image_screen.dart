import 'dart:ui';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewImagesScreen extends StatefulWidget {
  const ViewImagesScreen({
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
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    activeIndex = widget.selectedIndex;
    pageController = PageController(initialPage: widget.selectedIndex);

    // Listen to page changes and update the activeIndex
    pageController.addListener(() {
      setState(() {
        activeIndex = pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            clipBehavior: Clip.none,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: lang == 'en'
                  ? const EdgeInsets.only(top: 18.0, left: 18)
                  : const EdgeInsets.only(top: 18.0, right: 18),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  IconlyBold.close_square,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            ),
          ),
          bottomNavigationBar: SingleChildScrollView(
            child: Container(
              color: const Color.fromARGB(74, 62, 62, 62),
              width: double.infinity,
              height: size.height * 0.15,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.photos.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 11,
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                activeIndex = index;
                              });
                              pageController.jumpToPage(activeIndex);
                            },
                            child: Container(
                              height: activeIndex == index
                                  ? size.height * 0.12
                                  : size.height * 0.1,
                              width: activeIndex == index
                                  ? size.width * 0.25
                                  : size.width * 0.22,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Image.network(
                                widget.photos[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(
                  widget.photos[activeIndex],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 7,
                  sigmaX: 7,
                ),
                child: Container(
                  color: const Color.fromARGB(91, 2, 30, 49),
                  child: Center(
                    child: PhotoViewGallery.builder(
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      itemCount: widget.photos.length,
                      builder: (context, index) {
                        return PhotoViewGalleryPageOptions(
                          imageProvider: NetworkImage(widget.photos[index]),
                          minScale: PhotoViewComputedScale.contained,
                          maxScale: PhotoViewComputedScale.covered * 2,
                        );
                      },
                      pageController: pageController,
                      onPageChanged: (index) {
                        // Update the activeIndex when swiping
                        setState(() {
                          activeIndex = index;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
