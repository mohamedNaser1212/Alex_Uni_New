import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import '../cubit/login_cubit.dart';
import '../states/login_states.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final GlobalKey <FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state)  {
          if(state is ResetPasswordSuccessState){
            showFlushBar(context: context, message: 'تم إرسال البريد الإلكتروني بنجاح',);
            Navigator.pop(context);
          }else if(state is ResetPasswordErrorState){
            showFlushBar(context: context, message: state.error);
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset('assets/images/University.png'),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
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
                                  children: [
                                    const SizedBox(height: 30),
                                    Text(
                                      lang=='ar' ? 'استرجاع كلمة المرور' : 'Reset Password',
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff0D3961),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Text(
                                      lang=='ar'
                                          ? 'البريد الألكتروني'
                                          : 'Your Email',
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff7B8189),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return lang=='ar'
                                              ? 'يرجى إدخال البريد الإلكتروني'
                                              : 'Please enter your email';
                                        } else if (!value.contains('@')) {
                                          return lang=='ar'
                                              ? 'البريد الإلكتروني غير صالح'
                                              : 'Invalid email format';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    ConditionalBuilder(
                                      condition: state is! LoginLoadingState,
                                      builder: (context) {
                                        return Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                cubit.resetPassword(
                                                  email: emailController.text,
                                                );
                                              }
                                            },
                                            child: Container(
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
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      lang=='ar'
                                                          ? 'ارسال البريد الإلكتروني'
                                                          : 'Send Email',
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
                                        );
                                      },
                                      fallback: (context) => const Center(
                                        child: CircularProgressIndicator(
                                          color: Color(0xff3E657B),
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
