import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var textController=TextEditingController();

class AddPostsScreen extends StatelessWidget {
  const AddPostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
        if(state is CreatePostSuccessState){
          textController.clear();
          showFlushBar(
              context: context,
              message: 'Post Successfully added',
          );
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add New Post',
            ),

          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText:
                      'What is on your mind , ${AppCubit.get(context).user!.name}',
                      border: InputBorder.none,
                    ),
                  ),
                  if(AppCubit.get(context).postImage!=null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              image: DecorationImage(
                                image:FileImage(AppCubit.get(context).postImage!),
                                fit: BoxFit.fill,
                              )),
                        ),
                        IconButton(
                          onPressed: () {
                            AppCubit.get(context).removePostImage();
                          },
                          icon: const CircleAvatar(
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              onPressed: () {
                                AppCubit.get(context).getPostImage();
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Add Photo'),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ConditionalBuilder(
            condition: state is! UserModelUpdateLoadingState,
            builder: (context){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 25),
                child: reusableElevatedButton(
                    label: 'Add Post',
                    function: (){
                      if(AppCubit.get(context).postImage!=null){
                        AppCubit.get(context).uploadPostImage(
                          text: textController.text,
                          context: context,
                        );
                      }else{
                        AppCubit.get(context).createPost(
                          text: textController.text,
                          image: '',
                          context: context,
                        );
                      }
                    }
                ),
              );
            },
            fallback: (context)=>const Center(child: CircularProgressIndicator(),),
          ),
        );
      },
    );
  }
}
