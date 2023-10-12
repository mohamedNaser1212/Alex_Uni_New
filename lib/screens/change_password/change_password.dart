import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

import '../../constants/constants.dart';
import '../../cubit/login_cubit.dart';
import '../../states/login_states.dart';
import '../../widgets/reusable_widgets.dart';

class ChangePassword extends StatelessWidget {
   ChangePassword({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is changePasswordSuccessState) {
          showFlushBar(
            context: context,
            message: lang=='ar'?'تم تحديث كلمه السر':'password updated',
          );


        } else if (state is ChangePasswordErrorState) {
          showFlushBar(context: context, message: lang=='en'?'something went wrong':'حدث خطأ ما');
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              lang == 'ar' ? 'تغيير كلمة المرور' : 'change Password',
              style: const TextStyle(
                color: Color.fromARGB(255, 41, 71, 88),
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                lang == 'ar'
                    ? Icons.keyboard_arrow_right_rounded
                    : Icons.keyboard_arrow_left_rounded,
                color: const Color(0xff3E657B),
                size: 35,
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 300,
                        child: SvgPicture.asset(
                          'assets/images/13246824_5191077.svg',
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            lang == 'ar'
                                ? 'استرجاع كلمة المرور'
                                : 'Forgot Password',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color(0xff0D3961),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            lang == 'ar'
                                ? 'يرجى إدخال كلمة المرور الجديدة'
                                : 'Please enter the password ',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(198, 37, 44, 51),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              fillColor:
                              const Color.fromARGB(255, 225, 234, 239),
                              filled: true,
                              hintText: lang == 'ar'
                                  ? 'ادخل كلمه السر'
                                  : 'Enter New password ',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color.fromARGB(197, 82, 90, 98),
                              ),
                              contentPadding: const EdgeInsets.all(9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return lang == 'ar'
                                    ? 'يرجى إدخال كلمه السر'
                                    : 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            decoration: InputDecoration(
                              fillColor:
                              const Color.fromARGB(255, 225, 234, 239),
                              filled: true,
                              hintText: lang == 'ar'
                                  ? 'تاكد السر'
                                  : 'Confirm password ',
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Color.fromARGB(197, 82, 90, 98),
                              ),
                              contentPadding: const EdgeInsets.all(9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return lang == 'ar'
                                    ? 'يرجى إدخال كلمه السر'
                                    : 'Please enter your password';
                              }else if(value != passwordController.text){
                                return lang == 'ar'
                                    ? 'كلمه السر غير متطابقه'
                                    : 'password not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 28.0),
                            child: ConditionalBuilder(
                              condition: state is! changePasswordLoadingState,
                              builder: (context) {
                                return Center(
                                  child: InkWell(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.changePassword(
                                          newPassword: passwordController.text,
                                        );
                                        Navigator.pop(context);
                                      }

                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(40),
                                        color: const Color(0xff3E657B),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              lang == 'ar'
                                                  ? 'تغيير كلمة المرور'
                                                  : 'change Password',
                                              style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              width: 9,
                                            ),
                                            const Icon(
                                              Icons.rocket_launch_outlined,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              fallback: (context) => Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/University.png",
                                    ),
                                    const SizedBox(
                                      height: 23,
                                    ),
                                    const CircularProgressIndicator(
                                      color: Color(0xff3E657B),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
