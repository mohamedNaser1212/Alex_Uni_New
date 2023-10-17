import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../view_image_screen.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key, required this.photos});

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
            title: Text(
              lang == 'en' ? 'Photos' : 'الصور',
              style: TextStyle(
                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                lang == 'en'
                    ? IconlyBold.arrow_left_circle
                    : IconlyBold.arrow_right_circle,
                color: defaultColor,
                size: 35,
              ),
            ),
            centerTitle: true,
          ),
          body: widget.photos.isNotEmpty
              ? StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  physics: const BouncingScrollPhysics(),
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildPhotoItem(index, widget.photos[index]),
                  itemCount: widget.photos.length,
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/University.png"),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          lang == 'ar'
                              ? "لا يوجد صور\n انت لم تقم بإضافة اي منشورات حتى الآن."
                              : "Empty photos\nYou haven't added any posts yet!!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: defaultColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 24,
                            fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                    ],
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
          margin: const EdgeInsets.all(8),
          height: index.isEven ? 200 : 240,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 140, 209, 255),
            borderRadius: BorderRadius.all(
              Radius.circular(23),
            ),
          ),
          child: Image.network(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      );
}
