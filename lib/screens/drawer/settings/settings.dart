// ignore_for_file: avoid_print
import 'dart:ui';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/constants/strings.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/user_model.dart';
import 'package:alex_uni_new/screens/auth/change_password/change_password.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/drawer/settings/edit_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class Settings extends StatefulWidget {
  // Add a parameter to receive the current locale and toggle function

  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        UserModel userModel = cubit.user!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              lang == "en" ? settings : settingsArabic,
              style: TextStyle(
                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                lang == 'en'
                    ? IconlyBold.arrow_left_circle
                    : IconlyBold.arrow_right_circle,
                color: defaultColor,
                size: 35,
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.28,
                      margin: const EdgeInsets.only(
                        right: 17,
                        left: 17,
                        bottom: 12,
                        top: 55,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 160, 158, 158),
                        borderRadius: BorderRadius.circular(21),
                        image: DecorationImage(
                          image: NetworkImage('${userModel.cover}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(107, 34, 56, 69),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 48),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          userModel.name!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.007,
                                        ),
                                        Text(
                                          userModel.email!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                161, 255, 255, 255),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    child: InkWell(
                                      onTap: () {
                                        navigateTo(
                                          context: context,
                                          screen: const EditProfile(),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: lang == 'en' ? 11 : 6,
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 11),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                            255,
                                            76,
                                            113,
                                            135,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        child: Text(
                                          lang == 'en' ? edit : editArabic,
                                          style: TextStyle(
                                            fontFamily: lang == 'ar'
                                                ? 'arabic2'
                                                : 'poppins',
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.13,
                          backgroundColor: Colors.white,
                          child: Container(
                            decoration: const BoxDecoration(),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                              radius: MediaQuery.of(context).size.width * 0.12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cubit.settingsTitles.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              margin: const EdgeInsets.symmetric(vertical: 7),
                              decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: index != 2
                                  ? ListTile(
                                      title: Text(
                                        cubit.settingsTitles[index],
                                        style: TextStyle(
                                          fontFamily: lang == 'ar'
                                              ? 'arabic2'
                                              : 'poppins',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      leading: Icon(
                                        cubit.settingsIcons[index],
                                        color: Colors.white,
                                      ),
                                      trailing: DropdownButton<Locale>(
                                        borderRadius: BorderRadius.circular(13),
                                        iconEnabledColor: Colors.white,
                                        dropdownColor: defaultColor,
                                        enableFeedback: true,
                                        icon:
                                            const Icon(IconlyBold.arrow_down_2),
                                        iconSize: 22,
                                        underline: Container(
                                          height: 0,
                                        ),
                                        value: lang == 'en'
                                            ? const Locale('en')
                                            : const Locale('ar'),
                                        onChanged: (newLocale) {
                                          cubit.changeAppLanguage(
                                            context: context,
                                            newLocale: newLocale,
                                          );
                                        },
                                        items: const [
                                          DropdownMenuItem(
                                            value: Locale('en'),
                                            child: Text(
                                              'EN',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: Locale('ar'),
                                            child: Text(
                                              'AR',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListTile(
                                      title: Text(
                                        cubit.settingsTitles[index],
                                        style: TextStyle(
                                          fontFamily: lang == 'ar'
                                              ? 'arabic2'
                                              : 'poppins',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      leading: Icon(
                                        cubit.settingsIcons[index],
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ],
                        );
                      }
                      if (index == 1) {
                        return InkWell(
                          onTap: () {
                            navigateTo(
                                context: context, screen: ChangePassword());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: index != 2
                                ? ListTile(
                                    title: Text(
                                      cubit.settingsTitles[index],
                                      style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'arabic2'
                                            : 'poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    leading: Icon(
                                      cubit.settingsIcons[index],
                                      color: Colors.white,
                                    ),
                                    trailing: Icon(
                                      lang == 'en'
                                          ? Icons.keyboard_arrow_right
                                          : Icons.keyboard_arrow_left,
                                      color: Colors.white,
                                    ),
                                  )
                                : ListTile(
                                    title: Text(
                                      cubit.settingsTitles[index],
                                      style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'arabic2'
                                            : 'poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    leading: Icon(
                                      cubit.settingsIcons[index],
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        );
                      }
                      if (index == 2) {
                        return InkWell(
                          onTap: () {
                            setState(
                              () {
                                AppCubit.get(context).customDialog(
                                  title: lang == "en"
                                      ? customDialogTitle
                                      : customDialogTitleArabic,
                                  desc1: lang == "en"
                                      ? customDialogDeleteAccount
                                      : customDialogDeleteAccountArabic,
                                  desc2: lang == "en"
                                      ? customDialogDesc2
                                      : customDialogDesc2Arabic,
                                  leftBtnText: lang == "en"
                                      ? customDialogCancelBtn
                                      : customDialogCancelBtnArabic,
                                  rightBtnText: lang == "en"
                                      ? customDialogDeleteBtn
                                      : customDialogDeleteBtnArabic,
                                  rightBtn: () {
                                    AppCubit.get(context).deleteUser(
                                      context: context,
                                      id: uId!,
                                    );
                                  },
                                  leftBtn: () {
                                    Navigator.pop(context);
                                  },
                                  context: context,
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: index != 2
                                ? ListTile(
                                    title: Text(
                                      cubit.settingsTitles[index],
                                      style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'arabic2'
                                            : 'poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    leading: Icon(
                                      cubit.settingsIcons[index],
                                      color: Colors.white,
                                    ),
                                  )
                                : ListTile(
                                    title: Text(
                                      cubit.settingsTitles[index],
                                      style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'arabic2'
                                            : 'poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    leading: Icon(
                                      cubit.settingsIcons[index],
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        );
                      }
                      if (index == 3) {
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            decoration: BoxDecoration(
                              color: defaultColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: index != 2
                                ? ListTile(
                                    title: Text(
                                      cubit.settingsTitles[index],
                                      style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'arabic2'
                                            : 'poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    leading: Icon(
                                      cubit.settingsIcons[index],
                                      color: Colors.white,
                                    ),
                                    trailing: Icon(
                                      lang == 'en'
                                          ? Icons.keyboard_arrow_right
                                          : Icons.keyboard_arrow_left,
                                      color: Colors.white,
                                    ),
                                  )
                                : ListTile(
                                    title: Text(
                                      cubit.settingsTitles[index],
                                      style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'arabic2'
                                            : 'poppins',
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    leading: Icon(
                                      cubit.settingsIcons[index],
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                if (isGuest == false)
                  InkWell(
                    onTap: () {
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
                          cubit.logout(context);
                        },
                        context: context,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      margin: const EdgeInsets.symmetric(horizontal: 17),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 218, 33, 19),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            lang == 'en' ? logoutBtn : logoutBtnArabic,
                            style: TextStyle(
                              fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            IconlyBold.logout,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
