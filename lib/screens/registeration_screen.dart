import 'dart:io';
import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/register_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:alex_uni_new/screens/user_layout_screen.dart';
import 'package:alex_uni_new/states/register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterationScreen extends StatefulWidget {
  RegisterationScreen({super.key});
  static String id = 'RegisterationScreen';

  @override
  State<RegisterationScreen> createState() => RegisterationScreenState();
}

class RegisterationScreenState extends State<RegisterationScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
 String? phone;
  @override
  Widget build(BuildContext context) {
    bool isArabic = lang == 'ar';
    TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state){
          if (state is RegisterErrorState) {
            showFlushBar(context: context,message: state.error,);
          } else if (state is CreateUserSuccessState) {
            CacheHelper.saveData(key: 'uId', value: uId).then((value){
              navigateAndFinish(context: context, screen: const UserLayout());
            });
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);

          return SafeArea(
            child: Scaffold(
              body: ModalProgressHUD(
                inAsyncCall: state is RegisterLoadingState,
                child: ConditionalBuilder(
                  condition: cubit.showImagePicker == false,
                  builder: (context) => Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 2.5,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Waiting-image.png'),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Container(
                                width: double.infinity,
                                height: MediaQuery.of(context).size.height * 1,
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  color: Color(0xff3E657B),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    textDirection: textDirection,
                                    children: [
                                      Text(
                                        isArabic ? ' اضافه حساب' : 'Sign Up',
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        isArabic ? ' اسم المستخدم' : 'User Name',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        textDirection: textDirection,
                                        controller: nameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return isArabic
                                                ? 'من فضلك أدخل اسم المستخدم'
                                                : 'Please enter a username';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        isArabic
                                            ? 'البريد الألكتروني'
                                            : 'Your Email',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Inter',
                                          color: Color(0xffffffff),
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffFFFFFF),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        textDirection: textDirection,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return isArabic
                                                ? 'من فضلك أدخل البريد الإلكتروني'
                                                : 'Please enter an email';
                                          } else if (!value.contains('@')) {
                                            return isArabic
                                                ? 'بريد إلكتروني غير صالح'
                                                : 'Invalid email';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        isArabic ? 'رقم الهاتف' : 'Phone Number',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      IntlPhoneField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        decoration: const InputDecoration(

                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                            borderSide: BorderSide(
                                              color: Color(0xffFFFFFF),
                                            ),
                                          ),
                                        ),
                                        initialCountryCode: 'EG',
                                        onChanged: (data) {

                                          phone = data.completeNumber ;



                                        },
                                      ),

                                      Text(
                                        isArabic ? 'كلمه المرور' : 'Password',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        controller: passwordController,
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
                                                ? 'من فضلك أدخل كلمة المرور'
                                                : 'Please enter a password';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        isArabic
                                            ? 'اعد كتابه كلمه المرور'
                                            : 'Re-enter password',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      TextFormField(
                                        style: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        controller: confirmPasswordController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffFFFFFF),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        obscureText: true,
                                        textDirection: textDirection,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return isArabic
                                                ? 'من فضلك أعد كتابة كلمة المرور'
                                                : 'Please re-enter the password';
                                          } else if (value != passwordController.text) {
                                            return isArabic
                                                ? 'كلمة المرور غير متطابقة'
                                                : 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            lang == 'ar'
                                                ? 'لديك حساب بالفعل؟'
                                                : 'Already have an account?',
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              lang == 'ar'
                                                  ? 'تسجيل الدخول'
                                                  : 'Login',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2,
                                          height:
                                              MediaQuery.of(context).size.height /
                                                  17,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(
                                                0xffFFFFFF), // Your specified color
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  cubit.changeShowImagePicker();
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  7,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xffFFFFFF),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    isArabic
                                                        ? 'قم بالأنشاء'
                                                        : 'Sign Up',
                                                    style: const TextStyle(
                                                      fontSize: 22,
                                                      color: Color(0xff5D6B7B),
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward,
                                                    color: Color(0xff5D6B7B),
                                                  ),
                                                ],
                                              ),
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
                      ),
                    ),
                  ),
                  fallback: (context) => Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: const Color(0xff3E657B),

                    child: WillPopScope(
                      onWillPop: () async {
                        cubit.changeShowImagePicker();
                        return false;
                      },
                      child: Center(
                        child: SingleChildScrollView(

                          child: ConditionalBuilder(

                            condition: cubit.profileImage != null,
                            builder: (context) => Column(
                              children: [
                                CircleAvatar(
                                  radius: MediaQuery.of(context).size.width / 4,
                                  backgroundImage: FileImage(
                                    File(cubit.profileImage!.path),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                reusableElevatedButton(
                                  width: MediaQuery.of(context).size.width/2,
                                  backColor: const Color(0xffEBEBEB),
                                  textColor: const Color(0xff3E657B),
                                  label: lang == 'ar'
                                      ? 'تغيير الصوره الشخصيه'
                                      : 'Change Profile Image',
                                  function: () {
                                    cubit.getProfileImage();
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  builder: (context)=> reusableElevatedButton(
                                    width: MediaQuery.of(context).size.width/2,
                                    backColor: const Color(0xffEBEBEB),
                                    textColor: const Color(0xff3E657B),
                                    label: lang == 'ar'
                                        ? 'انشاء الحساب'
                                        : 'Create Account',
                                    function: () async {
                                      await cubit.uploadProfileImage();
                                      cubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phone!,
                                      );
                                      nameController.clear();
                                      emailController.clear();
                                      passwordController.clear();
                                      confirmPasswordController.clear();
                                    },
                                  ),
                                  fallback: (context)=>const Center(child: CircularProgressIndicator(),),
                                ),
                              ],
                            ),
                            fallback: (context) => Container(
                              width: MediaQuery.of(context).size.width ,
                              height: MediaQuery.of(context).size.height ,
                              color: const Color(0xff3E657B),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: MediaQuery.of(context).size.width / 3,
                                    backgroundColor: Color(0xffD9D9D9),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  reusableElevatedButton(
                                    width: MediaQuery.of(context).size.width / 2,
                                    textColor: Color(0xffD9D9D9),
                                    label: lang == 'ar'
                                        ? 'اضافه صوره شخصيه'
                                        : 'Add Profile Image',

                                    function: () {
                                      cubit.getProfileImage();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
