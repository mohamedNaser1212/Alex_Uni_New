import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/post_model.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../models/message_model.dart';


class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key, required this.chatUserModel}) : super(key: key);
  final PostModel? chatUserModel;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).receiveMessage(receiverId: chatUserModel!.userId!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.red,
                title: Text(
                  '${chatUserModel?.userName}',
                ),
              ),
              body: ConditionalBuilder(
                  condition: state is ! UploadImageLoadingState,
                  builder: (context)=>Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: AppCubit.get(context).messages.length,
                          itemBuilder: (context, index) {
                            return buildMessage(
                                AppCubit.get(context).messages[index],context);
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            height: 5,
                          ),
                        ),
                      ),
                      MessageBar(
                        onSend: (value) {
                          AppCubit.get(context).sendMessage(
                            receiverId: chatUserModel!.userId!,
                            text: value.toString(),
                            dateTime: DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(DateTime.now().toUtc()).toString(),

                          );

                        },
                        actions: [
                          InkWell(
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 24,
                            ),
                            onTap: () {},
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: InkWell(
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.green,
                                size: 24,
                              ),
                              onTap: () {
                                AppCubit.get(context).pickPhoto(
                                    source: ImageSource.gallery,
                                    receiverId: chatUserModel!.userId!
                                );

                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  fallback: (context)=>const Center(child: CircularProgressIndicator(color: Colors.red,),)
              ),
            );
          },
        );
      },
    );
  }
}
Widget buildMessage(MessageModel messageModel,context,) {
  return messageModel.message!=''? BubbleNormal(
    text: '${messageModel.message}',
    isSender: messageModel.senderId == uId ? true : false,
    color:
    messageModel.senderId == uId ? Colors.red : Colors.grey,
    tail: true,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  ):BubbleNormalImage(
    id: 'id001',
    image: Image(image: NetworkImage('${messageModel.image}')),
    color: messageModel.senderId == uId ? Colors.red : Colors.grey,
    isSender: messageModel.senderId == uId ? true : false,
    tail: true,
    delivered: true,
  );
}



