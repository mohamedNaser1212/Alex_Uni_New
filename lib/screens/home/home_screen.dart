import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/both_news_model.dart';
import 'package:alex_uni_new/models/news_model.dart';
import 'package:alex_uni_new/models/university_model.dart';
import 'package:alex_uni_new/screens/home/faculties/faculties_container.dart';
import 'package:alex_uni_new/screens/home/news/news_container.dart';
import 'package:alex_uni_new/screens/home/posts/posts.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    AppCubit.get(context).getPosts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !AppCubit.get(context).isLastPost) {
        AppCubit.get(context).getPostsFromLast();
      }
    });
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
              controller: _scrollController,
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
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.16,
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
                            separatorBuilder: (context, index) => const SizedBox(
                              width: 7,
                            ),
                            itemCount: snapshot.data!.docs.length,
                          );
                        } else {
                          return ShimmerFacultiesList(); // Shimmer effect for faculties
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
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.37,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: lang == 'ar'
                        ? StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('News')
                                .where('isFinished', isEqualTo: true)
                                .orderBy('date', descending: true)
                                .limit(2)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot ds =
                                        snapshot.data!.docs[index];
                                    ArabicNewsModel model =
                                        ArabicNewsModel.fromJson(ds.data()!
                                            as Map<String, dynamic>?);
                                    return buildNewsItem(
                                      context: context,
                                      model: model,
                                      index: index,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 15,
                                  ),
                                  itemCount: snapshot.data!.docs.length,
                                );
                              } else {
                                return ShimmerNewsList(); // Shimmer effect for news
                              }
                            },
                          )
                        : StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('News')
                                .where('type', isEqualTo: 'both')
                                .where('isFinished', isEqualTo: true)
                                .orderBy('date', descending: true)
                                .limit(2)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot ds =
                                        snapshot.data!.docs[index];
                                    BothNewsModel model =
                                        BothNewsModel.fromJson(ds.data()!
                                            as Map<String, dynamic>?);
                                    return buildNewsItem(
                                      context: context,
                                      model: model,
                                      index: index,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    width: 15,
                                  ),
                                  itemCount: snapshot.data!.docs.length,
                                );
                              } else {
                                return ShimmerNewsList(); // Shimmer effect for news
                              }
                            },
                          ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      lang == 'en' ? 'Posts' : 'المنشورات',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Color(0xffE6EEFA),
                    ),
                    child: AppCubit.get(context).post.isEmpty
                        ? ShimmerPostsList() // Use ShimmerPostsList widget for shimmer effect
                        : ListView.builder(
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
                                  child: buildPostItem(
                                      AppCubit.get(context).post[index],
                                      context),
                                );
                              } else {
                                return buildPostItem(
                                  AppCubit.get(context).post[index],
                                  context,
                                );
                              }
                            },
                            itemCount: AppCubit.get(context).post.length,
                          ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(
              child: ShimmerPostsList(),
            ),
          ),
        );
      },
    );
  }
}

class ShimmerNewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 200.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        },
        itemCount: 5, // Adjust the itemCount according to your needs
      ),
    );
  }
}

class ShimmerFacultiesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 120.0,
            margin: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        },
        itemCount: 5, // Adjust the itemCount according to your needs
      ),
    );
  }
}

class ShimmerPostsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xffE6EEFA),
      highlightColor: const Color(0xffE6EEFA),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 100.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xffE6EEFA),
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        },
        itemCount: 5, // Adjust the itemCount according to your needs
      ),
    );
  }
}
