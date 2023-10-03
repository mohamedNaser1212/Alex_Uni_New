import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/profile_screen/photos_screen.dart';
import 'package:alex_uni_new/screens/profile_screen/saved_posts_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../comments/comments_screen.dart';
import '../edit_screen/edit_screen.dart';

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
    AppCubit.get(context).getSharePosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        AppCubit cubit = AppCubit.get(context);
        UserModel userModel = cubit.user!;

        return Scaffold(
          body: SafeArea(
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: reusableElevatedButton(
                                label: lang == 'en'
                                    ? 'Edit Profile'
                                    : ' تعديل البيانات ',
                                backColor: defaultColor,
                                height: 40,
                                function: () {
                                  navigateTo(
                                      context: context,
                                      screen: const EditProfile());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                 lang=='en'? 'posts':'المنشورات',
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
                            onTap: (){
                              navigateTo(context: context, screen: PhotoScreen(
                                photos: AppCubit.get(context).myphotos,
                              ),);
                            },
                            child: Column(
                              children: [
                                Text(
                                   lang=='en'? 'photos':'الصور',
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
                            onTap: (){
                              AppCubit.get(context).getSavePosts();
                              navigateTo(context: context, screen: const SavedScreen(),);
                            },
                            child: Column(
                              children: [
                                Text(
                                    lang=='en'?'saved':'المحفوظات',
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
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget? buildMyPostItem(
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
              CircleAvatar(
                backgroundImage: NetworkImage(
                  '${model.userImage}',
                ),
                radius: 25,
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
                                Text(
                                  '${model.userName}',
                                  style: const TextStyle(
                                    height: 1.4,
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Poppins',
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
                                model.postId!,
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
          if(model.image!.isNotEmpty && model.image!.length==1)
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
                                model.likes!.any((element) => element == uId)
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
                              AppCubit.get(context).getComments(postId: model.postId!);
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
                            if(model.userId != uId)
                              InkWell(
                                // onTap: () {
                                //   AppCubit.get(context).addSharedPosts(
                                //       postId: model.postId!,
                                //       context: context);
                                // },
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
                                AppCubit.get(context).savedPostsId.any((element) => element == model.postId)?
                                AppCubit.get(context).removeSavedPost(
                                  postId: model.postId!,
                                ):AppCubit.get(context).addSavePosts(
                                  model: model,
                                );
                              },
                              child: Icon(
                                AppCubit.get(context).savedPostsId.any((element) => element == model.postId)
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
          if (model.image!.isNotEmpty && model.image!.length>1)
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
                      model
                          .image!
                          .length >
                          4
                          ? 4
                          : model
                          .image!
                          .length,
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
                                child: model

                                    .image!
                                    .length >
                                    4
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
                                model.likes
                                !.any((element) =>
                                element ==
                                    AppCubit.get(context)
                                        .user!
                                        .uId)
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
                              AppCubit.get(context).getComments(
                                  postId: model.postId!);
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
                            if(model.userId != uId)
                              InkWell(
                                // onTap: () {
                                //   AppCubit.get(context).addSharedPosts(
                                //       postId: AppCubit.get(context)
                                //           .postsId[index],
                                //       index: index,
                                //       context: context);
                                // },
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
                                AppCubit.get(context)
                                    .savedPostsId.any((element) =>
                                element ==model.postId
                                )
                                    ? AppCubit.get(context).removeSavedPost(
                                  postId: model.postId!,
                                )
                                    :
                                AppCubit.get(context).addSavePosts(
                                  model: model,
                                );
                              },
                              child: Icon(
                                AppCubit.get(context)
                                    .savedPostsId.any((element) =>
                                element ==model.postId
                                )
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
                          model.likes
                          !.any((element) =>
                          element ==
                              AppCubit.get(context)
                                  .user!
                                  .uId)
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
                        AppCubit.get(context).getComments(
                            postId: model.postId!);
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
                        onTap: () {},
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
                          AppCubit.get(context)
                              .savedPostsId.any((element) =>
                          element ==model.postId
                          )
                              ? AppCubit.get(context).removeSavedPost(
                            postId: model.postId!,
                          )
                              :
                          AppCubit.get(context).addSavePosts(
                            model: model,
                          );
                        },
                        child: Icon(
                          AppCubit.get(context)
                              .savedPostsId.any((element) =>
                          element ==model.postId
                          )
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
  // Widget buildShareItem(List<SharePostModel> posts, index, context) => Card(
  //       color: const Color(0xffE6EEFA),
  //       clipBehavior: Clip.none,
  //       child: Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 CircleAvatar(
  //                   backgroundImage: NetworkImage(
  //                     '${AppCubit.get(context).user!.image}',
  //                   ),
  //                   radius: 25,
  //                 ),
  //                 const SizedBox(
  //                   width: 20,
  //                 ),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Text(
  //                                     '${AppCubit.get(context).user!.name}',
  //                                     style: const TextStyle(
  //                                       height: 1.4,
  //                                       fontSize: 16,
  //                                       color: Colors.black,
  //                                       fontWeight: FontWeight.w900,
  //                                       fontFamily: 'Poppins',
  //                                     ),
  //                                   ),
  //                                   const Icon(
  //                                     Icons.verified,
  //                                     size: 16,
  //                                     color: Colors.blue,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Container(
  //               height: 1,
  //               color: Colors.grey,
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             Row(
  //               children: [
  //                 CircleAvatar(
  //                   backgroundImage: NetworkImage(
  //                     '${posts[index].userImage}',
  //                   ),
  //                   radius: 25,
  //                 ),
  //                 const SizedBox(
  //                   width: 20,
  //                 ),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Row(
  //                                 children: [
  //                                   Text(
  //                                     '${posts[index].userName}',
  //                                     style: const TextStyle(
  //                                       height: 1.4,
  //                                       fontSize: 16,
  //                                       color: Colors.black,
  //                                       fontWeight: FontWeight.w900,
  //                                       fontFamily: 'Poppins',
  //                                     ),
  //                                   ),
  //                                   const Icon(
  //                                     Icons.verified,
  //                                     size: 16,
  //                                     color: Colors.blue,
  //                                   ),
  //                                 ],
  //                               ),
  //                               Text(
  //                                 '${posts[index].date}',
  //                                 style: const TextStyle(
  //                                   height: 1.4,
  //                                   fontSize: 12,
  //                                   color: Colors.grey,
  //                                   fontWeight: FontWeight.w400,
  //                                   fontFamily: 'Poppins',
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           const Spacer(),
  //                           if (posts[index].userId == uId)
  //                             IconButton(
  //                               onPressed: () {
  //                                 AppCubit.get(context).deletePost(
  //                                     AppCubit.get(context).postsId[index]);
  //                               },
  //                               icon: const Icon(
  //                                 Icons.delete,
  //                                 size: 20,
  //                                 color: Colors.grey,
  //                               ),
  //                             ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 8.0),
  //               child: Divider(
  //                 color: Colors.grey[350],
  //                 height: 1,
  //               ),
  //             ),
  //             Text(
  //               '${posts[index].text}',
  //             ),
  //             const SizedBox(
  //               height: 10,
  //             ),
  //             if (posts[index].image != '')
  //               Container(
  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: Stack(
  //                   alignment: AlignmentDirectional.bottomCenter,
  //                   children: [
  //                     GridView.count(
  //                       physics: const BouncingScrollPhysics(),
  //                       shrinkWrap: true,
  //                       crossAxisCount: 2,
  //                       mainAxisSpacing: 10,
  //                       crossAxisSpacing: 10,
  //                       childAspectRatio: 1 / 1,
  //                       children: List.generate(
  //                         posts[index].image!.length > 4
  //                             ? 4
  //                             : posts[index].image!.length,
  //                         (index1) => Column(
  //                           children: [
  //                             Expanded(
  //                               child: InkWell(
  //                                 onTap: () {
  //                                   navigateTo(
  //                                       context: context,
  //                                       screen: ViewImagesScreen(
  //                                           view: posts,
  //                                           index1: index,
  //                                           index2: index1,
  //                                           id: AppCubit.get(context)
  //                                               .myPostsId));
  //                                 },
  //                                 child: posts[index].image!.length > 4
  //                                     ? index1 == 3
  //                                         ? Stack(
  //                                             alignment: Alignment.center,
  //                                             children: [
  //                                               Image.network(
  //                                                 posts[index].image![index1],
  //                                                 fit: BoxFit.cover,
  //                                                 width: double.infinity,
  //                                               ),
  //                                               Text(
  //                                                 '${posts[index].image!.length - 4}+',
  //                                                 style: const TextStyle(
  //                                                   color: Colors.white,
  //                                                   fontSize: 25,
  //                                                   fontWeight:
  //                                                       FontWeight.bold,
  //                                                 ),
  //                                               ),
  //                                             ],
  //                                           )
  //                                         : Image.network(
  //                                             posts[index].image![index1],
  //                                             width: double.infinity,
  //                                   fit: BoxFit.cover,
  //                                           )
  //                                     : Image.network(
  //                                         posts[index].image![index1],
  //                                         fit: BoxFit.cover,
  //                                         width: double.infinity,
  //                                       ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       width: double.infinity,
  //                       color: Colors.black.withOpacity(0.6),
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Row(
  //                           children: [
  //                             const Icon(
  //                               Icons.favorite_outline_rounded,
  //                               size: 18,
  //                               color: Colors.white,
  //                             ),
  //                             const SizedBox(width: 5),
  //                             Text(
  //                               '${posts[index].likes?.length}',
  //                               style: const TextStyle(
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                             const SizedBox(width: 20),
  //                             InkWell(
  //                               onTap: () {},
  //                               child: const Icon(
  //                                 Icons.comment_outlined,
  //                                 size: 18,
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                             const Spacer(),
  //                             InkWell(
  //                               onTap: () {},
  //                               child: const Icon(
  //                                 Icons.share_outlined,
  //                                 size: 18,
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                             const SizedBox(width: 20),
  //                             InkWell(
  //                               onTap: () {},
  //                               child: const Icon(
  //                                 Icons.bookmark_border_outlined,
  //                                 size: 18,
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             if (posts[index].image == '')
  //               Container(
  //                 width: double.infinity,
  //                 color: Colors.black.withOpacity(0.6),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Row(
  //                     children: [
  //                       InkWell(
  //                         onTap: () {},
  //                         child: const Icon(
  //                           Icons.favorite_outline_rounded,
  //                           size: 18,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                       const SizedBox(width: 5),
  //                       Text(
  //                         '${posts[index].likes?.length}',
  //                         style: const TextStyle(
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                       const SizedBox(width: 20),
  //                       InkWell(
  //                         onTap: () {},
  //                         child: const Icon(
  //                           Icons.comment_outlined,
  //                           size: 18,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                       const Spacer(),
  //                       InkWell(
  //                         onTap: () {},
  //                         child: const Icon(
  //                           Icons.share_outlined,
  //                           size: 18,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                       const SizedBox(width: 20),
  //                       InkWell(
  //                         onTap: () {},
  //                         child: const Icon(
  //                           Icons.bookmark_border_outlined,
  //                           size: 18,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ),
  //     );
}
