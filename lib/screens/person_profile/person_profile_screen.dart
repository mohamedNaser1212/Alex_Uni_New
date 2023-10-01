import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../../cubit/app_cubit.dart';
import '../../models/user_model.dart';
import '../../reusable_widgets.dart';
import '../../states/app_states.dart';
import '../view_image_screen.dart';

class PersonProfileScreen extends StatefulWidget {
   PersonProfileScreen({super.key, this.userId});

  final String ? userId;
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
        if(state is GetSelectedUserSuccessState) {
          AppCubit.get(context).getSelectedUserPosts(AppCubit.get(context).selectedUser!.uId!);
        }
        if(state is GetSelectedUserPostsSuccessState) {
          widget.showPost = true;
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: ConditionalBuilder(
              condition: widget.showPost,
              builder: (context){
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
                          alignment: AlignmentDirectional.bottomStart,
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
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: MediaQuery.of(context).size.width * 0.035,
                              ),
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
                            padding: EdgeInsetsDirectional.only(
                              top: 10,
                              start: MediaQuery.of(context).size.width * 0.06,),
                            alignment: Alignment.center,
                            height: 30,
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
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
                            child: Column(
                              children: [
                                Text(
                                  'posts',
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
                                      AppCubit.get(context).selectedUserPosts, index, context),
                                  itemCount: AppCubit.get(context).selectedUserPosts.length,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => buildShareItem(
                                      AppCubit.get(context).selectedUserSharedPosts, index, context),
                                  itemCount: AppCubit.get(context).selectedUserSharedPosts.length,
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
              fallback: (context) => Center(child: CircularProgressIndicator(
                color: defaultColor,
              ),),
            ),
          ),
        );
      },
    );
  }

  Card? buildMyPostItem(List posts, index, context) => Card(
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
                  '${posts[index].userImage}',
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
                                  '${posts[index].userName}',
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
                              '${posts[index].date}',
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
                        if (posts[index].userId == uId)
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).deletePost(
                                  AppCubit.get(context).postsId[index]);
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
            '${posts[index].text}',
          ),
          const SizedBox(
            height: 10,
          ),
          if (posts[index].image.isNotEmpty)
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
                      posts[index].image.length > 4
                          ? 4
                          : posts[index].image!.length,
                          (index1) => Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                navigateTo(
                                    context: context,
                                    screen: ViewImagesScreen(
                                        view: posts,
                                        index1: index,
                                        index2: index1,
                                        id: AppCubit.get(context)
                                            .myPostsId));
                              },
                              child: posts[index]
                                  .image!
                                  .length >
                                  4
                                  ? index1 == 3
                                  ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    posts[index]
                                        .image![index1],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Text(
                                    '${posts[index].image!.length - 4}+',
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
                                posts[index]
                                    .image![index1],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              )
                                  : Image.network(
                                posts[index]
                                    .image![index1],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ],
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
                          InkWell(
                            onTap: () {
                              AppCubit.get(context).updatePostLikes(
                                AppCubit.get(context).posts[index],
                              );
                            },
                            child: Icon(
                              AppCubit.get(context)
                                  .selectedUserPosts[index]
                                  .likes!
                                  .contains(uId)
                                  ? Icons.favorite
                                  : Icons.favorite_outline_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${posts[index].likes.length}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.comment_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              '${posts[index].comments.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.share_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.bookmark_border_outlined,
                              size: 18,
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
          if (posts[index].image.isEmpty)
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        AppCubit.get(context).updatePostLikes(
                          AppCubit.get(context).posts[index],
                        );
                      },
                      child: Icon(
                        AppCubit.get(context)
                            .selectedUserPosts[index]
                            .likes!
                            .contains(uId)
                            ? Icons.favorite
                            : Icons.favorite_outline_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${posts[index].likes.length}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.comment_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '${posts[index].comments.length}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.share_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.bookmark_border_outlined,
                        size: 18,
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
  Widget buildShareItem(List<SharePostModel> posts, index, context) => Card(
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
                  '${AppCubit.get(context).user!.image}',
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
                                  '${AppCubit.get(context).user!.name}',
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  '${posts[index].userImage}',
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
                                  '${posts[index].userName}',
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
                              '${posts[index].date}',
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
                        if (posts[index].userId == uId)
                          IconButton(
                            onPressed: () {
                              AppCubit.get(context).deletePost(
                                  AppCubit.get(context).postsId[index]);
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
            '${posts[index].text}',
          ),
          const SizedBox(
            height: 10,
          ),
          if (posts[index].image != '')
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
                      posts[index].image!.length > 4
                          ? 4
                          : posts[index].image!.length,
                          (index1) => Column(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                navigateTo(
                                    context: context,
                                    screen: ViewImagesScreen(
                                        view: posts,
                                        index1: index,
                                        index2: index1,
                                        id: AppCubit.get(context)
                                            .myPostsId));
                              },
                              child: posts[index].image!.length > 4
                                  ? index1 == 3
                                  ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.network(
                                    posts[index].image![index1],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Text(
                                    '${posts[index].image!.length - 4}+',
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
                                posts[index].image![index1],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                                  : Image.network(
                                posts[index].image![index1],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ],
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
                          const Icon(
                            Icons.favorite_outline_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${posts[index].likes?.length}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.comment_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              '${posts[index].comments?.length}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.share_outlined,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.bookmark_border_outlined,
                              size: 18,
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
          if (posts[index].image == '')
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.favorite_outline_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${posts[index].likes?.length}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.comment_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        '${posts[index].comments?.length}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.share_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.bookmark_border_outlined,
                        size: 18,
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
}