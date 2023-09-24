import 'dart:io';

import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/cubit/register_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/states/register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String? phone;
  bool underGraduateCheckbox = false;
  String? universityError;
  String? departmentError;
  bool postGraduateCheckbox = false;
  bool isUndergraduateSelected = true;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool isArabic = lang == 'ar';
    TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterErrorState) {
            showFlushBar(
              context: context,
              message: state.error,
            );
          } else if (state is CreateUserSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Waiting-image.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              body: Form(
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
                              image:
                                  AssetImage('assets/images/Waiting-image.png'),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Color(0xff3E657B),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
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
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
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
                                isArabic ? 'البريد الألكتروني' : 'Your Email',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: Color(0xffffffff),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
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
                                    borderRadius: BorderRadius.circular(15),
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
                              const SizedBox(
                                height: 10,
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
                                  phone = data.completeNumber;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                isArabic ? 'كلمه المرور' : 'Password',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
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
                              const SizedBox(
                                height: 10,
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
                                    borderRadius: BorderRadius.circular(15),
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
                              Text(
                                isArabic ? 'رقم الباسبور' : 'ID',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                                controller: idController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                obscureText: false,
                                textDirection: textDirection,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return isArabic
                                        ? 'من فضلك أدخل الرقم القومي'
                                        : 'Please enter an ID';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                isArabic ? 'العنوان' : 'Address',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                                controller: addressController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                obscureText: false,
                                textDirection: textDirection,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return isArabic
                                        ? 'من فضلك أدخل العنوان'
                                        : 'Please enter an address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                isArabic ? 'الدولة' : 'Country',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Color(0xffffffff),
                                ),
                                onTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  showCountryPicker(
                                    context: context,
                                    onSelect: (Country country) {
                                      countryController.text =
                                          country.flagEmoji +
                                              country.displayNameNoCountryCode;
                                    },
                                  );
                                },
                                controller: countryController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                obscureText: false,
                                textDirection: textDirection,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return isArabic
                                        ? 'من فضلك أدخل الدولة'
                                        : 'Please select country';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                isArabic ? 'الكلية' : 'College',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                                child: DropdownButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  underline: const SizedBox(),
                                  alignment: Alignment.center,
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(25.0),
                                  iconSize: 35,
                                  icon: const Icon(
                                    Icons.arrow_drop_down_sharp,
                                    size: 28,
                                  ),
                                  value: cubit.currentSelectedUniversity,
                                  items: cubit.universities
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name!),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      cubit.currentSelectedUniversity = value;

                                      // Clear the university error when a selection is made
                                      universityError = null;
                                    });
                                  },
                                ),
                              ),
                              if (universityError !=
                                  null) // Display error message if no university is selected
                                Text(
                                  universityError!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.0,
                                  ),
                                ),

                              //make a radio botton to choose between post and under graduate
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                isArabic
                                    ? 'المرحلة الدراسية'
                                    : 'Academic Level',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                  fontFamily: 'Inter',
                                ),
                              ),

                              Row(
                                children: [
                                  Radio<bool>(
                                    value: true,
                                    groupValue: isUndergraduateSelected,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isUndergraduateSelected = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    isArabic ? 'البكالوريوس' : 'Undergraduate',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  Radio<bool>(
                                    value: false,
                                    groupValue: isUndergraduateSelected,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isUndergraduateSelected = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    isArabic ? 'الماجستير' : 'Postgraduate',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ],
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
                                      lang == 'ar' ? 'تسجيل الدخول' : 'Login',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context) => reusableElevatedButton(
                                    label: 'Sign Up',
                                    function: () {
                                      if (formKey.currentState!.validate() &&
                                          phone!.isNotEmpty) {
                                        RegisterCubit.get(context).userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phone!,
                                          universityname: cubit
                                              .currentSelectedUniversity!.name!,
                                          passportId: idController.text,
                                          address: addressController.text,
                                          country: countryController.text,
                                          underGraduate: isUndergraduateSelected,
                                          postGraduate: !isUndergraduateSelected,
                                        );
                                      }
                                    }),
                                fallback: (context) => Center(
                                    child: Platform.isIOS
                                        ? const CupertinoActivityIndicator()
                                        : const CircularProgressIndicator()),
                              )
                            ],
                          ),
                        ),
                      ],
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
