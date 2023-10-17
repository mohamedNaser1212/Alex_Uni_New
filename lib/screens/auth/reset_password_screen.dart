import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/login_cubit.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/states/login_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is ResetPasswordSuccessState) {
            showFlushBar(
              context: context,
              message: 'تم إرسال البريد الإلكتروني بنجاح',
            );
            Navigator.pop(context);
          } else if (state is ResetPasswordErrorState) {
            showFlushBar(context: context, message: state.error);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                lang == 'ar' ? 'استرجاع كلمة المرور' : 'Reset Password',
                style: TextStyle(
                  fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                  fontSize: lang == 'ar' ? 16 : 14,
                  color: const Color.fromARGB(255, 41, 71, 88),
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
                              style: TextStyle(
                                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xff0D3961),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              lang == 'ar'
                                  ? 'من فضلك قم بإدخال البريد الالكتروني الذي تريد اعادة كلمة المرور الخاصة به'
                                  : 'Please enter the email address you\'d like your password reset information sent to',
                              style: TextStyle(
                                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: const Color.fromARGB(198, 37, 44, 51),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromARGB(255, 225, 234, 239),
                                filled: true,
                                hintText: lang == 'ar'
                                      ? 'البريد الإلكتروني'
                                      : 'Email',
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
                                      ? 'يرجى إدخال البريد الإلكتروني'
                                      : 'Please enter your email';
                                } else if (!value.contains('@')) {
                                  return lang == 'ar'
                                      ? 'البريد الإلكتروني غير صالح'
                                      : 'Invalid email format';
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
                                condition: state is! LoginLoadingState,
                                builder: (context) {
                                  return Center(
                                    child: InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.resetPassword(
                                            email: emailController.text,
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
                                                    ? 'ارسال البريد الإلكتروني'
                                                    : 'Reset Password',
                                                style: TextStyle(
                                                  fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
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
      ),
    );
  }
}
