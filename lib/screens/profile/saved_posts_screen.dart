import 'dart:ui';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../cubit/app_cubit.dart';
import '../../models/posts/post_model.dart';
import '../../models/posts/shared_post_model.dart';
import '../../widgets/reusable_widgets.dart';
import '../../states/app_states.dart';
import '../home/posts/comments/comments_screen.dart';
import '../view_image_screen.dart';
import 'person_profile/person_profile_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(lang == 'en' ? 'Saved Posts' : 'المنشورات المحفوظة'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 13),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Color(0xffE6EEFA),
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          padding: const EdgeInsets.only(top: 13),
                          decoration: const BoxDecoration(
                            color: Color(0xffE6EEFA),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: savedPostsItems(
                              context, AppCubit.get(context).savedPosts[index]),
                        );
                      } else {
                        return savedPostsItems(
                            context, AppCubit.get(context).savedPosts[index]);
                      }
                    },
                    itemCount: AppCubit.get(context).savedPosts.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget savedPostsItems(
    BuildContext context,
    model,
  ) =>
      model is PostModel
          ? buildNotSharedPostItem(
              model,
              context,
            )
          : buildSharedPostItem(
              model,
              context,
            );

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
                Row(
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
                        backgroundColor: Colors.white,
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
                                                ));
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    color: Colors.grey[350],
                    height: 1,
                  ),
                ),
                if (model.text!.isNotEmpty)
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
                SizedBox(
                  height: model.text!.isNotEmpty ? 10 : 4,
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
                                  if (model.userId != uId)
                                    InkWell(
                                      onTap: () {
                                        _showSharePostSheet(
                                          context: context,
                                          model: model,
                                        );
                                      },
                                      child: const Icon(
                                        IconlyLight.send,
                                        size: 23,
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
                  InkWell(
                    onTap: () {
                      // navigateTo(
                      //   context: context,
                      //   screen: ViewImagesScreen(
                      //     photos:model.image!,
                      //     selectedIndex: index,
                      //
                      //
                      //   ),
                      // );
                    },
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          GridView.count(
                            physics: const BouncingScrollPhysics(),
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
                                        onTap: () {
                                          navigateTo(
                                            context: context,
                                            screen: ViewImagesScreen(
                                              photos: model.image!,
                                              selectedIndex: index1,
                                            ),
                                          );
                                        },
                                        child: model.image!.length > 4
                                            ? index1 == 3
                                                ? Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      // ---------------BLURED IMAGE---------------
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                              model.image![
                                                                  index1],
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
                                                              color: Color
                                                                  .fromARGB(
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
                                                                  .circular(23),
                                                        ),
                                                        child: Text(
                                                          '${model.image!.length - 4}+',
                                                          style:
                                                              const TextStyle(
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
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  if (isGuest == false)
                                    const SizedBox(width: 5),
                                  if (isGuest == false)
                                    Text(
                                      '${model.likes!.length}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                  if (isGuest == false)
                                    const SizedBox(width: 30),
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
                                    if (model.userId != uId)
                                      InkWell(
                                        onTap: () {
                                          _showSharePostSheet(
                                            context: context,
                                            model: model,
                                          );
                                        },
                                        child: const Icon(
                                          IconlyLight.send,
                                          size: 23,
                                          color: Colors.white,
                                        ),
                                      ),
                                  if (isGuest == false)
                                    const SizedBox(width: 30),
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
                                            : AppCubit.get(context)
                                                .addSavePosts(
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
                                size: 23,
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
                                size: 24.0,
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

  Widget buildSharedPostItem(
    SharePostModel model,
    context,
  ) =>
      Container(
        margin: const EdgeInsets.only(top: 9),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
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
                        backgroundColor: Colors.white,
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
                                  // ------------------MY Date------------------
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Divider(
                  color: Colors.grey[350],
                  height: 1,
                ),
              ),
              // ------------------MY POST TITLE------------------
              if (model.sharePostText!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${model.sharePostText}',
                    style: const TextStyle(
                      fontSize: 16.4,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 50, 50, 50),
                    ),
                  ),
                ),
              SizedBox(
                height: model.sharePostText!.isNotEmpty ? 0 : 7,
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
                                ),
                              );
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
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
                                                    screen: PersonProfileScreen(
                                                      userId: model
                                                          .postModel!.userId,
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
                                                    userId:
                                                        model.postModel!.userId,
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
                    if (model.postModel!.text!.isNotEmpty)
                      Text(
                        '${model.postModel!.text}',
                        style: const TextStyle(
                          fontSize: 15.6,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 50, 50, 50),
                        ),
                      ),
                    SizedBox(
                      height: model.postModel!.text!.isNotEmpty ? 10 : 4,
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
                      InkWell(
                        onTap: () {
                          // navigateTo(
                          //   context: context,
                          //   screen: ViewImagesScreen(
                          //     photos: model.postModel!.image!,
                          //     selectedIndex: index1,
                          //   ),
                          // );
                        },
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              GridView.count(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1 / 1,
                                children: List.generate(
                                  model.postModel!.image!.length > 4
                                      ? 4
                                      : model.postModel!.image!.length,
                                  (index1) => Container(
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              navigateTo(
                                                context: context,
                                                screen: ViewImagesScreen(
                                                  photos:
                                                      model.postModel!.image!,
                                                  selectedIndex: index1,
                                                ),
                                              );
                                            },
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
                                                              color:
                                                                  Colors.white,
                                                              image:
                                                                  DecorationImage(
                                                                image:
                                                                    NetworkImage(
                                                                  model.postModel!
                                                                          .image![
                                                                      index1],
                                                                ),
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            child:
                                                                BackdropFilter(
                                                              filter:
                                                                  ImageFilter
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
                                                                  .fromARGB(136,
                                                                  4, 25, 47),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          23),
                                                            ),
                                                            child: Text(
                                                              '${model.postModel!.image!.length - 4}+',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
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
                              ),
                            ],
                          ),
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
                                    element == AppCubit.get(context).user!.uId)
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
                      // if (isGuest == false)
                      //   InkWell(
                      //     onTap: () {
                      //       AppCubit.get(context).savedPostsId.any(
                      //               (element) =>
                      //           element == model.postId)
                      //           ? AppCubit.get(context).removeSavedPost(
                      //         postId: model.postId!,
                      //       )
                      //           : AppCubit.get(context).addSavePosts(
                      //         model: model,
                      //       );
                      //     },
                      //     child: Icon(
                      //       AppCubit.get(context).savedPostsId.any(
                      //               (element) =>
                      //           element == model.postId)
                      //           ? IconlyBold.bookmark
                      //       : IconlyLight.bookmark,
                      //   size: 24,
                      //   color: Colors.white,
                      // ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

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
                        backgroundColor: Colors.white,
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