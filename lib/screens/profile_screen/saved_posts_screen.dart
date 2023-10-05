import 'package:alex_uni_new/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/app_cubit.dart';
import '../../models/posts/post_model.dart';
import '../../models/posts/shared_post_model.dart';
import '../../reusable_widgets.dart';
import '../../states/app_states.dart';
import '../comments/comments_screen.dart';
import '../person_profile/person_profile_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title:  Text(lang=='en'?'Saved Posts':'المنشورات المحفوظة'),
          ),
          body:   ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) => savedPostsItems(
              context,
              AppCubit.get(context).savedPosts[index],
            ),
            itemCount: AppCubit.get(context).savedPosts.length,
          ),
        );
      },
    );
  }

  Widget savedPostsItems(BuildContext context, model,) =>model is PostModel? buildNotSharedPostItem(model, context,) : buildSharedPostItem(model, context,);

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
                        if (model.userId == uId)
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).deletePost(
                                model
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.grey,
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
                            if (model.userId != uId)
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
                            if (model.userId != uId)
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
                        if (model.shareUserId == uId)
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).deletePost(
                                model
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 20,
                              color: Colors.grey,
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
                          //           ? Icons.bookmark
                          //           : Icons.bookmark_outline,
                          //       size: 18.0,
                          //       color: Colors.white,
                          //     ),
                          //   ),
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
                          if (isGuest == false) const SizedBox(width: 20),
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
                          //           ? Icons.bookmark
                          //           : Icons.bookmark_outline,
                          //       size: 18.0,
                          //       color: Colors.white,
                          //     ),
                          //   ),
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
