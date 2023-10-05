import 'package:alex_uni_new/models/posts/post_model.dart';
import 'package:alex_uni_new/screens/profile_screen/photos_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../cubit/app_cubit.dart';
import '../../models/posts/shared_post_model.dart';
import '../../models/user_model.dart';
import '../../reusable_widgets.dart';
import '../../states/app_states.dart';
import '../comments/comments_screen.dart';

class PersonProfileScreen extends StatefulWidget {
  PersonProfileScreen({super.key, this.userId});

  final String? userId;
  bool showPost = false;
  @override
  State<PersonProfileScreen> createState() => _PersonProfileScreenState();
}

class _PersonProfileScreenState extends State<PersonProfileScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getSelectedUser(widget.userId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is GetSelectedUserSuccessState) {
          AppCubit.get(context)
              .getSelectedUserPosts(AppCubit.get(context).selectedUser!.uId!);
        }
        if (state is GetSelectedUserPostsSuccessState) {
          widget.showPost = true;
        }
      },
      builder: (context, state) {

        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          body: ConditionalBuilder(
            condition: widget.showPost,
            builder: (context) {
              UserModel userModel = cubit.selectedUser!;
              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: userModel.cover != ''
                                    ? Image(
                                        image:
                                            NetworkImage('${userModel.cover}'),
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius:
                                  MediaQuery.of(context).size.width * 0.15,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context)
                                      .scaffoldBackgroundColor,
                                  backgroundImage: NetworkImage(
                                    '${userModel.image}',
                                  ),
                                  radius: MediaQuery.of(context).size.width *
                                      0.14,
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
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      lang == 'en' ? 'Posts' : 'المنشورات',
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
                                const SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: (){
                                    navigateTo(context: context, screen: PhotoScreen(photos: AppCubit.get(context).selectedUserPhotos));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        lang == 'en' ? 'Photos' : 'الصور',
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                90,
                              ),
                            ),
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      buildMyPostItem(
                                          AppCubit.get(context)
                                              .selectedUserPosts[index],
                                          context),
                                  itemCount: AppCubit.get(context)
                                      .selectedUserPosts
                                      .length,
                                ),
                                // ListView.builder(
                                //   physics: const NeverScrollableScrollPhysics(),
                                //   shrinkWrap: true,
                                //   itemBuilder: (context, index) =>
                                //       buildShareItem(
                                //           AppCubit.get(context)
                                //               .selectedUserSharedPosts,
                                //           index,
                                //           context),
                                //   itemCount: AppCubit.get(context)
                                //       .selectedUserSharedPosts
                                //       .length,
                                // ),
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
            fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMyPostItem(model, context) => model is PostModel
      ? buildNotSharedPostItem(model, context)
      : buildSharedPostItem(model, context);

  Widget buildNotSharedPostItem(
      PostModel model,
      context,
      ) => Card(
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
                        ));
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
            '${model.text}',
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
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 5),
                          if (isGuest == false)
                            Text(
                              '${model.likes!.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 20),
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
                              Icons.comment_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          if (isGuest == false)
                              InkWell(
                                onTap: () {
                                  _showSharePostSheet(context: context, model: model,);
                                },
                                child: const Icon(
                                  Icons.share_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                          if (isGuest == false)
                            const SizedBox(
                              width: 20,
                            ),
                          if (isGuest == false)
                            InkWell(
                              onTap: () {
                                AppCubit.get(context).savedPostsId.any(
                                        (element) =>
                                    element == model.postId)
                                    ? AppCubit.get(context).removeSavedPost(
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
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                size: 18.0,
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
                                    Image.network(
                                      model.image![index1],
                                      width: double.infinity,
                                    ),
                                    Text(
                                      '${model.image!.length - 4}+',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                    : Image.network(
                                  model.image![index1],
                                  width: double.infinity,
                                )
                                    : Image.network(
                                  model.image![index1],
                                  width: double.infinity,
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
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 5),
                          if (isGuest == false)
                            Text(
                              '${model.likes!.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 20),
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
                              Icons.comment_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          if (isGuest == false)
                              InkWell(
                                onTap: () {
                                  _showSharePostSheet(context: context, model: model,);
                                },
                                child: const Icon(
                                  Icons.share_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                          if (isGuest == false) const SizedBox(width: 20),
                          if (isGuest == false)
                            InkWell(
                              onTap: () {
                                AppCubit.get(context).savedPostsId.any(
                                        (element) =>
                                    element == model.postId)
                                    ? AppCubit.get(context).removeSavedPost(
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
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                size: 18.0,
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
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 18.0,
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
                        ),
                      ),
                    if (isGuest == false)
                      const SizedBox(
                        width: 20,
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
                        Icons.comment_outlined,
                        size: 18,
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
                          Icons.share_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    if (isGuest == false)
                      const SizedBox(width: 20),
                    if (isGuest == false)
                      InkWell(
                        onTap: () {
                          AppCubit.get(context).savedPostsId.any((element) => element == model.postId)
                              ? AppCubit.get(context).removeSavedPost(postId: model.postId!,)
                              : AppCubit.get(context).addSavePosts(model: model,);
                        },
                        child: Icon(
                          AppCubit.get(context)
                              .savedPostsId
                              .any((element) => element == model.postId)
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          size: 18.0,
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
  );

  Widget buildSharedPostItem(
      SharePostModel model,
      context,
      ) => Card(
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
                        ));
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
                                      if (uId !=
                                          model.shareUserId) {
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
                                          ));
                                    }
                                  },
                                  child: Text(
                                    '${model.shareUserName}',
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
          const SizedBox(
            height: 10,
          ),
          Text(
            '${model.sharePostText}',
          ),
          const SizedBox(
            height: 10,
          ),
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
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${model.postModel!.userImage}',
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
                                          model.postModel!.userId) {
                                        navigateTo(
                                          context: context,
                                          screen: PersonProfileScreen(
                                            userId: model.postModel!.userId,
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
                                            userId: model.postModel!.userId,
                                          ));
                                    }
                                  },
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
                              '${model.postModel!.date}',
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
          ),
          const SizedBox(
            height: 10,
          ),
          if (model.postModel!.image!.isNotEmpty && model.postModel!.image!.length == 1)
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image.network(
                    model.postModel!.image![0],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
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
                                model.likes
                                    .any((element) => element == uId)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 5),
                          if (isGuest == false)
                            Text(
                              '${model.likes.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 20),
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
                              Icons.comment_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          if (isGuest == false)
                            InkWell(
                              onTap: () {
                                _showSharePostSheet(context: context, model: model.postModel!,);
                              },
                              child: const Icon(
                                Icons.share_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false)
                            const SizedBox(
                              width: 20,
                            ),
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
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                size: 18.0,
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
          if (model.postModel!.image!.isNotEmpty && model.postModel!.image!.length > 1)
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
                      model.postModel!.image!.length > 4 ? 4 : model.postModel!.image!.length,
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
                                child: model.postModel!.image!.length > 4
                                    ? index1 == 3
                                    ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.network(
                                      model.postModel!.image![index1],
                                      width: double.infinity,
                                    ),
                                    Text(
                                      '${model.postModel!.image!.length - 4}+',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                    : Image.network(
                                  model.postModel!.image![index1],
                                  width: double.infinity,
                                )
                                    : Image.network(
                                  model.postModel!.image![index1],
                                  width: double.infinity,
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
                                model.likes.any((element) =>
                                element ==
                                    AppCubit.get(context).user!.uId)
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 5),
                          if (isGuest == false)
                            Text(
                              '${model.likes.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false) const SizedBox(width: 20),
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
                              Icons.comment_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          if (isGuest == false)
                            InkWell(
                              onTap: () {
                                _showSharePostSheet(context: context, model: model.postModel!,);
                              },
                              child: const Icon(
                                Icons.share_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          if (isGuest == false)
                            const SizedBox(width: 20),
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
                                    ? Icons.bookmark
                                    : Icons.bookmark_outline,
                                size: 18.0,
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
          if (model.postModel!.image!.isEmpty)
            Container(
              width: double.infinity,
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
                          model.likes.any((element) =>
                          element == uId)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    if (isGuest == false)
                      const SizedBox(
                        width: 5,
                      ),
                    if (isGuest == false)
                      Text(
                        '${model.likes.length}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    if (isGuest == false)
                      const SizedBox(
                        width: 20,
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
                        Icons.comment_outlined,
                        size: 18,
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
                          Icons.share_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    if (isGuest == false)
                      const SizedBox(width: 20),
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
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          size: 18.0,
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
  );

  _showSharePostSheet({
    required BuildContext context,
    required PostModel model
  }) {
    TextEditingController controller = TextEditingController();
    return showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) =>
          WillPopScope(
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
                              AppCubit
                                  .get(context)
                                  .user!
                                  .image!,
                            ),
                            radius: 25,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            AppCubit
                                .get(context)
                                .user!
                                .name!,
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
                        keyboardType: TextInputType.text,),
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
                                  if(!context.mounted)return;
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
