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
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../models/posts/post_model.dart';
import '../../models/posts/shared_post_model.dart';
import '../../models/user_model.dart';
import '../home/posts/comments/comments_screen.dart';
import '../view_image_screen.dart';
import 'person_profile/person_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getSelectedUserSavedPosts(uId!);
    AppCubit.get(context).getMyPosts();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        if (!AppCubit.get(context).isLastMyPost) {
          AppCubit.get(context).getMyPostsFromLast();
        }
        if (!AppCubit.get(context).isLastSelectedUserSavedPost) {
          AppCubit.get(context).getSelectedUserPostsFromLast(uId!);
        }
      }
    });
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
            controller: _scrollController,
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
                          backgroundColor: Colors.white,
                          child: Container(
                            decoration: const BoxDecoration(),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
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
                                        Text(
                                          lang == 'en'
                                              ? 'Faculty:'
                                              : 'الكليه: ',
                                          style: TextStyle(
                                            fontFamily: lang == 'ar'
                                                ? 'arabic2'
                                                : 'poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromARGB(
                                                255, 56, 56, 56),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Text(
                                            'Faculty of ${userModel.universityname}',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
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
                                        Text(
                                          lang == 'en' ? 'Country:' : 'البلد: ',
                                          style: TextStyle(
                                            fontFamily: lang == 'ar'
                                                ? 'arabic2'
                                                : 'poppins',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromARGB(
                                                255, 56, 56, 56),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(
                                            top: 2,
                                            left: 4,
                                          ),
                                          child: Text(
                                            '${userModel.country}',
                                            style: const TextStyle(
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
                    if (userModel.bio!.isNotEmpty)
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                    if (userModel.bio!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 19.0, left: 32, right: 32),
                        child: Text(
                          '${userModel.bio}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                                    fontSize: lang == 'ar' ? 15 : 18,
                                    fontFamily:
                                        lang == 'ar' ? 'arabic2' : 'poppins',
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
                              screen: PhotoScreen(),
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
                                      fontSize: lang == 'ar' ? 15 : 18,
                                      fontFamily:
                                          lang == 'ar' ? 'arabic2' : 'poppins',
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
                              screen: SavedScreen(),
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
                                      fontSize: lang == 'ar' ? 15 : 18,
                                      fontFamily:
                                          lang == 'ar' ? 'arabic2' : 'poppins',
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
                    if (AppCubit.get(context).myPosts.isNotEmpty)
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
                                itemBuilder: (context, index) =>
                                    buildMyPostItem(
                                  AppCubit.get(context).myPosts[index],
                                  context,
                                  index,
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
                    if (AppCubit.get(context).myPosts.isEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 60,
                          horizontal: 32,
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/images/University.png"),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              lang == 'ar'
                                  ? "لا يوجد منشورات\n انت لم تقم بإضافة اي منشورات حتى الآن."
                                  : "Empty posts\nYou haven't added any posts yet!!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: defaultColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                                fontFamily:
                                    lang == 'ar' ? 'arabic2' : 'poppins',
                              ),
                            ),
                            const SizedBox(
                              height: 55,
                            ),
                          ],
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
    index,
  ) =>
      model is PostModel
          ? buildNotSharedPostItem(model, context, index)
          : buildSharedPostItem(model, context, index);

  Widget buildNotSharedPostItem(
    PostModel model,
    context,
    int index,
  ) =>
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: index != AppCubit.get(context).myPosts.length - 1
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
                  InkWell(
                    onTap: () {
                      navigateTo(
                        context: context,
                        screen: ViewImagesScreen(
                          photos: model.image!,
                          selectedIndex: 0,
                        ),
                      );
                    },
                    child: Container(
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
                                        model.likes!.any(
                                                (element) => element == uId)
                                            ? IconlyBold.heart
                                            : IconlyLight.heart,
                                        size: 25.0,
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
                                      width: 25,
                                    ),
                                  if (isGuest == false)
                                    InkWell(
                                      onTap: () {
                                        AppCubit.get(context)
                                                .selectedUserSavedPostsId
                                                .any((element) =>
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
                                        AppCubit.get(context)
                                                .selectedUserSavedPostsId
                                                .any((element) =>
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
                if (model.image!.isNotEmpty && model.image!.length == 2)
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
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1 / 1,
                          children: List.generate(
                            model.image!.length > 4 ? 4 : model.image!.length,
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
                                if (isGuest == false) const SizedBox(width: 25),
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context)
                                              .selectedUserSavedPostsId
                                              .any((element) =>
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
                                      AppCubit.get(context)
                                              .selectedUserSavedPostsId
                                              .any((element) =>
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
                if (model.image!.isNotEmpty && model.image!.length == 3)
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        StaggeredGridView.countBuilder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          staggeredTileBuilder: (int index) {
                            if (model.image!.isNotEmpty &&
                                model.image!.length == 3) {
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
                          itemCount: model.image!.length,
                          itemBuilder: (BuildContext context, int index1) {
                            if (model.image!.isNotEmpty &&
                                model.image!.length == 3) {
                              if (index1 == 2) {
                                // The third image takes the whole width of the screen
                                return InkWell(
                                  onTap: () {
                                    navigateTo(
                                      context: context,
                                      screen: ViewImagesScreen(
                                        photos: model.image!,
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
                                      model.image![index1],
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
                                        photos: model.image!,
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
                                      model.image![index1],
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
                                      photos: model.image!,
                                      selectedIndex: index1,
                                    ),
                                  );
                                },
                                child: Image.network(
                                  model.image![index1],
                                  fit: BoxFit.cover,
                                ),
                              );
                            }
                          },
                        ),
                        // ------------------------NavBar------------------------
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
                                if (isGuest == false) const SizedBox(width: 25),
                                if (isGuest == false)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context)
                                              .selectedUserSavedPostsId
                                              .any((element) =>
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
                                      AppCubit.get(context)
                                              .selectedUserSavedPostsId
                                              .any((element) =>
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
                if (model.image!.isNotEmpty && model.image!.length > 3)
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
                                                    InkWell(
                                                      onTap: () {
                                                        navigateTo(
                                                          context: context,
                                                          screen:
                                                              ViewImagesScreen(
                                                            photos:
                                                                model.image!,
                                                            selectedIndex:
                                                                index1,
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
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
                                      AppCubit.get(context)
                                              .selectedUserSavedPostsId
                                              .any((element) =>
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
                                      AppCubit.get(context)
                                              .selectedUserSavedPostsId
                                              .any((element) =>
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
                                AppCubit.get(context)
                                        .selectedUserSavedPostsId
                                        .any((element) =>
                                            element == model.postId)
                                    ? AppCubit.get(context).removeSavedPost(
                                        postId: model.postId!,
                                      )
                                    : AppCubit.get(context).addSavePosts(
                                        model: model,
                                      );
                              },
                              child: Icon(
                                AppCubit.get(context)
                                        .selectedUserSavedPostsId
                                        .any((element) =>
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
      );

  // Shared Posts Container Done
  Widget buildSharedPostItem(
    SharePostModel model,
    context,
    int index,
  ) =>
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: index != AppCubit.get(context).myPosts.length - 1
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
                if (model.sharePostText!.isNotEmpty)
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
                SizedBox(
                  height: model.sharePostText!.isNotEmpty ? 0 : 4,
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
                        height: model.postModel!.image!.isNotEmpty ? 10 : 4,
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
                                padding: const EdgeInsets.all(0),
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
                                                  photos:
                                                      model.postModel!.image!,
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
                            padding: const EdgeInsets.all(0),
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
                        // 4 images post container
                        InkWell(
                          onTap: () {
                            // navigateTo(
                            //   context: context,
                            //   screen: ViewImagesScreen(
                            //     photos: model.postModel!.image!,
                            //     index1: 0,
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
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
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
                                                                child:
                                                                    Container(
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
                                                                    136,
                                                                    4,
                                                                    25,
                                                                    47),
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
                                                          width:
                                                              double.infinity,
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
                                      .selectedUserSavedPostsId
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
                                      .selectedUserSavedPostsId
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
}
