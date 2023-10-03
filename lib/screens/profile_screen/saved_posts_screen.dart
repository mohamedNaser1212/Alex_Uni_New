import 'package:alex_uni_new/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/app_cubit.dart';
import '../../models/post_model.dart';
import '../../reusable_widgets.dart';
import '../../states/app_states.dart';
import '../comments/comments_screen.dart';
import '../person_profile/person_profile_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {

      },
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

  Widget savedPostsItems(BuildContext context,PostModel model,) => Card(
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
                    onTap: (){
                      if(AppCubit.get(context).user!.uId != model.userId) {
                        navigateTo(
                          context: context,
                          screen: PersonProfileScreen(
                            userId:model.userId,
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
                                      onTap:(){
                                        if(AppCubit.get(context).user!.uId !=
                                            model.userId) {
                                          navigateTo(
                                          context: context,
                                          screen:
                                          PersonProfileScreen(
                                            userId: model.userId,
                                          ),
                                        );
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
                                    fontWeight: FontWeight.w900,
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
              Text(
                '${model.text}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
                      children: List.generate(model.image!.length > 4
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
                                  //           id: AppCubit.get(context).postsId));
                                  // },
                                  child: model.image!.length > 4 ? index1 == 3
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Image.network(
                                              model
                                                  .image![index1],
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  AppCubit.get(context).getComments(postId: model.postId!,);
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
                            InkWell(
                                onTap: () {
                                  AppCubit.get(context).removeSavedPost(postId: model.postId!);
                                },
                                child:const  Icon(
                                  Icons.bookmark,
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
            ],
          ),
        ),
      );
}
