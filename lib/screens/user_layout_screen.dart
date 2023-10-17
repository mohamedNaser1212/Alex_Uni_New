import 'package:alex_uni_new/constants/strings.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/screens/profile/saved_posts_screen.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/drawer/settings/settings.dart';
import 'package:alex_uni_new/screens/home/posts/add_posts_screen.dart';
import 'package:alex_uni_new/screens/auth/login_screen.dart';
import 'package:alex_uni_new/screens/drawer/news/drawer_news_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../constants/constants.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({Key? key}) : super(key: key);
  static String id = 'userlayout';

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  GlobalKey<ScaffoldState> scafKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    if (isGuest == false) {
      AppCubit.get(context).getUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scafKey,
          extendBodyBehindAppBar:
              AppCubit.get(context).currentIndex == 3 ? true : false,
          extendBody: true,
          appBar: AppBar(
            leading: AppCubit.get(context).currentIndex == 0
                ? IconButton(
                    onPressed: () {
                      scafKey.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu_rounded,
                    ),
                  )
                : Container(),
            backgroundColor: AppCubit.get(context).currentIndex == 0
                ? const Color(0xfffdfdfd)
                : Colors.transparent,
            elevation: AppCubit.get(context).currentIndex == 0 ? 2.3 : 0,
            centerTitle: AppCubit.get(context).currentIndex == 0 ? false : true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isGuest == true)
                  Text(
                    lang == 'ar' ? 'ضيف,' : "Hello sir,",
                    style: TextStyle(
                      fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                      color: const Color.fromARGB(255, 151, 151, 151),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                if (isGuest == false)
                  if (AppCubit.get(context).currentIndex == 0)
                    Text(
                      AppCubit.get(context).user?.name.toString() ??
                          "Kareem Ehab",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 151, 151, 151),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                if (AppCubit.get(context).currentIndex == 0)
                  Text(
                    AppCubit.get(context)
                        .titles[AppCubit.get(context).currentIndex],
                    style: TextStyle(
                      fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                      color: const Color.fromARGB(255, 53, 53, 53),
                      fontSize: 18.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                //---------------PROFILE TITLE------------------
                // if(AppCubit.get(context).currentIndex != 0)
                // Text(
                //   AppCubit.get(context).titles[AppCubit.get(context).currentIndex],
                //   style: const TextStyle(
                //     color: Color.fromARGB(255, 53, 53, 53),
                //     fontSize: 22.5,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
              ],
            ),
            actions: [
              if (isGuest)
                IconButton(
                  onPressed: () {
                    isGuest = false;
                    navigateTo(
                      context: context,
                      screen: const LoginScreen(),
                    );
                  },
                  icon: Icon(
                    IconlyBold.login,
                    color: defaultColor,
                  ),
                ),
            ],
          ),
          drawer: isGuest == false
              ? Drawer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                      '${AppCubit.get(context).user?.image}',
                                    ),
                                    radius: MediaQuery.of(context).size.width *
                                        0.112,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  child: Text(
                                    '${AppCubit.get(context).user?.name}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${AppCubit.get(context).user?.email}',
                                  style: const TextStyle(
                                    fontSize: 14.2,
                                    color: Color.fromARGB(255, 101, 101, 101),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 17,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        IconlyBold.message,
                                        color: defaultColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        lang == 'en' ? 'Messages' : 'الرسائل',
                                        style: TextStyle(
                                          fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
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
                              const Padding(
                                padding: EdgeInsets.only(right: 108, left: 15),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SavedScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 17,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        IconlyBold.heart,
                                        color: defaultColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        lang == 'en' ? 'Saved' : 'المحفوظة',
                                        style: TextStyle(
                                          fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
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
                              const Padding(
                                padding: EdgeInsets.only(right: 108, left: 15),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigateTo(
                                    context: context,
                                    screen: const DrawerNewsScreen(),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 17,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.newspaper,
                                        color: defaultColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        lang == 'en' ? 'News' : 'الاخبار',
                                        style: TextStyle(
                                          fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
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
                              const Padding(
                                padding: EdgeInsets.only(right: 108, left: 15),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigateTo(
                                    context: context,
                                    screen: const Settings(),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 17,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        IconlyBold.setting,
                                        color: defaultColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        lang == 'en' ? 'Settings' : 'الاعدادات',
                                        style: TextStyle(
                                          fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
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
                              const Padding(
                                padding: EdgeInsets.only(right: 108, left: 15),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 17,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        IconlyBold.info_circle,
                                        color: defaultColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        lang == 'en' ? 'Help' : 'المساعدة',
                                        style: TextStyle(
                                          fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                        ),
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
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 41,
                          vertical: 8.0,
                        ),
                        child: reusableElevatedButton(
                          label: lang == 'ar' ? 'تسجيل الخروج' : 'Logout',
                          backColor: const Color.fromARGB(255, 211, 41, 29),
                          height: MediaQuery.of(context).size.height * 0.063,
                          function: () {
                            setState(() {
                              AppCubit.get(context).customDialog(
                        title: lang == "en"
                            ? customDialogTitle
                            : customDialogTitleArabic,
                        desc1: lang == "en"
                            ? customDialogLeaveDesc
                            : customDialogLeaveDescArabic,
                        hasDesc2: false,
                        crossAxis: CrossAxisAlignment.center,
                        leftBtnText: lang == "en"
                            ? customDialogCancelBtn
                            : customDialogCancelBtnArabic,
                        rightBtnText: lang == "en"
                            ? customDialogLogoutBtn
                            : customDialogLogoutBtnArabic,
                        leftBtn: () {
                          Navigator.pop(context);
                        },
                        rightBtn: () {
                          AppCubit.get(context).logout(context);
                        },
                        context: context,
                      );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : null,
          body:
              AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: !isGuest
              ? AnimatedBottomNavigationBar(
                  shadow: const BoxShadow(
                    color: Color.fromARGB(174, 66, 84, 109),
                    blurRadius: 23,
                    spreadRadius: 16,
                  ),
                  splashColor: defaultColor,
                  icons: AppCubit.get(context).bottomNavIcons,
                  backgroundColor: const Color(0xffE6EEFA),
                  elevation: 10,
                  activeColor: defaultColor,
                  inactiveColor: inactiveColor,
                  activeIndex: AppCubit.get(context).currentIndex,
                  gapLocation: GapLocation.center,
                  onTap: (index) {
                    // if (index == 1) {
                    //   navigateTo(context: context, screen: ChatScreen());
                    // } else {
                    AppCubit.get(context).changeBottomNavBar(index);
                    // }
                  },
                )
              : null,
          floatingActionButton: !isGuest
              ? FloatingActionButton(
                  onPressed: () {
                    navigateTo(
                      context: context,
                      screen: const AddPostsScreen(),
                    );
                  },
                  backgroundColor: const Color.fromARGB(255, 54, 75, 105),
                  child: const Icon(
                    Icons.add,
                    size: 29,
                  ),
                )
              : null,
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
