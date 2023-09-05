
import 'dart:io';

import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';

var messageController = TextEditingController();
var scrollController = ScrollController();

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key, required this.userModel,required this.index}) : super(key: key);

  final List? userModel;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).receiveMessage(userModel![index!].values.single.userId);
        return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = AppCubit.get(context);
              return Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: Text('${userModel![index!].values.single.userName}'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConditionalBuilder(
                    condition: state is! SelectImageSuccessState,
                    builder: (context)=>Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              controller: scrollController,
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 10.0,
                              ),
                              itemBuilder: (context, index) =>
                                  buildMessage(cubit.messages[index]['message'],context,index),
                              itemCount: cubit.messages.length),
                        ),
                      ],
                    ),
                    fallback: (context)=> Center(child:Platform.isIOS?const CupertinoActivityIndicator(): const CircularProgressIndicator(),),
                  ),
                ),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context)=>Container(
                              color: Colors.grey[300],
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.camera_alt),
                                      title: const Text('Camera'),
                                      onTap: (){
                                        cubit.pickPhoto(
                                            source: ImageSource.camera,
                                          receiverId: userModel![index!].values.single.userId,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.image),
                                      title: const Text('Gallery'),
                                      onTap: (){
                                        cubit.pickPhoto(
                                            source: ImageSource.gallery,
                                          receiverId: userModel![index!].values.single.userId,
                                        );
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.perm_media,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: reusableTextFormField(
                          onTap: (){},
                          controller: messageController,
                          obscure: false,
                          keyboardType: TextInputType.text,
                          label: 'Type your message here',
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                        onPressed: (){
                          if(messageController.text.isNotEmpty||messageController.text!=''){
                            cubit.sendMessage(
                              message: messageController.text,
                              dateTime: DateTime.now().toString(),
                              receiverId: userModel![index!].values.single.userId,
                              senderId: uId!,
                            );
                            messageController.clear();
                          }

                        },
                        icon: const Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget buildMessage(String message,context,index) {
    return message!=''? BubbleNormal(
      textStyle: TextStyle(
        fontSize: 18,
        color: AppCubit.get(context).messages[index]['receiverId'] == uId ? Colors.black : Colors.white,
      ),
      text: message,
      isSender: AppCubit.get(context).messages[index]['receiverId'] == uId ? false : true,
      color: AppCubit.get(context).messages[index]['receiverId'] == uId ? const Color(0xFFE8E8EE)
          : const Color(0xFF1B97F3),
      tail: true,
    ):BubbleNormalImage(
      id: 'id001',
      image: Image(
          image:NetworkImage('${AppCubit.get(context).messages[index]['image']}')
      ),
      color: Colors.blue,
      tail: true,
      delivered: true,
    );
  }
}
