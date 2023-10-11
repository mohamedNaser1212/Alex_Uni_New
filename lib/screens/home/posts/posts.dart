import 'dart:ui';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/posts/post_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/home/posts/comments/comments_screen.dart';
import 'package:alex_uni_new/screens/home/posts/shared_post.dart';
import 'package:alex_uni_new/screens/profile/person_profile/person_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../view_image_screen.dart';

Widget buildPostItem(
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
                          AppCubit.get(context).changeBottomNavBar(3);
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
                                          if (AppCubit.get(context).user!.uId !=
                                              model.userId) {
                                            navigateTo(
                                              context: context,
                                              screen: PersonProfileScreen(
                                                userId: model.userId,
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
                                  AppCubit.get(context).deletePost(
                                    model,
                                  );
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
                                  model.likes!.any((element) => element == uId)
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
                                  showSharePostSheet(
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
                                width: 25,
                              ),
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
                                                        model.image![index1],
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                ClipRRect(
                                                  child: BackdropFilter(
                                                    filter: ImageFilter.blur(
                                                      sigmaY: 3,
                                                      sigmaX: 3,
                                                    ),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Color.fromARGB(
                                                            76, 11, 36, 50),
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
                                                    color: const Color.fromARGB(
                                                        136, 4, 25, 47),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            23),
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
                                  size: 25,
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
                                  showSharePostSheet(
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
                            if (isGuest == false) const SizedBox(width: 25),
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
                                    element == AppCubit.get(context).user!.uId)
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
                            showSharePostSheet(
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
                      if (isGuest == false) const SizedBox(width: 25),
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
                            size: 24.0,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
