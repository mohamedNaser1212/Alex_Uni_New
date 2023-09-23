import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants.dart';
import '../../models/post_model.dart';

var commentsController = TextEditingController();

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({Key? key,required this.postId}) : super(key: key);

  final String postId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Comments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.separated(
                itemBuilder: (context,index)=>comments(
                  AppCubit.get(context).comments,
                    index,
                  context
                ),
                separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                itemCount: AppCubit.get(context).comments.length
            ),
            bottomNavigationBar: !isGuest? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: commentsController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write a comment',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      if(commentsController.text.isNotEmpty){
                        AppCubit.get(context).writeComment(
                          postId: postId,
                          text: commentsController.text,
                        );
                        commentsController.clear();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ):null,
        );
      },
    );
  }
  Widget comments(List<CommentDataModel>data,index,context){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              data[index].ownerImage,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding:const  EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data[index].ownerName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data[index].text,
                      style:const  TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if(uId==data[index].ownerId)
            IconButton(
                onPressed: (){
                  AppCubit.get(context).deleteComment(
                    index,
                    postId,
                  );
                },
                icon:const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
            ),
        ],
      ),
    );
  }
}
