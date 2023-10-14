import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_image_screen.dart';

// PhotoScreen
class PhotoScreen extends StatefulWidget {
  PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getMyPhotos();
    _scrollController.addListener(() {
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent && !AppCubit.get(context).isLastMyPhoto){
          AppCubit.get(context).getMyPhotosFromLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(lang=='en'?'Photos':'الصور'),
          ),
          body: AppCubit.get(context).myPhotos.isNotEmpty
              ? GridView.count(
            controller: _scrollController,
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.69,
            children: AppCubit.get(context).myPhotos
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
          photos:AppCubit.get(context).myPhotos,
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