import 'package:alex_uni_new/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/app_cubit.dart';
import '../../states/app_states.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: Implement listener if needed
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Saved Posts'),
              ),
              body: ListView.separated(
                  itemBuilder: (context,index)=>savedPostsItems(AppCubit.get(context).savedPosts, index, context),
                  separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                  itemCount: AppCubit.get(context).savedPosts.length
              ),
          );
        }


    );
  }

  Widget savedPostsItems(List<SavePostsModel> savedPosts, index, context) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 14),
    color: const Color(0xffE6EEFA),
    elevation: 8,
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
                  '${savedPosts[index].userImage}',
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
                                  '${savedPosts[index].userName}',
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
                              '${savedPosts[index].date}',
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
            '${savedPosts[index].text}',
          ),
          const SizedBox(
            height: 10,
          ),
          if (savedPosts[index].image != '')
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(46),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${savedPosts[index].image}',
                        ),
                      ),
                    ),
                    child: Image(
                      image: NetworkImage(
                          '${savedPosts[index].image}'),
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
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
                            '${savedPosts[index].likes?.length}',
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
          if (savedPosts[index].image == '')
            Container(
              width: double.infinity,
              color: Colors.black.withOpacity(0.6),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                      },
                      child: const Icon(
                        Icons.favorite_outline_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${savedPosts[index].likes?.length}',
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


