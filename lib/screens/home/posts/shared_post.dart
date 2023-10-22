import 'dart:ui';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/posts/post_model.dart';
import 'package:alex_uni_new/models/posts/shared_post_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/home/posts/comments/comments_screen.dart';
import 'package:alex_uni_new/screens/profile/person_profile/person_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../view_image_screen.dart';

Widget buildSharedPostItem(
  SharePostModel model,
  context,
  int index,
) =>
    Container(
      margin: const EdgeInsets.only(top: 9),
      decoration: BoxDecoration(
        border: Border(
          bottom: index != AppCubit.get(context).post.length - 1
              ? const BorderSide(
                  color: Color.fromARGB(
                      113, 121, 141, 155), // Set the color of the border
                  width: 8.0, // Set the width of the border
                )
              : const BorderSide(
                  color: Color(0xffE6EEFA), // Set the color of the border
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
                    // ---------------MY PROFILE PICTURE------------------
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
                                      // ------------------MY NAME------------------
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
                                  AppCubit.get(context).deletePost(
                                    model,
                                  );
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
              height: model.sharePostText!.isNotEmpty ? 2 : 7,
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
                                ));
                          }
                        },
                        // ------------------SHARED USER PROFILE PICTURE------------------
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                                  model.postModel!.userId) {
                                                navigateTo(
                                                  context: context,
                                                  screen: PersonProfileScreen(
                                                    userId:
                                                        model.postModel!.userId,
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
                                    // ------------------SHARED USER DATE------------------
                                    Text(
                                      lang == 'ar' ? 'قام بمشاركة ${model.shareUserName}.' : 'Shared by ${model.shareUserName}.',
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
                    InkWell(
                      onTap: () {
                        navigateTo(
                          context: context,
                          screen: ViewImagesScreen(
                            photos: model.postModel!.image!,
                            selectedIndex: 0,
                          ),
                        );
                      },
                      child: Container(
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
                    ),
                  if (model.postModel!.image!.isNotEmpty &&
                      model.postModel!.image!.length == 2)
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
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
                              model.postModel!.image!.length,
                              (index1) => Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          navigateTo(
                                            context: context,
                                            screen: ViewImagesScreen(
                                              photos: model.postModel!.image!,
                                              selectedIndex: index1,
                                            ),
                                          );
                                        },
                                        child: Image.network(
                                          model.postModel!.image![index1],
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
                  if (model.postModel!.image!.isNotEmpty &&
                      model.postModel!.image!.length == 3)
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: StaggeredGridView.countBuilder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        staggeredTileBuilder: (int index) {
                          if (model.postModel!.image!.isNotEmpty &&
                              model.postModel!.image!.length == 3) {
                            if (index == 2) {
                              // The third image takes the whole width
                              return const StaggeredTile.count(2, 1);
                            } else {
                              // Display the first two images side by side
                              return const StaggeredTile.count(1, 1);
                            }
                          } else {
                            return const StaggeredTile.count(1, 1);
                          }
                        },
                        crossAxisSpacing: 10,
                        itemCount: model.postModel!.image!.length,
                        itemBuilder: (BuildContext context, int index1) {
                          if (model.postModel!.image!.isNotEmpty &&
                              model.postModel!.image!.length == 3) {
                            if (index1 == 2) {
                              // The third image takes the whole width of the screen
                              return InkWell(
                                onTap: () {
                                  navigateTo(
                                    context: context,
                                    screen: ViewImagesScreen(
                                      photos: model.postModel!.image!,
                                      selectedIndex: index1,
                                    ),
                                  );
                                },
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white,
                                  ),
                                  child: Image.network(
                                    model.postModel!.image![index1],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              );
                            } else {
                              // Display the first two images side by side
                              return InkWell(
                                onTap: () {
                                  navigateTo(
                                    context: context,
                                    screen: ViewImagesScreen(
                                      photos: model.postModel!.image!,
                                      selectedIndex: index1,
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white,
                                  ),
                                  child: Image.network(
                                    model.postModel!.image![index1],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          } else {
                            // Display images 1 to 3 normally
                            return InkWell(
                              onTap: () {
                                navigateTo(
                                  context: context,
                                  screen: ViewImagesScreen(
                                    photos: model.postModel!.image!,
                                    selectedIndex: index1,
                                  ),
                                );
                              },
                              child: Image.network(
                                model.postModel!.image![index1],
                                fit: BoxFit.cover,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  if (model.postModel!.image!.isNotEmpty &&
                      model.postModel!.image!.length > 3)
                    InkWell(
                      // onTap: () {
                      //   int selectedImageIndex = index1; // Store the selected index
                      //   navigateTo(
                      //     context: context,
                      //     screen: ViewImagesScreen(
                      //       photos: model.postModel!.image!,
                      //       selectedIndex: selectedImageIndex,
                      //     ),
                      //   );
                      // },
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
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            // Store the selected index
                                            navigateTo(
                                              context: context,
                                              screen: ViewImagesScreen(
                                                photos: model.postModel!.image!,
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
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18),
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
                          showSharePostSheet(
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
            const SizedBox(
              height: 9,
            ),
          ],
        ),
      ),
    );

showSharePostSheet({required BuildContext context, required PostModel model}) {
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppCubit.get(context).user!.name!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Sharing post...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                reusableTextFormField(
                  padding: const EdgeInsets.all(9),
                  maxLines: null,
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
                          radius: 24,
                          backColor: const Color.fromARGB(255, 62, 165, 66),
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
                          radius: 24,
                          backColor: const Color.fromARGB(255, 216, 36, 23),
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
