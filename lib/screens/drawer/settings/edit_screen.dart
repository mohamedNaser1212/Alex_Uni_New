import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

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
            message: isArabic
                ? 'تم تحديث البيانات بنجاح'
                : 'Data updated successfully',
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
        // bool isCoverImageEmpty = coverImage == null;
        return WillPopScope(
          onWillPop: () async {
            AppCubit.get(context).coverImage = null;
            AppCubit.get(context).profileImage = null;
            return true;
          },
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              backgroundColor: const Color(0xfffdfdfd),
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 251, 253, 254),
                iconTheme: const IconThemeData(),
                title: Text(
                  isArabic ? 'تعديل البيانات' : 'Edit Profile',
                  style: const TextStyle(),
                ),
                actions: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      AppCubit.get(context).updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                      );
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 62, 165, 66),
                            borderRadius: BorderRadius.circular(13)),
                        child: Text(
                          isArabic ? 'تحديث' : 'Update',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
                                      if (AppCubit.get(context).coverImage ==
                                              null &&
                                          userModel.cover == '')
                                        Container(
                                          width: double.infinity,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          color: Colors.grey,
                                          child: const Placeholder(),
                                        ),
                                      if (AppCubit.get(context).coverImage !=
                                              null ||
                                          userModel.cover != '')
                                        Container(
                                          width: double.infinity,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(21),
                                          ),
                                          child: ConditionalBuilder(
                                            condition: coverImage == null,
                                            builder: (context) {
                                              return Image(
                                                image: NetworkImage(
                                                  '${userModel.cover}',
                                                ),
                                                height: 120,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                            fallback: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                        FileImage(coverImage!),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      Positioned(
                                        bottom: 2.5,
                                        right: 2,
                                        child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: defaultColor,
                                            child: const Icon(
                                              IconlyBold.camera,
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
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        child: Container(
                                          decoration: const BoxDecoration(),
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            backgroundImage:
                                                profileImage == null
                                                    ? NetworkImage(
                                                        '${userModel.image}')
                                                    : FileImage(profileImage)
                                                        as ImageProvider,
                                            radius: 60,
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: defaultColor,
                                          child: const Icon(
                                            IconlyBold.camera,
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 61, 175, 65),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              AppCubit.get(context)
                                                  .uploadProfileImage(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                              );
                                            },
                                            child: Text(
                                              isArabic
                                                  ? 'تحديث الصورة الشخصية'
                                                  : 'Update Profile',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (isCoverImageChanged)
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 61, 175, 65),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              AppCubit.get(context)
                                                  .uploadCoverImage(
                                                name: nameController.text,
                                                phone: phoneController.text,
                                              );
                                            },
                                            child: Text(
                                              isArabic
                                                  ? 'تحديث الخلفية'
                                                  : 'Update Cover',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
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
                                          backgroundColor:
                                              defaultColor.withOpacity(0.5),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 225, 234, 239),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Color.fromARGB(197, 82, 90, 98),
                                  ),
                                  contentPadding: const EdgeInsets.all(9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return isArabic
                                        ? 'الاسم يجب الا يكون فارغا'
                                        : 'Name must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                onTap: () {},
                                decoration: InputDecoration(
                                  fillColor:
                                      const Color.fromARGB(255, 225, 234, 239),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    IconlyBold.call,
                                    color: Color.fromARGB(197, 82, 90, 98),
                                  ),
                                  contentPadding: const EdgeInsets.all(9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: bioController,
                                keyboardType: TextInputType.text,
                                minLines: 1,
                                maxLines: 3,
                                autocorrect: true,
                                onTap: () {},
                                decoration: InputDecoration(
                                  hintText: "tell us about yourself",
                                  fillColor:
                                      const Color.fromARGB(255, 225, 234, 239),
                                  filled: true,
                                  prefixIcon: const Icon(
                                    IconlyBold.document,
                                    color: Color.fromARGB(197, 82, 90, 98),
                                  ),
                                  contentPadding: const EdgeInsets.all(9),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                fallback: (context) =>
                    CircularProgressIndicator(color: defaultColor),
              ),
            ),
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
            color: Colors.black,
          ),
        ),
        title: Text(
          title!,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
        actions: action,
      );
}
