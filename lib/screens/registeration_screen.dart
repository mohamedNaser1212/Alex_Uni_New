import 'dart:io';

import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/register_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/states/register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController countryController = TextEditingController();
String? phone;
List<String>colleges=[
  'Faculty of Arts',
  'Faculty of Law',
  'Faculty of business',
  'Faculty of Engineering',
  'Faculty of Science',
  'Faculty of Agriculture',
  'Faculty of Medicine',
  'Faculty of Pharmacy',
  'Faculty of Nursing',
  'Faculty of Physical Education for Girls',
  'Faculty of Physical Education for Boys',
  'High Institute of Public Health',
  'Faculty of Fine Arts',
  'Faculty of Agriculture (Saba Basha) ',
  'Faculty of Education',
  'Faculty of Dentistry',
  'Institute of Graduate Studies and Research',
  'Faculty of Veterinary Medicine',
  'Institute of Medical Research',
  'Faculty of Tourism and Hotels',
  'Faculty of Specific Education',
  'Faculty of Education for Early Childhood',
  'Faculty of Economic Studies & Political Science',
  'Faculty of Computing and Data Science'
];
String begin=colleges[0];
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
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
                              image: AssetImage(
                                  'assets/images/Waiting-image.png'),
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

                                  phone = data.completeNumber ;



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
                                    borderRadius:
                                    BorderRadius.circular(15),
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
                                    borderRadius:
                                    BorderRadius.circular(15),
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
                                onTap: (){
                                  FocusScope.of(context).requestFocus( FocusNode());
                                  showCountryPicker(
                                    context: context,
                                    onSelect: (Country country) {
                                      countryController.text=country.flagEmoji+country.displayNameNoCountryCode;
                                    },
                                  );
                                },
                                controller: countryController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(15),
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
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        width: 2, color: Colors.blue),
                                    borderRadius: BorderRadius.circular(88)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                                  child: DropdownButton(
                                    alignment: Alignment.center,
                                    underline: const SizedBox(),
                                    iconSize: 35,
                                    iconDisabledColor: Colors.blue,
                                    iconEnabledColor: Colors.blue,
                                    icon: const Icon(
                                      Icons.arrow_drop_down_sharp,
                                      size: 28,
                                    ),
                                    value: begin,
                                    items: colleges
                                        .map(
                                          (e) => DropdownMenuItem(
                                        value: e,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: Text(
                                              e,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        begin = value!;
                                      });
                                    },
                                  ),
                                ),
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
                              ConditionalBuilder(
                                condition: state is! RegisterLoadingState,
                                builder: (context)=>reusableElevatedButton(
                                    label: 'Sign Up',
                                    function: (){
                                      if (formKey.currentState!.validate()&&phone!.isNotEmpty) {
                                        RegisterCubit.get(context).userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phone!,
                                          passportId: idController.text,
                                          address: addressController.text,
                                          country: countryController.text,
                                          college: begin,
                                        );
                                      }
                                    }
                                ),
                                fallback: (context)=> Center(child: Platform.isIOS?const CupertinoActivityIndicator():const CircularProgressIndicator()),
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

