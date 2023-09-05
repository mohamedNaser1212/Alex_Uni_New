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
        if(state is UserModelUpdateSuccessState)
          {
            showFlushBar(
                context: context,
                message: isArabic?'تم تحديث البيانات بنجاح':'Data updated successfully',
            );
          }
      },
      builder: (context, state) {
        var userModel = AppCubit.get(context).user;
        var profileImage = AppCubit.get(context).profileImage;
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          backgroundColor: const Color(0xFF3E657B),
          appBar: defaultAppBar(
            context: context,
            title: isArabic ? 'تعديل الحساب' : 'Edit Profile',
            action: [
              TextButton(
                onPressed: (){
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
              condition: AppCubit.get(context).user!=null,
              builder: (context)=>SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      if(state is UserModelUpdateLoadingState)
                        LinearProgressIndicator(color: defaultColor,backgroundColor: defaultColor.withOpacity(0.5),),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 180,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 57,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage('${userModel.image}')
                                        : FileImage(profileImage) as ImageProvider,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).getProfileImage();
                                    },
                                    icon: const CircleAvatar(
                                      child: Icon(
                                          Icons.camera_alt
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if(AppCubit.get(context).profileImage!=null)
                        Row(
                          children: [
                            if(AppCubit.get(context).profileImage!=null)
                              Expanded(
                                child: Column(
                                  children: [
                                   reusableElevatedButton(
                                       label: isArabic?'تحديث الملف الشخصي':'Update Profile',
                                       function: (){
                                         AppCubit.get(context).uploadProfileImage(name: nameController.text,);
                                       }
                                   ),
                                    if(state is UserModelUpdateLoadingState)
                                      const SizedBox(
                                        height: 5,
                                      ),

                                    if(state is UserModelUpdateLoadingState)
                                      LinearProgressIndicator(color: defaultColor,backgroundColor: defaultColor.withOpacity(0.5),),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      if(AppCubit.get(context).profileImage!=null)
                        const SizedBox(
                          height: 20,
                        ),
                      reusableTextFormField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        prefixColor: Colors.white,
                        onTap: (){},
                        controller: nameController,
                        obscure: false,
                        prefix: const Icon(
                          Icons.person,
                        ),
                        keyboardType: TextInputType.text,
                        label: isArabic?'الأسم':'Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return isArabic?'الاسم يجب الا يكون فارغا':'name must not be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextFormField(
                          label: 'Enter the number',
                        prefixColor:Colors.white ,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                          onTap: (){},
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context)=>Platform.isIOS?const CupertinoActivityIndicator():Center(child: CircularProgressIndicator(color: defaultColor,),)
          ),
        );
      },
    );
  }
  PreferredSizeWidget? defaultAppBar({
    required BuildContext context,
    String ? title,
    List<Widget>?action,
  })=>AppBar(
    backgroundColor: defaultColor,
    centerTitle: false,
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
    ),
    title:  Text(
        title!,
      style: const TextStyle(
        color: Colors.white,
      )
    ),
    actions: action,
  );
}
