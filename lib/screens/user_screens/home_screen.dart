import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/post_model.dart';
import 'package:alex_uni_new/models/university_model.dart';
import 'package:alex_uni_new/screens/chat_details/chat_details_screen.dart';
import 'package:alex_uni_new/screens/comments/comments_screen.dart';
import 'package:alex_uni_new/screens/universties/university_details_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../reusable_widgets.dart';
import '../view_image_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
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
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildFacultyItem(
                      context, AppCubit.get(context).universities[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: AppCubit.get(context).universities.length,
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
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildNewsItem(context),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 15,
                  ),
                  itemCount: 10,
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
                  // separatorBuilder: (context, index) => Container(
                  //   color: const Color(0xffE6EEFA),
                  //   height: 20,
                  // ),
                  itemCount: AppCubit.get(context).posts.length,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
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
                radius: MediaQuery.of(context).size.width / 8,
                child: Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Faculty of\n${model.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget buildNewsItem(context) => Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xffE6EEFA),
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: const Image(
                  image: NetworkImage(
                    'https://img.freepik.com/free-photo/stylish-korean-woman-calling-phone-talking-smartphone-looking-happy-upper-right-corner_1258-166198.jpg?w=1060&t=st=1691521908~exp=1691522508~hmac=7bb0edd5b037bcd7102d523d5f4bbd5074be8e8db3c2cc9e5c54bb87ed93d9b5',
                  ),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Text(
              'Just Now',
              style: TextStyle(
                color: Color(0xff7C7A7A),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'Title',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic',
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildPostItem(List posts, PostModel model, index, context) => Card(
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
                      '${posts[index].values.single.userImage}',
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
                                    InkWell(
                                      onTap: () {
                                        print(
                                            posts[index].values.single.userId);
                                        navigateTo(
                                          context: context,
                                          screen: ChatDetailsScreen(
                                            chatUserModel:
                                                posts[index].values.single,
                                          ),
                                        );
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
              if (posts[index].values.single.image.isNotEmpty)
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
                          AppCubit.get(context).posts[index].values.single.image!.length>4?4:AppCubit.get(context).posts[index].values.single.image!.length,
                              (index1) => Container(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      navigateTo(
                                          context: context,
                                          screen:  ViewImagesScreen(
                                              view: AppCubit.get(context).posts,
                                              index1: index,
                                              index2: index1,
                                              id: AppCubit.get(context)
                                                  .postsId));
                                    },
                                    child:AppCubit.get(context).posts[index].values.single.image!.length>4? index1==3? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.network(
                                          AppCubit.get(context).posts[index].values.single.image![index1],
                                          width: double.infinity,
                                        ),
                                        Text(
                                          '${AppCubit.get(context).posts[index].values.single.image!.length-4}+',
                                          style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        ),
                                      ],
                                    ):Image.network(
                                      AppCubit.get(context).posts[index].values.single.image![index1],
                                      width: double.infinity,
                                    ): Image.network(
                                      AppCubit.get(context).posts[index].values.single.image![index1],
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
                              if(isGuest==false)
                              InkWell(
                                onTap: () {
                                    AppCubit.get(context).updatePostLikes(
                                      AppCubit.get(context).posts[index],
                                    );
                                },
                                child: Icon(
                                  Icons.favorite_outline_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                              if(isGuest==false)
                              const SizedBox(width: 5),
                              if(isGuest==false)
                              Text(
                                '${posts[index].values.single.likes.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              if(isGuest==false)
                              const SizedBox(width: 20),
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
                              if(isGuest==false)
                              InkWell(
                                onTap: () {
                                  AppCubit.get(context).addSharedPosts(
                                      postId:
                                          AppCubit.get(context).postsId[index],
                                      index: index,
                                      context: context);
                                },
                                child: const Icon(
                                  Icons.share_outlined,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                              if(isGuest==false)
                              const SizedBox(width: 20),
                              if(isGuest==false)
                              InkWell(
                                onTap: () {
                                  AppCubit.get(context).addSavePosts(
                                      postId:
                                          AppCubit.get(context).postsId[index],
                                      index: index);
                                },
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
              if (posts[index].values.single.image == '')
                Container(
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        if(isGuest == false)
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).updatePostLikes(
                              AppCubit.get(context).posts[index],
                            );
                          },
                          child: const Icon(
                            Icons.favorite_outline_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        if(isGuest==false)
                        const SizedBox(width: 5,),
                        if(isGuest==false)
                        Text(
                          '${posts[index].values.single.likes.length}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        if(isGuest==false)
                        const SizedBox(width: 20,),
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
                        if(isGuest==false)
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.share_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        if(isGuest==false)
                        const SizedBox(width: 20),
                        if(isGuest==false)
                        InkWell(
                          onTap: () {
                            AppCubit.get(context).addSavePosts(
                                postId: AppCubit.get(context).postsId[index],
                                index: index);
                          },
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
