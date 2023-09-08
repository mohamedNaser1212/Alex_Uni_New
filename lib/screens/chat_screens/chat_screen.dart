import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/user_model.dart';
import 'package:alex_uni_new/screens/chat_screens/chat_tab.dart';
import 'package:alex_uni_new/screens/chat_screens/college_tab.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: defaultColor,
            appBar: AppBar(
              backgroundColor: defaultColor,
              elevation: 0.6,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              title: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    child: Text(
                      lang == 'en' ? 'Chat' : 'المحادثات',
                    ),
                  ),
                  Tab(
                    child: Text(
                      lang == 'en' ? 'College' : 'الكليات,',
                    ),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: TabBarView(
                  children: [
                    ChatTab(),
                    CollegeTab(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
