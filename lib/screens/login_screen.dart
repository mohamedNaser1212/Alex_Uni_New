import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/cubit/login_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/reset_password_screen.dart';
import 'package:alex_uni_new/screens/user_layout_screen.dart';
import 'package:alex_uni_new/states/login_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:alex_uni_new/screens/registeration_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String? globalEmail;
  String? globalPassword;

  @override
  Widget build(BuildContext context) {
    bool isArabic = lang == 'ar';
    TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)  {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: uId).then((value){
              isGuest = false;
              navigateAndFinish(
                context: context,
                screen: const UserLayout(),
              );
            });
          }
          if (state is LoginErrorState) {
            showFlushBar(
              context: context,
              message: state.error,
            );
          }
        },
        builder: (context, state) {

          LoginCubit cubit = LoginCubit.get(context);

          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Background-image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset('assets/images/University.png'),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      textDirection: textDirection,
                                      children: [
                                        Text(
                                          isArabic ? 'تسجيل الدخول' : 'Log in',
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff0D3961),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          isArabic
                                              ? 'البريد الألكتروني'
                                              : 'Your Email',
                                          style: const TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff7B8189),
                                          ),
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                          textDirection: textDirection,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return isArabic
                                                  ? 'يرجى إدخال البريد الإلكتروني'
                                                  : 'Please enter your email';
                                            } else if (!value.contains('@')) {
                                              return isArabic
                                                  ? 'البريد الإلكتروني غير صالح'
                                                  : 'Invalid email format';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            globalEmail =
                                                value; // Set the value to the global variable
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          isArabic ? 'كلمه المرور' : 'Password',
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(15),
                                            ),
                                          ),
                                          obscureText: true,
                                          onFieldSubmitted: (value) {
                                            cubit.userLogin(
                                                email: globalEmail!,
                                                password: value);
                                          },
                                          textDirection: textDirection,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return isArabic
                                                  ? 'يرجى إدخال كلمة المرور'
                                                  : 'Please enter your password';
                                            }
                                            return null;
                                          },
                                          onChanged: (value) {
                                            globalPassword =
                                                value; // Set the value to the global variable
                                          },
                                        ),
                                        const SizedBox(height: 30),
                                        ConditionalBuilder(
                                          condition: state is! LoginLoadingState,
                                          builder: (context) {
                                            return Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      isGuest = true;
                                                      uId=null;
                                                      navigateAndFinish(
                                                        context: context,
                                                        screen:
                                                        const UserLayout(),
                                                      );
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          2.5,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          color: const Color(
                                                              0xff3E657B),
                                                        ),
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        color:
                                                        const Color(0xffffffff),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              isArabic
                                                                  ? 'ضيف'
                                                                  : 'Guest',
                                                              style:
                                                              const TextStyle(
                                                                fontSize: 26,
                                                                color: Color(
                                                                    0xff3E657B),
                                                                fontWeight:
                                                                FontWeight.w600,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .arrow_forward_ios_outlined,
                                                              color:
                                                              Color(0xff3E657B),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        cubit.userLogin(
                                                          email: globalEmail!,
                                                          password: globalPassword!,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          2.5,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                        color:
                                                        const Color(0xff3E657B),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              isArabic
                                                                  ? 'تسجيل'
                                                                  : 'Login',
                                                              style:
                                                              const TextStyle(
                                                                fontSize: 26,
                                                                color: Colors.white,
                                                                fontWeight:
                                                                FontWeight.bold,
                                                              ),
                                                              textAlign:
                                                              TextAlign.center,
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            const Icon(
                                                              Icons.arrow_forward,
                                                              color: Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          fallback: (context) => const Center(
                                            child: CircularProgressIndicator(
                                              color: Color(0xff3E657B),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            cubit.googleSignIn(
                                                context: context,
                                                phone: 'phone',
                                                address: 'address',
                                                country: 'country',
                                                universityName: 'universityName',
                                                underGraduate: true,
                                                postGraduate: false,
                                                passportId: 'passportId'
                                            );
                                          },
                                          child: Center(child: Logo(Logos.google)),
                                        ),
                                        const SizedBox(height: 10),
                                        const SizedBox(height: 28),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              isArabic
                                                  ? 'نسيت كلمة المرور؟'
                                                  : 'Forgot Password?',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff124460),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                navigateTo(
                                                  context: context,
                                                  screen: ResetPasswordScreen(),
                                                );
                                              },
                                              child: Text(
                                                isArabic
                                                    ? 'تغيير كلمة المرور'
                                                    : 'Reset Password',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Color(0xff124460),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              isArabic
                                                  ? 'ليس لدي حساب؟'
                                                  : 'Don\'t have an account?',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff124460),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                navigateTo(
                                                  context: context,
                                                  screen: const RegistrationScreen(),
                                                );
                                              },
                                              child: Text(
                                                isArabic
                                                    ? 'سجل الأن'
                                                    : 'Sign Up Now',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  color: Color(0xff124460),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
              ],
            ),
          );
        },
      ),
    );
  }
}
