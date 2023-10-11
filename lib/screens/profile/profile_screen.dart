import 'dart:ui';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/drawer/settings/edit_screen.dart';
import 'package:alex_uni_new/screens/profile/photos_screen.dart';
import 'package:alex_uni_new/screens/profile/saved_posts_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../models/posts/post_model.dart';
import '../../models/posts/shared_post_model.dart';
import '../../models/user_model.dart';
import '../home/posts/comments/comments_screen.dart';
import 'person_profile/person_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getMyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        UserModel userModel = cubit.user!;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.36,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.33,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: userModel.cover != ''
                              ? Image(
                                  image: NetworkImage('${userModel.cover}'),
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Container(),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 7,
                        child: SizedBox(
                          height: 116,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              cubit.logout(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 13, top: 6),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Center(
                                child: Icon(
                                  IconlyBold.logout,
                                  color: Color.fromARGB(255, 228, 39, 25),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.72),
                              topRight: Radius.circular(40.72),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.15,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Container(
                            decoration: const BoxDecoration(),
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                              radius: MediaQuery.of(context).size.width * 0.14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 30,
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          '${userModel.name}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13.0,
                        horizontal: 19,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Year:',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromARGB(255, 56, 56, 56),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            top: 2,
                                            left: 4,
                                          ),
                                          child: const Text(
                                            'Third year',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff6C7A9C),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Department:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromARGB(255, 56, 56, 56),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: const Text(
                                            'Managment Information Systems',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff6C7A9C),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: reusableElevatedButton(
                                  label: lang == 'en'
                                      ? 'Edit Profile'
                                      : ' تعديل البيانات ',
                                  fontSize: 13.4,
                                  radius: 21.49,
                                  shadowColor: Colors.transparent,
                                  backColor:
                                      const Color.fromARGB(255, 47, 90, 115),
                                  height: 40,
                                  function: () {
                                    navigateTo(
                                      context: context,
                                      screen: const EditProfile(),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 13,
                              ),
                              Expanded(
                                child: reusableElevatedButton(
                                  label: lang == 'en'
                                      ? 'Share Profile'
                                      : ' مشاركة البيانات ',
                                  fontSize: 13.4,
                                  radius: 21.49,
                                  shadowColor: Colors.transparent,
                                  textColor:
                                      const Color.fromARGB(255, 36, 59, 72),
                                  backColor:
                                      const Color.fromARGB(255, 220, 234, 255),
                                  height: 40,
                                  function: () {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.only(bottom: 19.0, left: 32, right: 32),
                      child: Text(
                        'My name is Kareem, I\'m a student at faculty of business English department',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 119, 129, 151),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              lang == 'en' ? 'posts' : 'المنشورات',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Container(
                              width: 45,
                              height: 3,
                              color: defaultColor,
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            navigateTo(
                              context: context,
                              screen: const PhotoScreen(
                                photos: [],
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                lang == 'en' ? 'photos' : 'الصور',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const SizedBox(
                                width: 45,
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).getSavePosts();
                            navigateTo(
                              context: context,
                              screen: const SavedScreen(),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                lang == 'en' ? 'saved' : 'المحفوظات',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const SizedBox(
                                width: 45,
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 29),
                      decoration: const BoxDecoration(
                        color: Color(0xffE6EEFA),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(43),
                          topRight: Radius.circular(43),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 7,
                          right: 7,
                        ),
                        margin: const EdgeInsets.only(bottom: 83.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          color: Color(0xffE6EEFA),
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => buildMyPostItem(
                                AppCubit.get(context).myPosts[index],
                                context,
                              ),
                              itemCount: AppCubit.get(context).myPosts.length,
                            ),
                            // ListView.builder(
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   shrinkWrap: true,
                            //   itemBuilder: (context, index) => buildShareItem(
                            //       AppCubit.get(context).sharePosts, index, context),
                            //   itemCount: AppCubit.get(context).sharePosts.length,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildMyPostItem(
    model,
    context,
  ) =>
      model is PostModel
          ? buildNotSharedPostItem(model, context)
          : buildSharedPostItem(model, context);

  Widget buildNotSharedPostItem(
    PostModel model,
    context,
  ) =>
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(
                  113, 121, 141, 155), // Set the color of the border
              width: 8.0, // Set the width of the border
            ),
          ),
        ),
        child: Card(
          shadowColor: Colors.transparent,
          color: const Color(0xffE6EEFA),
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (!isGuest) {
                            if (uId != model.userId) {
                              navigateTo(
                                context: context,
                                screen: PersonProfileScreen(
                                  userId: model.userId,
                                ),
                              );
                            } else {
                              AppCubit.get(context).changeBottomNavBar(1);
                            }
                          } else {
                            navigateTo(
                              context: context,
                              screen: PersonProfileScreen(
                                userId: model.userId,
                              ),
                            );
                          }
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${model.userImage}',
                          ),
                          radius: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (!isGuest) {
                                              if (AppCubit.get(context)
                                                      .user!
                                                      .uId !=
                                                  model.userId) {
                                                navigateTo(
                                                  context: context,
                                                  screen: PersonProfileScreen(
                                                    userId: model.userId,
                                                  ),
                                                );
                                              } else {
                                                AppCubit.get(context)
                                                    .changeBottomNavBar(1);
                                              }
                                            } else {
                                              navigateTo(
                                                context: context,
                                                screen: PersonProfileScreen(
                                                  userId: model.userId,
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            '${model.userName}',
                                            style: const TextStyle(
                                              height: 1.4,
                                              fontSize: 17.3,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.verified,
                                          size: 16,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${model.date}',
                                      style: const TextStyle(
                                        height: 1.4,
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                if (model.userId == uId)
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).deletePost(model);
                                    },
                                    icon: const Icon(
                                      IconlyBold.delete,
                                      size: 20,
                                      color: Color.fromARGB(255, 227, 33, 19),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: Colors.grey[350],
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${model.text}',
                    style: const TextStyle(
                      fontSize: 16.4,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 50, 50, 50),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (model.image!.isNotEmpty && model.image!.length == 1)
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Image.network(
                          model.image![0],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          color: Colors.black.withOpacity(0.6),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context).updatePostLikes(
                                        model,
                                      );
                                    },
                                    child: Icon(
                                      model.likes!
                                              .any((element) => element == uId)
                                          ? IconlyBold.heart
                                          : IconlyLight.heart,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (isGuest == false) const SizedBox(width: 5),
                                if (isGuest == false)
                                  Text(
                                    '${model.likes!.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                if (isGuest == false) const SizedBox(width: 30),
                                InkWell(
                                  onTap: () {
                                    AppCubit.get(context)
                                        .getComments(postId: model.postId!);
                                    navigateTo(
                                      context: context,
                                      screen: CommentsScreen(
                                        postId: model.postId!,
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    IconlyLight.chat,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      _showSharePostSheet(
                                        context: context,
                                        model: model,
                                      );
                                    },
                                    child: const Icon(
                                      IconlyLight.send,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (isGuest == false)
                                  const SizedBox(
                                    width: 30,
                                  ),
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context).savedPostsId.any(
                                              (element) =>
                                                  element == model.postId)
                                          ? AppCubit.get(context)
                                              .removeSavedPost(
                                              postId: model.postId!,
                                            )
                                          : AppCubit.get(context).addSavePosts(
                                              model: model,
                                            );
                                    },
                                    child: Icon(
                                      AppCubit.get(context).savedPostsId.any(
                                              (element) =>
                                                  element == model.postId)
                                          ? IconlyBold.bookmark
                                          : IconlyLight.bookmark,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (model.image!.isNotEmpty && model.image!.length > 1)
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        GridView.count(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1 / 1,
                          children: List.generate(
                            model.image!.length > 4 ? 4 : model.image!.length,
                            (index1) => Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      // onTap: () {
                                      //   navigateTo(
                                      //       context: context,
                                      //       screen: ViewImagesScreen(
                                      //           view: AppCubit.get(context).posts,
                                      //           index1: index,
                                      //           index2: index1,
                                      //           id: AppCubit.get(context)
                                      //               .postsId));
                                      // },
                                      child: model.image!.length > 4
                                          ? index1 == 3
                                              ? Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    // ---------------BLURED IMAGE---------------
                                                    Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                            model
                                                                .image![index1],
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    ClipRRect(
                                                      child: BackdropFilter(
                                                        filter:
                                                            ImageFilter.blur(
                                                          sigmaY: 3,
                                                          sigmaX: 3,
                                                        ),
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    76,
                                                                    11,
                                                                    36,
                                                                    50),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // ---------------EXCEEDING IMAGE NUMBER---------------
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16,
                                                        vertical: 6,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            136, 4, 25, 47),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(23),
                                                      ),
                                                      child: Text(
                                                        '${model.image!.length - 4}+',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Image.network(
                                                  model.image![index1],
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )
                                          : Image.network(
                                              model.image![index1],
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          color: Colors.black.withOpacity(0.6),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context).updatePostLikes(
                                        model,
                                      );
                                    },
                                    child: Icon(
                                      model.likes!.any((element) =>
                                              element ==
                                              AppCubit.get(context).user!.uId)
                                          ? IconlyBold.heart
                                          : IconlyLight.heart,
                                      size: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (isGuest == false) const SizedBox(width: 5),
                                if (isGuest == false)
                                  Text(
                                    '${model.likes!.length}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                if (isGuest == false) const SizedBox(width: 30),
                                InkWell(
                                  onTap: () {
                                    AppCubit.get(context)
                                        .getComments(postId: model.postId!);
                                    navigateTo(
                                      context: context,
                                      screen: CommentsScreen(
                                        postId: model.postId!,
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    IconlyLight.chat,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      _showSharePostSheet(
                                        context: context,
                                        model: model,
                                      );
                                    },
                                    child: const Icon(
                                      IconlyLight.send,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                if (isGuest == false) const SizedBox(width: 30),
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context).savedPostsId.any(
                                              (element) =>
                                                  element == model.postId)
                                          ? AppCubit.get(context)
                                              .removeSavedPost(
                                              postId: model.postId!,
                                            )
                                          : AppCubit.get(context).addSavePosts(
                                              model: model,
                                            );
                                    },
                                    child: Icon(
                                      AppCubit.get(context).savedPostsId.any(
                                              (element) =>
                                                  element == model.postId)
                                          ? IconlyBold.bookmark
                                          : IconlyLight.bookmark,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (model.image!.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (isGuest == false)
                            InkWell(
                              onTap: () {
                                AppCubit.get(context).updatePostLikes(
                                  model,
                                );
                              },
                              child: Icon(
                                model.likes!.any((element) =>
                                        element ==
                                        AppCubit.get(context).user!.uId)
                                    ? IconlyBold.heart
                                    : IconlyLight.heart,
                                size: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false)
                            const SizedBox(
                              width: 5,
                            ),
                          if (isGuest == false)
                            Text(
                              '${model.likes!.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          if (isGuest == false)
                            const SizedBox(
                              width: 30,
                            ),
                          InkWell(
                            onTap: () {
                              AppCubit.get(context)
                                  .getComments(postId: model.postId!);
                              navigateTo(
                                context: context,
                                screen: CommentsScreen(
                                  postId: model.postId!,
                                ),
                              );
                            },
                            child: const Icon(
                              IconlyLight.chat,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          if (isGuest == false)
                            InkWell(
                              onTap: () {
                                _showSharePostSheet(
                                  context: context,
                                  model: model,
                                );
                              },
                              child: const Icon(
                                IconlyLight.send,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 30),
                          if (isGuest == false)
                            InkWell(
                              onTap: () {
                                AppCubit.get(context).savedPostsId.any(
                                        (element) => element == model.postId)
                                    ? AppCubit.get(context).removeSavedPost(
                                        postId: model.postId!,
                                      )
                                    : AppCubit.get(context).addSavePosts(
                                        model: model,
                                      );
                              },
                              child: Icon(
                                AppCubit.get(context).savedPostsId.any(
                                        (element) => element == model.postId)
                                    ? IconlyBold.bookmark
                                    : IconlyLight.bookmark,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  // Shared Posts Container Done
  Widget buildSharedPostItem(
    SharePostModel model,
    context,
  ) =>
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color.fromARGB(
                  113, 121, 141, 155), // Set the color of the border
              width: 8.0, // Set the width of the border
            ),
          ),
        ),
        child: Card(
          shadowColor: Colors.transparent,
          color: const Color(0xffE6EEFA),
          clipBehavior: Clip.none,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (!isGuest) {
                          if (uId != model.shareUserId) {
                            navigateTo(
                              context: context,
                              screen: PersonProfileScreen(
                                userId: model.shareUserId,
                              ),
                            );
                          } else {
                            AppCubit.get(context).changeBottomNavBar(3);
                          }
                        } else {
                          navigateTo(
                            context: context,
                            screen: PersonProfileScreen(
                              userId: model.shareUserId,
                            ),
                          );
                        }
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${model.shareUserImage}',
                        ),
                        radius: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (!isGuest) {
                                            if (uId != model.shareUserId) {
                                              navigateTo(
                                                context: context,
                                                screen: PersonProfileScreen(
                                                  userId: model.shareUserId,
                                                ),
                                              );
                                            } else {
                                              AppCubit.get(context)
                                                  .changeBottomNavBar(3);
                                            }
                                          } else {
                                            navigateTo(
                                              context: context,
                                              screen: PersonProfileScreen(
                                                userId: model.shareUserId,
                                              ),
                                            );
                                          }
                                        },
                                        child: Text(
                                          '${model.shareUserName}',
                                          style: const TextStyle(
                                            height: 1.4,
                                            fontSize: 17,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.verified,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${model.formattedSharePostDate}',
                                    style: const TextStyle(
                                      height: 1.4,
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              if (model.shareUserId == uId)
                                IconButton(
                                  onPressed: () {
                                    AppCubit.get(context).deletePost(model);
                                  },
                                  icon: const Icon(
                                    IconlyBold.delete,
                                    size: 20,
                                    color: Color.fromARGB(255, 238, 21, 21),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: Colors.grey[350],
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    '${model.sharePostText}',
                    style: const TextStyle(
                      fontSize: 16.4,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 50, 50, 50),
                    ),
                  ),
                ),
                if (model.sharePostText == "")
                  const SizedBox(
                    height: 7,
                  ),
                Container(
                  padding: const EdgeInsets.all(9),
                  margin: const EdgeInsets.only(bottom: 9),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 252, 255),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (!isGuest) {
                                if (uId != model.postModel!.userId) {
                                  navigateTo(
                                    context: context,
                                    screen: PersonProfileScreen(
                                      userId: model.postModel!.userId,
                                    ),
                                  );
                                } else {
                                  AppCubit.get(context).changeBottomNavBar(3);
                                }
                              } else {
                                navigateTo(
                                    context: context,
                                    screen: PersonProfileScreen(
                                      userId: model.postModel!.userId,
                                    ),);
                              }
                            },
                            // ------------------SHARED USER PROFILE PICTURE------------------
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                '${model.postModel!.userImage}',
                              ),
                              radius: 23,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (!isGuest) {
                                                  if (AppCubit.get(context)
                                                          .user!
                                                          .uId !=
                                                      model.postModel!.userId) {
                                                    navigateTo(
                                                      context: context,
                                                      screen:
                                                          PersonProfileScreen(
                                                        userId: model
                                                            .postModel!.userId,
                                                      ),
                                                    );
                                                  } else {
                                                    AppCubit.get(context)
                                                        .changeBottomNavBar(3);
                                                  }
                                                } else {
                                                  navigateTo(
                                                    context: context,
                                                    screen: PersonProfileScreen(
                                                      userId: model
                                                          .postModel!.userId,
                                                    ),
                                                  );
                                                }
                                              },
                                              // ------------------SHARED USER NAME------------------
                                              child: Text(
                                                '${model.postModel!.userName}',
                                                style: const TextStyle(
                                                  height: 1.4,
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.verified,
                                              size: 16,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        // ------------------SHARED USER DATE------------------
                                        Text(
                                          'Shared by ${model.shareUserName}.',
                                          style: const TextStyle(
                                            height: 1.4,
                                            fontSize: 11,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          color: Colors.grey[350],
                          height: 1,
                        ),
                      ),
                      Text(
                        '${model.postModel!.text}',
                        style: const TextStyle(
                          fontSize: 15.6,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                      ),
                      SizedBox(
                        height: model.postModel!.image!.isNotEmpty ? 10 : 6,
                      ),
                      if (model.postModel!.image!.isNotEmpty &&
                          model.postModel!.image!.length == 1)
                        // ----------------SHARED POST CONTAINER----------------
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            model.postModel!.image![0],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (model.postModel!.image!.isNotEmpty &&
                          model.postModel!.image!.length > 1)
                        // 4 images post container
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              GridView.count(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1 / 1,
                                children: List.generate(
                                  model.postModel!.image!.length > 4
                                      ? 4
                                      : model.postModel!.image!.length,
                                  (index1) => Column(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          // onTap: () {
                                          //   navigateTo(
                                          //       context: context,
                                          //       screen: ViewImagesScreen(
                                          //           view: AppCubit.get(context).posts,
                                          //           index1: index,
                                          //           index2: index1,
                                          //           id: AppCubit.get(context)
                                          //               .postsId));
                                          // },
                                          child: model.postModel!.image!
                                                      .length >
                                                  4
                                              ? index1 == 3
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                model.postModel!
                                                                        .image![
                                                                    index1],
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        ClipRRect(
                                                          child: BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                              sigmaY: 3,
                                                              sigmaX: 3,
                                                            ),
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color: Color
                                                                    .fromARGB(
                                                                  76,
                                                                  11,
                                                                  36,
                                                                  50,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        // ---------------EXCEEDING IMAGE NUMBER---------------
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            horizontal: 16,
                                                            vertical: 6,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(
                                                                136, 4, 25, 47),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        23),
                                                          ),
                                                          child: Text(
                                                            '${model.postModel!.image!.length - 4}+',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Image.network(
                                                      model.postModel!
                                                          .image![index1],
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    )
                                              : Image.network(
                                                  model.postModel!
                                                      .image![index1],
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                // --------------LIKES, COMMENTS, SHARE & SAVE (for shared posts)--------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if (isGuest == false)
                          InkWell(
                            onTap: () {
                              AppCubit.get(context).updatePostLikes(
                                model,
                              );
                            },
                            child: Icon(
                              model.likes.any((element) =>
                                      element ==
                                      AppCubit.get(context).user!.uId)
                                  ? IconlyBold.heart
                                  : IconlyLight.heart,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        if (isGuest == false) const SizedBox(width: 5),
                        if (isGuest == false)
                          Text(
                            '${model.likes.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                        if (isGuest == false) const SizedBox(width: 30),
                        InkWell(
                          onTap: () {
                            AppCubit.get(context)
                                .getComments(postId: model.postId!);
                            navigateTo(
                              context: context,
                              screen: CommentsScreen(
                                postId: model.postId!,
                              ),
                            );
                          },
                          child: const Icon(
                            IconlyLight.chat,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        if (isGuest == false)
                          InkWell(
                            onTap: () {
                              _showSharePostSheet(
                                context: context,
                                model: model.postModel!,
                              );
                            },
                            child: const Icon(
                              IconlyBold.send,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                        if (isGuest == false) const SizedBox(width: 30),
                        if (isGuest == false)
                          InkWell(
                            onTap: () {
                              AppCubit.get(context)
                                      .savedPostsId
                                      .any((element) => element == model.postId)
                                  ? AppCubit.get(context).removeSavedPost(
                                      postId: model.postId!,
                                    )
                                  : AppCubit.get(context).addSavePosts(
                                      model: model,
                                    );
                            },
                            child: Icon(
                              AppCubit.get(context)
                                      .savedPostsId
                                      .any((element) => element == model.postId)
                                  ? IconlyBold.bookmark
                                  : IconlyLight.bookmark,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  // Share Posts Outline
  _showSharePostSheet(
      {required BuildContext context, required PostModel model}) {
    TextEditingController controller = TextEditingController();
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              color: const Color(0xffE6EEFA),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          AppCubit.get(context).user!.image!,
                        ),
                        radius: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        AppCubit.get(context).user!.name!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  reusableTextFormField(
                    label: lang == 'en' ? 'Write your post' : 'اكتب منشورك',
                    onTap: () {},
                    controller: controller,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: reusableElevatedButton(
                            label: lang == 'en' ? 'Share' : 'مشاركة',
                            function: () async {
                              await AppCubit.get(context).sharePost(
                                model: model,
                                text: controller.text,
                                context: context,
                              );
                              if (!context.mounted) return;
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: reusableElevatedButton(
                            label: lang == 'en' ? 'Cancel' : 'الغاء',
                            function: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
