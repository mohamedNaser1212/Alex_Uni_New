import 'dart:io';

import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/drawer/settings/edit_screen.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/constants.dart';
import '../cubit/app_cubit.dart';
import '../models/user_model.dart';
import '../states/app_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isArabic = lang == 'ar';

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.user != null,
          builder: (context) {
            return Column(
              children: [
                getUser(AppCubit.get(context).user!, context, isArabic),
                ConditionalBuilder(
                  condition: state is! AppLogoutLoadingState,
                  builder: (context) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          cubit.logout(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                        child: Text(
                          isArabic ? 'تسجيل الخروج' : 'Logout',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  fallback: (context) => Platform.isIOS
                      ? const Center(child: CupertinoActivityIndicator())
                      : Center(
                    child:
                    CircularProgressIndicator(color: defaultColor),
                  ),
                ),
              ],
            );
          },
          fallback: (context) => Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: defaultColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getUser(UserModel model, context, isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic
                      ? 'مرحبا: ${model.name}'
                      : 'Hello: ${model.name}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '${model.email}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  isArabic
                      ? 'رقم الهاتف: ${model.phone}'
                      : 'Phone: ${model.phone}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            isArabic ? 'اعدادات الحساب' : 'Account Settings',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                      context: context,
                      screen: const EditProfile(),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        isArabic ? 'تعديل الحساب' : 'Edit Profile',
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    AppCubit.get(context).deleteUser(
                      context: context,
                      id: uId!,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        isArabic ? 'ازاله الحساب' : 'Delete Account',
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.delete,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
