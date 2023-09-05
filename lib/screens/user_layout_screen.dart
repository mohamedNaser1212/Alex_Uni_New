import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/add_posts/add_posts_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

class UserLayout extends StatelessWidget {
  const UserLayout({Key? key}) : super(key: key);

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
          drawer: Drawer(
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          '${AppCubit.get(context).user?.image}',
                        ),
                        radius: MediaQuery.of(context).size.width * 0.1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${AppCubit.get(context).user?.name}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${AppCubit.get(context).user?.email}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {},
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
                            Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
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
                    Divider(
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
                    Divider(
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
                            Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    InkWell(
                      onTap: () {},
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
                            Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
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
                    Divider(
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: reusableElevatedButton(
                        label: lang == 'ar' ? 'تسجيل الخروج' : 'Logout',
                        function: () {
                          AppCubit.get(context).logout(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body:
              AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: defaultColor,
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeBottomNavBar(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: lang == 'en' ? 'Home' : 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat,
                ),
                label: lang == 'en' ? 'Chat' : 'المحادثات',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: lang == 'en' ? 'Settings' : 'الاعدادات',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(
                context: context,
                screen: const AddPostsScreen(),
              );
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}
