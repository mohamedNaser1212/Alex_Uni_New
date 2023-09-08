import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/profile_screen/photos_screen.dart';
import 'package:alex_uni_new/screens/profile_screen/saved_tab.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/user_model.dart';
import '../edit_screen/edit_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        AppCubit cubit = AppCubit.get(context);
        UserModel userModel = cubit.user!;

        return DefaultTabController(
          length: 3,
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(

                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomStart,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                  ),
                                ),
                                child: userModel.cover != null
                                    ? Image(
                                        image:
                                            NetworkImage('${userModel.cover}'),
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.logout(context);
                                        },
                                        icon: const Icon(
                                          Icons.logout,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  backgroundImage: NetworkImage(
                                    '${userModel.image}',
                                  ),
                                  radius: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            '${userModel.name}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 18,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (lang == 'en')
                        Text(
                          '${userModel.bio ?? 'Add Bio...'}',
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                      if (lang == 'ar')
                        Text(
                          '${userModel.bio ?? 'اضف نبذة عنك...'}',
                          style: Theme.of(context).textTheme.bodyMedium!,
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      '100',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      lang == 'en' ? 'Posts' : 'منشورات',
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      '100',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      lang == 'en' ? 'Followers' : 'متابعين',
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      '100',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      lang == 'en' ? 'Following' : 'متابعة',
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: reusableElevatedButton(
                            label: lang == 'en'
                                ? 'Edit Profile'
                                : 'تعديل الملف الشخصي',
                            backColor: defaultColor,
                            height: 40,
                            function: () {
                              navigateTo(context: context, screen: EditProfile());
                            },
                          ),),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: reusableElevatedButton(
                            label: lang == 'en'
                                ? 'photos'
                            : 'الصور',
                            backColor: defaultColor,
                            height: 40,
                            function: () {
                              navigateTo(context: context, screen: PhotoScreen());
                            },
                          ),),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(child: reusableElevatedButton(
                            label: lang == 'en'
                                ? 'Saved'
                            : 'المحفوظات',
                            backColor: defaultColor,
                            height: 40,
                            function: () {
                              navigateTo(context: context, screen: SavedScreen());
                            },
                          ),),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
