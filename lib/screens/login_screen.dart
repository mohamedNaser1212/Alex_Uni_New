import 'package:alex_uni_new/cubit/login_cubit.dart';
import 'package:alex_uni_new/screens/home_screen.dart';
import 'package:alex_uni_new/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:alex_uni_new/screens/registeration_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  String? email;

  String? password;

  bool isloading = false;

  String? globalEmail;

  @override
  Widget build(BuildContext context) {
    final selectedLocale = ModalRoute.of(context)!.settings.arguments as Locale;

    bool isArabic = selectedLocale.languageCode == 'ar';
    TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;

    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {}
          if (state is LoginErrorState) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);

          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/Background-image.png', // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset('assets/images/University.png'),
                            ],
                          ),
                          const SizedBox(height: 50),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.7,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: textDirection,
                                  children: [
                                    const SizedBox(height: 30),
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
                                        email = value;
                                        globalEmail = value; // Set the value to the global variable
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
                                        password = value;
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => HomeScreen(email:''), // Pass only the email
                                                  settings: RouteSettings(arguments: [
                                                  selectedLocale, isArabic ?'لا يوجد ':'Not provided'// Pass the locale and the email
                                            ]),
                                                ),
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
                                                  color:
                                                      const Color(0xff3E657B),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xffffffff),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      isArabic
                                                          ? 'ضيف'
                                                          : 'Guest',
                                                      style: const TextStyle(
                                                        fontSize: 26,
                                                        color:
                                                            Color(0xff3E657B),
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
                                                      color: Color(0xff3E657B),
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
                                                  email: email!,
                                                  password: password!,
                                                );

                                                Navigator.pushNamed(
                                                  context,
                                                  HomeScreen.id,
                                                  //passing the selected locale and email  to the home screen
                                                  arguments: [
                                                    selectedLocale,
                                                    email
                                                  ],
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
                                                    BorderRadius.circular(10),
                                                color: const Color(0xff3E657B),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      isArabic
                                                          ? 'تسجيل'
                                                          : 'Login',
                                                      style: const TextStyle(
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
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
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
                                            Navigator.pushNamed(
                                              context,
                                              RegisterationScreen.id,
                                              arguments: selectedLocale,
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
                                    )
                                  ],
                                ),
                              ),
                            ),
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
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(message)),
    ),
  );
}
