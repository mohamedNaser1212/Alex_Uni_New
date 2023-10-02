import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/both_news_model.dart';
import 'package:alex_uni_new/models/both_news_model.dart';
import 'package:alex_uni_new/models/news_model.dart';
import 'package:alex_uni_new/models/post_model.dart';
import 'package:alex_uni_new/models/university_model.dart';
import 'package:alex_uni_new/screens/comments/comments_screen.dart';
import 'package:alex_uni_new/screens/news_screen/arabic_news_details_screen.dart';
import 'package:alex_uni_new/screens/news_screen/english_news_details_screen.dart';
import 'package:alex_uni_new/screens/person_profile/person_profile_screen.dart';
import 'package:alex_uni_new/screens/profile_screen/profile_screen.dart';
import 'package:alex_uni_new/screens/universties/university_details_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../reusable_widgets.dart';
import '../view_image_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          color: Colors.white,
          backgroundColor: defaultColor,
          onRefresh: () async {
            await AppCubit.get(context).getPosts();
          },
          child: ConditionalBuilder(
            condition: state is! GetPostsLoadingState,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      12,
                    ),
                    child: Text(
                      lang == 'en' ? 'Faculties' : 'الكليات',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Universities')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              UniversityModel model = UniversityModel.fromJson(
                                  ds.data()! as Map<String, dynamic>?);
                              model.id = ds.id;
                              return buildFacultyItem(
                                context,
                                model,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 15,
                            ),
                            itemCount: snapshot.data!.docs.length,
                          );
                        } else {
                          return  Center(
                            child: Text(lang=='en'?'No Data Found':'لا يوجد بيانات'),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      12,
                    ),
                    child: Text(
                      lang == 'en' ? 'News' : 'الاخبار',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.37,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: lang=='ar'? StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('News')
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              ArabicNewsModel model = ArabicNewsModel.fromJson(
                                  ds.data()! as Map<String, dynamic>?);
                              return buildNewsItem(
                                context: context,
                                model: model,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 15,
                            ),
                            itemCount: snapshot.data!.docs.length,
                          );
                        } else {
                          return  Center(
                            child: Text(lang=='en'?'No Data Found':'لا يوجد بيانات'),
                          );
                        }
                      },
                    ):StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('News')
                          .where('type',isEqualTo: 'both')
                          .orderBy('date', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              DocumentSnapshot ds = snapshot.data!.docs[index];
                              BothNewsModel model = BothNewsModel.fromJson(
                                  ds.data()! as Map<String, dynamic>?);
                              return buildNewsItem(
                                context: context,
                                model: model,
                              );
                            },
                            separatorBuilder: (context, index) =>
                            const SizedBox(
                              width: 15,
                            ),
                            itemCount: snapshot.data!.docs.length,
                          );
                        } else {
                          return Center(
                            child: Text(lang == 'en'
                                ? 'No Data Found'
                                : 'لا يوجد بيانات'),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lang == 'en' ? 'Posts' : 'المنشورات',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        90,
                      ),
                    ),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildPostItem(
                          AppCubit.get(context).posts,
                          AppCubit.get(context).post[index],
                          index,
                          context),
                      itemCount: AppCubit.get(context).posts.length,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
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

  Widget buildFacultyItem(context, UniversityModel model) => InkWell(
        onTap: () async {
          await AppCubit.get(context).getDepartments(
            universityId: model.id!,
          );
          navigateTo(
            context: context,
            screen: UniversityDetailsScreen(
              university: model,
            ),
          );
        },
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: MediaQuery.of(context).size.width / 7.7,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.of(context).size.width / 8.5,
                child: Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${model.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget buildNewsItem({
    required BuildContext context,
    model,
  }) => InkWell(
        onTap: () {
          if(model is ArabicNewsModel) {
            navigateTo(
            context: context,
            screen: ArabicNewsDetailsScreen(
              newsModel: model,
            ),
          );
          }
          else{
            navigateTo(
              context: context,
              screen: BothNewsDetailsScreen(
                newsModel: model,
              ),
            );
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xffE6EEFA),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Image(
                  image: NetworkImage(model.images[0]!),
                  height: 120,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${model.date}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Text(
                '${model.title}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  model.descriptions[0]!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),

                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      );

  Widget? buildPostItem(
    List posts,
    PostModel model,
    index,
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
                      if(!isGuest) {
                        navigateTo(
                          context: context,
                          screen: AppCubit.get(context).user!.uId ==
                              posts[index].values.single.userId
                              ? const ProfileScreen()
                              : PersonProfileScreen(
                            userId: posts[index].values.single.userId,
                          ),
                        );
                      }
                      else{
                        navigateTo(context: context, screen: PersonProfileScreen(
                          userId: posts[index].values.single.userId,
                        ));
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${posts[index].values.single.userImage}',
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
                                        if(!isGuest) {
                                          navigateTo(
                                          context: context,
                                          screen: AppCubit.get(context).user!.uId ==
                                              posts[index].values.single.userId
                                              ? const ProfileScreen()
                                              : PersonProfileScreen(
                                            userId: posts[index].values.single.userId,
                                          ),
                                        );
                                        }
                                        else{
                                          navigateTo(context: context, screen: PersonProfileScreen(
                                            userId: posts[index].values.single.userId,
                                          ));
                                        }
                                      },
                                      child: Text(
                                        '${posts[index].values.single.userName}',
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
                                  '${posts[index].values.single.date}',
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
                            if (posts[index].values.single.userId == uId)
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
                '${posts[index].values.single.text}',
              ),
              const SizedBox(
                height: 10,
              ),
              if(posts[index].values.single.image.isNotEmpty && posts[index].values.single.image.length==1)
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Image.network(
                        AppCubit.get(context)
                            .posts[index]
                            .values
                            .single
                            .image![0],
                        width: double.infinity,
                        height:200,
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
                                      AppCubit.get(context).posts[index],
                                    );
                                  },
                                  child: Icon(
                                    AppCubit.get(context)
                                        .posts[index]
                                        .values
                                        .single
                                        .likes
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
                                  '${posts[index].values.single.likes.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              if (isGuest == false) const SizedBox(width: 20),
                              InkWell(
                                onTap: () {
                                  AppCubit.get(context).getComments(
                                      postId:
                                      AppCubit.get(context).postsId[index]);
                                  navigateTo(
                                    context: context,
                                    screen: CommentsScreen(
                                      postId:
                                      AppCubit.get(context).postsId[index],
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
                                if(AppCubit.get(context).posts[index].values.single.userId != uId)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context).addSharedPosts(
                                          postId: AppCubit.get(context)
                                              .postsId[index],
                                          index: index,
                                          context: context);
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
                                    AppCubit.get(context).addSavePosts(
                                      postId: AppCubit.get(context).postsId[index],
                                      index: index,
                                      text: posts[index].values.single.text,
                                      date: posts[index].values.single.date,
                                      userName: posts[index].values.single.userName,
                                      userImage: posts[index].values.single.userImage,
                                      userId: posts[index].values.single.userId,
                                      likes: posts[index].values.single.likes,
                                      image: posts[index].values.single.image,
                                    );
                                  },
                                  child: Icon(
                                    AppCubit.get(context)
                                        .savedPosts.any((element) =>
                                    element.postId ==
                                        AppCubit.get(context)
                                            .postsId[index]
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
              if (posts[index].values.single.image.isNotEmpty && posts[index].values.single.image.length>1)
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
                          AppCubit.get(context)
                                      .posts[index]
                                      .values
                                      .single
                                      .image!
                                      .length >
                                  4
                              ? 4
                              : AppCubit.get(context)
                                  .posts[index]
                                  .values
                                  .single
                                  .image!
                                  .length,
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
                                              view: AppCubit.get(context).posts,
                                              index1: index,
                                              index2: index1,
                                              id: AppCubit.get(context)
                                                  .postsId));
                                    },
                                    child: AppCubit.get(context)
                                                .posts[index]
                                                .values
                                                .single
                                                .image!
                                                .length >
                                            4
                                        ? index1 == 3
                                            ? Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Image.network(
                                                    AppCubit.get(context)
                                                        .posts[index]
                                                        .values
                                                        .single
                                                        .image![index1],
                                                    width: double.infinity,
                                                  ),
                                                  Text(
                                                    '${AppCubit.get(context).posts[index].values.single.image!.length - 4}+',
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
                                                AppCubit.get(context)
                                                    .posts[index]
                                                    .values
                                                    .single
                                                    .image![index1],
                                                width: double.infinity,
                                              )
                                        : Image.network(
                                            AppCubit.get(context)
                                                .posts[index]
                                                .values
                                                .single
                                                .image![index1],
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
                                      AppCubit.get(context).posts[index],
                                    );
                                  },
                                  child: Icon(
                                    AppCubit.get(context)
                                        .posts[index]
                                        .values
                                        .single
                                        .likes
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
                                  '${posts[index].values.single.likes.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              if (isGuest == false) const SizedBox(width: 20),
                              InkWell(
                                onTap: () {
                                  AppCubit.get(context).getComments(
                                      postId:
                                          AppCubit.get(context).postsId[index]);
                                  navigateTo(
                                    context: context,
                                    screen: CommentsScreen(
                                      postId:
                                          AppCubit.get(context).postsId[index],
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
                                if(AppCubit.get(context).posts[index].values.single.userId != uId)
                                  InkWell(
                                  onTap: () {
                                    AppCubit.get(context).addSharedPosts(
                                        postId: AppCubit.get(context)
                                            .postsId[index],
                                        index: index,
                                        context: context);
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
                                    AppCubit.get(context).addSavePosts(
                                      postId: AppCubit.get(context).postsId[index],
                                      index: index,
                                      text: posts[index].values.single.text,
                                      date: posts[index].values.single.date,
                                      userName: posts[index].values.single.userName,
                                      userImage: posts[index].values.single.userImage,
                                      userId: posts[index].values.single.userId,
                                      likes: posts[index].values.single.likes,
                                      image: posts[index].values.single.image,
                                    );
                                  },
                                  child: Icon(
                                    AppCubit.get(context)
                                        .savedPosts.any((element) =>
                                    element.postId ==
                                        AppCubit.get(context)
                                            .postsId[index]
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
              if (posts[index].values.single.image.isEmpty)
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
                                AppCubit.get(context).posts[index],
                              );
                            },
                            child: Icon(
                              AppCubit.get(context)
                                  .posts[index]
                                  .values
                                  .single
                                  .likes
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
                            '${posts[index].values.single.likes.length}',
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
                                postId: AppCubit.get(context).postsId[index]);
                            navigateTo(
                              context: context,
                              screen: CommentsScreen(
                                postId: AppCubit.get(context).postsId[index],
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
                              AppCubit.get(context).addSavePosts(
                                  postId: AppCubit.get(context).postsId[index],
                                  index: index,
                                  text: posts[index].values.single.text,
                                  date: posts[index].values.single.date,
                                  userName: posts[index].values.single.userName,
                                  userImage: posts[index].values.single.userImage,
                                  userId: posts[index].values.single.userId,
                                  likes: posts[index].values.single.likes,
                                  image: posts[index].values.single.image,
                              );
                            },
                            child: Icon(
                              AppCubit.get(context)
                                  .savedPosts.any((element) =>
                              element.postId ==
                                  AppCubit.get(context)
                                      .postsId[index]
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
}
