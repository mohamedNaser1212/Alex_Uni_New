import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/admin_model.dart';
import 'package:alex_uni_new/states/app_states.dart';

import '../../models/message_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({Key? key, required this.chatUserModel})
      : super(key: key);
  final AdminModel? chatUserModel;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).receiveMessages(receiverId: chatUserModel!.id!);
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    AppCubit.get(context).postGraduate = [];
                    AppCubit.get(context).underGraduate = [];
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: defaultColor,
                title: Row(
                  children: [
                    Text(
                      '${chatUserModel?.name}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: state is! UploadImageLoadingState,
                builder: (context) => Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: AppCubit.get(context).messages.length,
                        itemBuilder: (context, index) {
                          return buildMessage(
                              AppCubit.get(context).messages[index], context);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 5,
                        ),
                      ),
                    ),
                    MessageBar(
                      sendButtonColor: defaultColor,
                      onSend: (value) {
                        AppCubit.get(context).sendMessage(
                          receiverId: chatUserModel!.id!,
                          text: value.toString(),
                          image: '',
                        );
                      },
                      actions: [
                        InkWell(
                          child: Icon(
                            Icons.add,
                            color: defaultColor,
                            size: 24,
                          ),
                          onTap: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: InkWell(
                            child: Icon(
                              Icons.camera_alt,
                              color: defaultColor,
                              size: 24,
                            ),
                            onTap: () {
                              AppCubit.get(context).pickPhoto(
                                  source: ImageSource.gallery,
                                  receiverId: chatUserModel!.id!);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
      },
    );
  }
}

Widget buildMessage(
  MessageModel messageModel,
  context,
) {
  return messageModel.message != ''
      ? BubbleNormal(
          text: '${messageModel.message}',
          isSender: messageModel.senderId == uId ? true : false,
          color: messageModel.senderId == uId ? defaultColor : Colors.grey,
          tail: true,
          textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
      : BubbleNormalImage(
          id: 'id001',
          image: Image(image: NetworkImage('${messageModel.image}')),
          color: messageModel.senderId == uId ? defaultColor : Colors.grey,
          isSender: messageModel.senderId == uId ? true : false,
          tail: true,
          delivered: true,
        );
}
