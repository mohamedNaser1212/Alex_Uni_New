import 'dart:io';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:intl/intl.dart';
import '../../models/posts/post_model.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({Key? key}) : super(key: key);

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {



  uploadWithoutImage({
    required BuildContext context,
}){
    DateTime now = DateTime.now();
    String formattedDate =
    DateFormat('yyyy-MM-dd hh:mm a').format(now);

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
    }).then((value){
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
      listener: (context,state){
        if (state is CreatePostSuccessState){
          if(AppCubit.get(context).currentIndex==0) {
            AppCubit.get(context).getPosts();
          }else if(AppCubit.get(context).currentIndex==3){
            AppCubit.get(context).getMyPosts();
          }
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
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
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: postTextController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'post body must not be empty';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What\'s in your mind?',
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: AppCubit.get(context).imageFileList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: FullScreenWidget(child: Image.file(File(AppCubit.get(context).imageFileList[index].path),)),
                            );
                          }
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                AppCubit.get(context).selectImages();
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                  ),
                                  Text(
                                    'Add photo',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (AppCubit.get(context).imageFileList.isNotEmpty)
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    AppCubit.get(context).imageFileList=[];
                                  });
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      'delete photo',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
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
                        if(AppCubit.get(context).imageFileList.isEmpty){
                          if(formKey.currentState!.validate()){
                            uploadWithoutImage(context: context);
                          }
                        }
                        else {
                          AppCubit.get(context).uploadImages(AppCubit.get(context).imageFileList,context,postTextController.text);
                        }
                      },
                      child:state is! CreatePostLoadingState? const Text(
                        'Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ):const Center(child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    ),
                  ),
                ),
                SizedBox(
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