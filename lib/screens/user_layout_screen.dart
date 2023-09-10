import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/add_posts/add_posts_screen.dart';
import 'package:alex_uni_new/screens/chat_screens/chat_screen.dart';
import 'package:alex_uni_new/screens/profile_screen/profile_screen.dart';
import 'package:alex_uni_new/screens/user_screens/settings_details_screen_layout.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class UserLayout extends StatelessWidget {
  const UserLayout({Key? key}) : super(key: key);
  static String id = 'userlayout';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppCubit.get(context).titles[AppCubit.get(context).currentIndex],
            ),
          ),
          drawer: isGuest==false? Drawer(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${AppCubit.get(context).user?.image}',
                        ),
                        radius: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 5),
                      child: Text(
                        '${AppCubit.get(context).user?.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${AppCubit.get(context).user?.email}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(
                          context: context,
                          screen: const ProfileScreen(),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              lang == 'en' ? 'My Profile' : 'الملف الشخصي',
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.inbox,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              lang == 'en' ? 'Messages' : 'الرسائل',
                            ),
                            Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.favorite,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              lang == 'en' ? 'Favourites' : 'المفضلة',
                            ),
                            Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.newspaper,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              lang == 'en' ? 'News' : 'الاخبار',
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {
                        navigateTo(
                            context: context, screen: SettingsLayoutScreen());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.settings,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              lang == 'en' ? 'Settings' : 'الاعدادات',
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_rounded,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              lang == 'en' ? 'Help' : 'المساعدة',
                            ),
                            Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: reusableElevatedButton(
                        label: lang == 'ar' ? 'تسجيل الخروج' : 'Logout',
                        backColor: defaultColor,
                        height: 40,
                        function: () {
                          AppCubit.get(context).logout(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ): null,
          body:
              AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: AppCubit.get(context).bottomNavIcons,
            backgroundColor: const Color(0xffE6EEFA),
            elevation: 10,
            activeColor: defaultColor,
            activeIndex: AppCubit.get(context).currentIndex,
            gapLocation: GapLocation.center,
            onTap: (index) {
              if (isGuest == false) {
                if (index == 1) {
                  navigateTo(context: context, screen: ChatScreen());
                } else {
                  AppCubit.get(context).changeBottomNavBar(index);
                }
              }else {
                showFlushBar(
                    context: context,
                    message: lang == 'en'
                        ? 'You must login first'
                        : 'يجب عليك تسجيل الدخول اولا');
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if(isGuest==false) {
                navigateTo(
                context: context,
                screen: const AddPostsScreen(),
              );
              }else{
                showFlushBar(context: context, message: lang=='en'?'You must login first':'يجب عليك تسجيل الدخول اولا');
              }
            },
            backgroundColor: defaultColor,
            child: const Icon(
              Icons.add,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}

//          bottomNavigationBar: BottomNavigationBar(
//             selectedItemColor: defaultColor,
//             currentIndex: AppCubit.get(context).currentIndex,
//             onTap: (index) {
//               AppCubit.get(context).changeBottomNavBar(index);
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: const Icon(
//                   Icons.home,
//                 ),
//                 label: lang == 'en' ? 'Home' : 'الرئيسية',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.chat,
//                 ),
//                 label: lang == 'en' ? 'Chat' : 'المحادثات',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.settings,
//                 ),
//                 label: lang == 'en' ? 'Settings' : 'الاعدادات',
//               ),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               navigateTo(
//                 context: context,
//                 screen: const AddPostsScreen(),
//               );
//             },
//             child: const Icon(
//               Icons.add,
//             ),
//           ),
