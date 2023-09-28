import 'dart:io';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var nameController = TextEditingController();
var bioController = TextEditingController();
var phoneController = TextEditingController();

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isArabic = lang == 'ar';
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is UserModelUpdateSuccessState) {
          showFlushBar(
            context: context,
            message: isArabic ? 'تم تحديث البيانات بنجاح' : 'Data updated successfully',
          );
        }
      },
      builder: (context, state) {
        var userModel = AppCubit.get(context).user;
        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bool isProfileImageChanged = profileImage != null;
        bool isCoverImageChanged = coverImage != null;
        bool isCoverImageEmpty = coverImage == null;
        return Scaffold(
          backgroundColor: const Color(0xFF3E657B),
          appBar: defaultAppBar(
            context: context,
            title: isArabic ? 'تعديل الحساب' : 'Edit Profile',
            action: [
              TextButton(
                onPressed: () {
                  AppCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                  );

                },
                child: Text(
                  isArabic ? 'تحديث' : 'Update',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).user != null,
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is UserModelUpdateLoadingState)
                      LinearProgressIndicator(
                        color: defaultColor,
                        backgroundColor: defaultColor.withOpacity(0.5),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: GestureDetector(
                              onTap: () {
                                AppCubit.get(context).getCoverImage();
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    child: ConditionalBuilder(
                                      condition: coverImage == null,
                                      builder: (context) {
                                        // Load the image from the network if coverImage is null
                                        return Image(
                                          image: NetworkImage('${userModel.cover}'),
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      fallback: (context) {
                                        // Provide a fallback widget when there's an issue with the URL or loading the image
                                        return Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(coverImage!) as ImageProvider,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.blue,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                AppCubit.get(context).getProfileImage();
                              },
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: CircleAvatar(
                                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                        backgroundImage: profileImage == null
                                            ? NetworkImage('${userModel.image}')
                                            : FileImage(profileImage) as ImageProvider,
                                        radius: 60,
                                      ),
                                    ),
                                  ),
                                  const CircleAvatar(
                                    radius: 22,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.blue,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    if (isProfileImageChanged || isCoverImageChanged)
                      Row(
                        children: [
                          if (isProfileImageChanged || isCoverImageChanged)
                            Expanded(
                              child: Column(
                                children: [
                                  if (isProfileImageChanged)

                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.white),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          AppCubit.get(context).uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                          );
                                        },
                                        child: Text(
                                          isArabic ? 'تحديث صوره' : 'Update Profile',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),

                                  if (isCoverImageChanged)
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.white),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          AppCubit.get(context).uploadCoverImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                          );
                                        },
                                        child: Text(
                                          isArabic ? 'تحديث صوره' : 'Update Cover',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),

                                  if (state is UserModelUpdateLoadingState)
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  if (state is UserModelUpdateLoadingState)
                                    LinearProgressIndicator(
                                      color: defaultColor,
                                      backgroundColor: defaultColor.withOpacity(0.5),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    if (isProfileImageChanged || isCoverImageChanged)
                      const SizedBox(
                        height: 20,
                      ),
                    reusableTextFormField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      prefixColor: Colors.white,
                      onTap: () {},
                      controller: nameController,
                      obscure: false,
                      prefix: const Icon(
                        Icons.person,
                      ),
                      keyboardType: TextInputType.text,
                      label: isArabic ? 'الأسم' : 'Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return isArabic ? 'الاسم يجب الا يكون فارغا' : 'Name must not be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextFormField(
                      label: 'Enter the number',
                      prefixColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      onTap: () {},
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Platform.isIOS
                ? const CupertinoActivityIndicator()
                : Center(child: CircularProgressIndicator(color: defaultColor)),
          ),
        );
      },
    );
  }

  PreferredSizeWidget? defaultAppBar({
    required BuildContext context,
    String? title,
    List<Widget>? action,
  }) =>
      AppBar(
        backgroundColor: defaultColor,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          title!,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: action,
      );
}
