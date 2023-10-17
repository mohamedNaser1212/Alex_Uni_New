import 'package:alex_uni_new/constants/cache_helper.dart';
import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/login_cubit.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/auth/registeration_screen.dart';
import 'package:alex_uni_new/screens/auth/reset_password_screen.dart';
import 'package:alex_uni_new/screens/user_layout_screen.dart';
import 'package:alex_uni_new/states/login_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

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
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: uId).then((value) {
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
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: double.infinity,
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
                            height: MediaQuery.of(context).size.height * 0.11,
                          ),
                          Image.asset('assets/images/University.png'),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(36),
                                  topRight: Radius.circular(36),
                                ),
                              ),
                              child: Center(
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      textDirection: textDirection,
                                      children: [
                                        Text(
                                          isArabic ? 'تسجيل الدخول' : 'Log in',
                                          style: TextStyle(
                                            fontFamily: lang == 'ar'
                                                ? 'arabic2'
                                                : 'poppins',
                                            fontSize: lang == 'ar'
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .aspectRatio *
                                                    53
                                                : MediaQuery.of(context)
                                                        .size
                                                        .aspectRatio *
                                                    61,
                                            fontWeight: FontWeight.w800,
                                            color: const Color.fromARGB(
                                              255,
                                              26,
                                              49,
                                              72,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 28,
                                        ),
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
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          cursorColor: const Color.fromARGB(
                                              255, 28, 64, 99),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.all(9),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          textDirection: textDirection,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          isArabic ? 'كلمة المرور' : 'Password',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff7B8189),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextFormField(
                                          cursorColor: const Color.fromARGB(
                                            255,
                                            28,
                                            64,
                                            99,
                                          ),
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                cubit.changeVisibility();
                                              },
                                              icon: Icon(
                                                cubit.isvisible
                                                    ? IconlyBold.lock
                                                    : IconlyBold.unlock,
                                                color: defaultColor,
                                              ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(9),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          obscureText: cubit.isvisible,
                                          onFieldSubmitted: (value) {
                                            cubit.userLogin(
                                                email: globalEmail!,
                                                password: value);
                                          },
                                          textDirection: textDirection,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                        const SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                navigateTo(
                                                  context: context,
                                                  screen: ResetPasswordScreen(),
                                                );
                                              },
                                              child: Text(
                                                isArabic
                                                    ? 'نسيت كلمة المرور ؟'
                                                    : 'Forgot Password ?',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                    196,
                                                    57,
                                                    87,
                                                    104,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                        ),
                                        ConditionalBuilder(
                                          condition:
                                              state is! LoginLoadingState,
                                          builder: (context) {
                                            return Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: InkWell(
                                                      onTap: () {
                                                        isGuest = true;
                                                        uId = null;
                                                        navigateAndFinish(
                                                          context: context,
                                                          screen:
                                                              const UserLayout(),
                                                        );
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xff3E657B),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color(
                                                              0xffffffff),
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
                                                                    TextStyle(
                                                                  fontFamily: lang ==
                                                                          'ar'
                                                                      ? 'arabic2'
                                                                      : 'poppins',
                                                                  fontSize: 20,
                                                                  color: const Color(
                                                                      0xff3E657B),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 7,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .arrow_forward_ios_outlined,
                                                                color: Color(
                                                                    0xff3E657B),
                                                                size: 16,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          cubit.userLogin(
                                                            email: globalEmail!,
                                                            password:
                                                                globalPassword!,
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 52,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: const Color(
                                                              0xff3E657B),
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
                                                                    TextStyle(
                                                                  fontFamily: lang ==
                                                                          'ar'
                                                                      ? 'arabic2'
                                                                      : 'poppins',
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .white,
                                                                size: 23,
                                                              ),
                                                            ],
                                                          ),
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
                                        // const SizedBox(
                                        //   height: 30,
                                        // ),
                                        // InkWell(
                                        //   onTap: (){
                                        //     cubit.googleSignIn(
                                        //         context: context,
                                        //         phone: 'phone',
                                        //         address: 'address',
                                        //         country: 'country',
                                        //         universityName: 'universityName',
                                        //         underGraduate: true,
                                        //         postGraduate: false,
                                        //         passportId: 'passportId'
                                        //     );
                                        //   },
                                        //   child: Center(child: Logo(Logos.google)),
                                        // ),
                                        // const SizedBox(height: 10),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              isArabic
                                                  ? 'ليس لدي حساب؟'
                                                  : 'Don\'t have an account?',
                                              style: TextStyle(
                                                fontFamily: lang == 'ar'
                                                    ? 'arabic2'
                                                    : 'poppins',
                                                fontSize: 14,
                                                color: const Color.fromARGB(
                                                    182, 18, 67, 96),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                navigateTo(
                                                  context: context,
                                                  screen:
                                                      const RegistrationScreen(),
                                                );
                                              },
                                              child: Text(
                                                isArabic
                                                    ? 'سجل الأن'
                                                    : 'Sign Up Now',
                                                style: TextStyle(
                                                  fontFamily: lang == 'ar'
                                                      ? 'arabic2'
                                                      : 'poppins',
                                                  fontWeight: FontWeight.w900,
                                                  color:
                                                      const Color(0xff124460),
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
            ),
          );
        },
      ),
    );
  }
}
