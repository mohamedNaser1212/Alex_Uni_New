// ignore_for_file: avoid_print

import 'dart:io';
import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../models/posts/post_model.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({Key? key}) : super(key: key);

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  bool fontSizeReduced = false;
  bool isExpanded = false; // Track expansion state
  List<XFile> visibleImages = []; // Track visible images

  @override
  void initState() {
    super.initState();
    postTextController.addListener(() {
      setState(() {
        fontSizeReduced = postTextController.text.length > 23;
      });
    });
  }

  uploadWithoutImage({required BuildContext context}) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(now);

    PostModel model = PostModel(
      image: [],
      likes: [],
      userImage: AppCubit.get(context).user!.image!,
      userName: AppCubit.get(context).user!.name!,
      userId: AppCubit.get(context).user!.uId!,
      text: postTextController.text,
      date: formattedDate,
      showPost: !AppCubit.get(context).settings!.reviewPosts!,
      isReviewed: !AppCubit.get(context).settings!.reviewPosts!,
    );
    return FirebaseFirestore.instance.collection('posts').add({
      ...model.toMap(),
      'isShared': false,
    }).then((value) {
      AppCubit.get(context).getPosts();
      Navigator.pop(context);
      return value.path;
    });
  }

  TextEditingController postTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          if (AppCubit.get(context).currentIndex == 0) {
            AppCubit.get(context).getPosts();
          } else if (AppCubit.get(context).currentIndex == 3) {
            AppCubit.get(context).getMyPosts();
          }
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var profileImage = AppCubit.get(context).profileImage;
        var userModel = AppCubit.get(context).user;

        // Determine the list of visible images based on the expansion state
        if (isExpanded) {
          visibleImages = AppCubit.get(context).imageFileList;
        } else {
          visibleImages = AppCubit.get(context).imageFileList.take(4).toList();
        }

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: defaultColor,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Add new post',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                AppCubit.get(context).imageFileList.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(
                            () {
                              AppCubit.get(context).imageFileList = [];
                            },
                          );
                        },
                        icon: const Icon(
                          IconlyBold.delete,
                          color: Color.fromARGB(255, 248, 80, 68),
                        ),
                      )
                    : Container(),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  physics: const PageScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: const BoxDecoration(),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: profileImage == null
                                    ? NetworkImage(
                                        '${userModel?.image}',
                                      )
                                    : FileImage(profileImage) as ImageProvider,
                                radius: 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userModel?.name}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 17,
                                    ),
                                    decoration: BoxDecoration(
                                      color: defaultColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.public,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          const Text(
                                            "Public",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    onTap: () {
                                      AppCubit.get(context).selectImages();
                                    },
                                    child: AppCubit.get(context)
                                                .imageFileList
                                                .length <=
                                            99
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 17,
                                            ),
                                            decoration: BoxDecoration(
                                              color: defaultColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    IconlyBold.image_2,
                                                    color: Colors.white,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.02,
                                                  ),
                                                  Text(
                                                    AppCubit.get(context)
                                                            .imageFileList
                                                            .isEmpty
                                                        ? "Add Image"
                                                        : "Image No.",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                  ),
                                                  AppCubit.get(context)
                                                          .imageFileList
                                                          .isEmpty
                                                      ? const Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                          size: 16,
                                                        )
                                                      : Text(
                                                          "${AppCubit.get(context).imageFileList.length}",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 17,
                                            ),
                                            decoration: BoxDecoration(
                                              color: defaultColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    IconlyBold.image_2,
                                                    color: Colors.white,
                                                    size: 17,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.02,
                                                  ),
                                                  Text(
                                                    AppCubit.get(context)
                                                            .imageFileList
                                                            .isEmpty
                                                        ? "Add Image"
                                                        : "Image No.",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03,
                                                  ),
                                                  const Text(
                                                    "99+",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.007,
                      ),
                      TextFormField(
                        controller: postTextController,
                        style: TextStyle(
                          fontSize: fontSizeReduced ? 18 : 23,
                        ),
                        onChanged: (text) {
                          setState(
                            () {
                              fontSizeReduced =
                                  text.isNotEmpty && text.length > 25;
                            },
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Post body must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What\'s on your mind?',
                          hintStyle: TextStyle(
                            fontSize: fontSizeReduced ? 18 : 23,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: visibleImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: FullScreenWidget(
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.file(
                                        File(visibleImages[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      top: 9,
                                      right: 9,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            AppCubit.get(context)
                                                .imageFileList
                                                .removeAt(index);
                                          });
                                          print(
                                              "------------------DELETE ONE IMAGE------------------");
                                        },
                                        child: (index == 4 &&
                                                !isExpanded &&
                                                index <
                                                    AppCubit.get(context)
                                                            .imageFileList
                                                            .length -
                                                        1)
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isExpanded = true;
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 13,
                                                  child: Text(
                                                    "${AppCubit.get(context).imageFileList.length - 3}",
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 13,
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 19,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    0,
                    20,
                    MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: double.infinity,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (AppCubit.get(context).imageFileList.isEmpty) {
                          if (formKey.currentState!.validate()) {
                            uploadWithoutImage(context: context);
                          }
                        } else {
                          AppCubit.get(context).uploadImages(
                              AppCubit.get(context).imageFileList,
                              context,
                              postTextController.text);
                        }
                      },
                      child: state is! CreatePostLoadingState
                          ? const Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
