// ignore_for_file: avoid_print

import 'dart:io';
import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/register_cubit.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/states/register_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
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
  void initState() {
    super.initState();
    RegisterCubit.get(context).getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool isArabic = lang == 'ar';
    TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;
    return BlocConsumer<RegisterCubit, RegisterStates>(
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
        isUndergraduateSelected = cubit.selecteddegree;

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Waiting-image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ConditionalBuilder(
                condition: state is! GetUniversitiesLoadingState,
                builder: (context) => SafeArea(
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 24),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/Waiting-image.png',
                                      ),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 8,
                                  top: 13,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      print(
                                          "--------------Back---------------");
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(3),
                                      // decoration: const BoxDecoration(
                                      //   shape: BoxShape.circle,
                                      //   color: Color(0xff3E657B),
                                      // ),
                                      child: const Icon(
                                        Icons.keyboard_arrow_left,
                                        size: 49,
                                        color: Color(0xff3E657B),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: Color(0xff3E657B),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(36),
                                  topRight: Radius.circular(36),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  textDirection: textDirection,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      isArabic ? ' انشاء حساب' : 'Sign Up',
                                      style: TextStyle(
                                        fontFamily: lang == 'ar'
                                            ? 'arabic2'
                                            : 'poppins',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                isArabic
                                                    ? ' اسم المستخدم'
                                                    : 'User Name',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffffffff),
                                                  fontFamily: 'Inter',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                cursorColor:
                                                    const Color.fromARGB(
                                                        174, 255, 255, 255),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(9),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                textDirection: textDirection,
                                                controller: nameController,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return isArabic
                                                        ? 'من فضلك أدخل اسم المستخدم'
                                                        : 'Please enter a username';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                isArabic
                                                    ? 'العنوان'
                                                    : 'Address',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffffffff),
                                                  fontFamily: 'Inter',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              TextFormField(
                                                cursorColor:
                                                    const Color.fromARGB(
                                                        174, 255, 255, 255),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(9),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xffFFFFFF),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                controller: addressController,
                                                obscureText: false,
                                                textDirection: textDirection,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return isArabic
                                                        ? 'من فضلك أدخل العنوان'
                                                        : 'Please enter an address';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 18,
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
                                      height: 8,
                                    ),
                                    TextFormField(
                                      cursorColor: const Color.fromARGB(
                                          174, 255, 255, 255),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(9),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: emailController,
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
                                      height: 8,
                                    ),
                                    IntlPhoneField(
                                      cursorColor: const Color.fromARGB(
                                          174, 255, 255, 255),
                                      dropdownIcon: const Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: Color(0xffffffff),
                                      ),
                                      dropdownTextStyle: const TextStyle(
                                        color: Color(0xffffffff),
                                      ),
                                      style: const TextStyle(
                                        color: Color(0xffffffff),
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(9),
                                        counterStyle: const TextStyle(
                                          color: Color(0xffffffff),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      initialCountryCode: 'EG',
                                      onChanged: (data) {
                                        phone = data.completeNumber;
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
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextFormField(
                                      cursorColor: const Color.fromARGB(
                                          174, 255, 255, 255),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.changeVisibility1();
                                          },
                                          icon: Icon(
                                            cubit.isvisible1
                                                ? IconlyBold.lock
                                                : IconlyBold.unlock,
                                            color: Colors.white,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(9),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: passwordController,
                                      obscureText: cubit.isvisible1,
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
                                      height: 22,
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
                                      height: 8,
                                    ),
                                    TextFormField(
                                      cursorColor: const Color.fromARGB(
                                          174, 255, 255, 255),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            cubit.changeVisibility2();
                                          },
                                          icon: Icon(
                                            cubit.isvisible2
                                                ? IconlyBold.lock
                                                : IconlyBold.unlock,
                                            color: Colors.white,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(9),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: confirmPasswordController,
                                      obscureText: cubit.isvisible2,
                                      textDirection: textDirection,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return isArabic
                                              ? 'من فضلك أعد كتابة كلمة المرور'
                                              : 'Please re-enter the password';
                                        } else if (value !=
                                            passwordController.text) {
                                          return isArabic
                                              ? 'كلمة المرور غير متطابقة'
                                              : 'Passwords do not match';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 22,
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
                                      height: 8,
                                    ),
                                    TextFormField(
                                      cursorColor: const Color.fromARGB(
                                          174, 255, 255, 255),
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(9),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      controller: idController,
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
                                      height: 22,
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
                                      height: 8,
                                    ),
                                    TextFormField(
                                      cursorColor: const Color.fromARGB(
                                          174, 255, 255, 255),
                                      style: const TextStyle(
                                        color: Color(0xffffffff),
                                      ),
                                      onTap: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        showCountryPicker(
                                          context: context,
                                          onSelect: (Country country) {
                                            countryController.text = country
                                                    .flagEmoji +
                                                country
                                                    .displayNameNoCountryCode;
                                          },
                                        );
                                      },
                                      controller: countryController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.all(9),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffFFFFFF),
                                          ),
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
                                      height: 22,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                isArabic ? 'الكلية' : 'College',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffffffff),
                                                  fontFamily: 'Inter',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 9,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xffffffff),
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: DropdownButton(
                                                  iconEnabledColor:
                                                      Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20.0,
                                                  ),
                                                  underline: const SizedBox(),
                                                  dropdownColor:
                                                      const Color(0xff3E657B),
                                                  style: const TextStyle(
                                                    color: Color(0xffffffff),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  alignment: Alignment.center,
                                                  isExpanded: true,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  iconSize: 35,
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down_sharp,
                                                    size: 28,
                                                  ),
                                                  value: cubit
                                                          .currentSelectedUniversity ??
                                                      cubit.universities.first,
                                                  items: cubit.universities
                                                      .map(
                                                        (e) => DropdownMenuItem(
                                                          value: e,
                                                          child: Text(lang == 'en' ? e.name! : e.arabicName!),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (value) {
                                                    cubit
                                                        .changeSelectedUniversity(
                                                            value!);
                                                    cubit.getDepartments(
                                                        universityId: cubit
                                                            .currentSelectedUniversity!
                                                            .id!);
                                                  },
                                                ),
                                              ),
                                              if (universityError != null)
                                                Text(
                                                  universityError!,
                                                  style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 12.0,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        if (cubit.currentSelectedDepartment !=
                                            null)
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  isArabic
                                                      ? 'القسم'
                                                      : 'Department',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffffffff),
                                                    fontFamily: 'Inter',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      15.0,
                                                    ),
                                                    border: Border.all(
                                                      color: const Color(
                                                          0xffffffff),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: DropdownButton(
                                                    iconEnabledColor:
                                                        Colors.white,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 20.0,
                                                    ),
                                                    underline: const SizedBox(),
                                                    dropdownColor:
                                                        const Color(0xff3E657B),
                                                    style: const TextStyle(
                                                      color: Color(0xffffffff),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    alignment: Alignment.center,
                                                    isExpanded: true,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    iconSize: 35,
                                                    icon: const Icon(
                                                      Icons
                                                          .arrow_drop_down_sharp,
                                                      size: 28,
                                                    ),
                                                    value: cubit
                                                            .currentSelectedDepartment ??
                                                        cubit.departments.first,
                                                    items: cubit.departments
                                                        .map(
                                                          (e) =>
                                                              DropdownMenuItem(
                                                            value: e,
                                                            child: Text(lang == 'en' ? e.name! : e.arabicName!),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (value) {
                                                      cubit
                                                          .changeSelectedDepartment(
                                                              value!);
                                                    },
                                                  ),
                                                ),
                                                if (universityError != null)
                                                  Text(
                                                    universityError!,
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 22,
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
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    Center(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        padding: lang == 'en'
                                            ? const EdgeInsets.only(
                                                right: 13,
                                                top: 7,
                                                bottom: 7,
                                              )
                                            : const EdgeInsets.only(
                                                left: 13,
                                                top: 7,
                                                bottom: 7,
                                              ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio<bool>(
                                              value: true,
                                              activeColor:
                                                  const Color(0xff3E657B),
                                              groupValue:
                                                  isUndergraduateSelected,
                                              onChanged: (bool? value) {
                                                cubit.changRadioValue(value!);
                                              },
                                            ),
                                            Text(
                                              isArabic
                                                  ? 'البكالوريوس'
                                                  : 'Undergraduate',
                                              style: TextStyle(
                                                fontFamily: lang == 'ar'
                                                    ? 'arabic2'
                                                    : 'Inter',
                                                fontWeight: FontWeight.w900,
                                                color: const Color(0xff3E657B),
                                              ),
                                            ),
                                            Radio<bool>(
                                              activeColor:
                                                  const Color(0xff3E657B),
                                              value: false,
                                              groupValue:
                                                  isUndergraduateSelected,
                                              onChanged: (bool? value) {
                                                cubit.changRadioValue(value!);
                                              },
                                            ),
                                            Text(
                                              isArabic
                                                  ? 'الماجستير'
                                                  : 'Postgraduate',
                                              style: TextStyle(
                                                fontFamily: lang == 'ar'
                                                    ? 'arabic2'
                                                    : 'Inter',
                                                fontWeight: FontWeight.w900,
                                                color: const Color(0xff3E657B),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 44,
                                    ),
                                    ConditionalBuilder(
                                      condition: state is! RegisterLoadingState,
                                      builder: (context) =>
                                          reusableElevatedButton(
                                        label:
                                            isArabic ? 'انشاء حساب' : 'Sign up',
                                        fontWeight: FontWeight.w900,
                                        backColor: Colors.white,
                                        textColor: defaultColor,
                                        function: () {
                                          if (formKey.currentState!
                                                  .validate() &&
                                              phone!.isNotEmpty) {
                                            RegisterCubit.get(context)
                                                .userRegister(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phone!,
                                              universityname: cubit
                                                  .currentSelectedUniversity!
                                                  .name!,
                                              passportId: idController.text,
                                              address: addressController.text,
                                              country: countryController.text,
                                              underGraduate:
                                                  isUndergraduateSelected,
                                              postGraduate:
                                                  !isUndergraduateSelected,
                                            );
                                          }
                                        },
                                      ),
                                      fallback: (context) => Center(
                                        child: Platform.isIOS
                                            ? const CupertinoActivityIndicator()
                                            : const CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          lang == 'ar'
                                              ? 'لديك حساب بالفعل؟'
                                              : 'Already have an account?',
                                          style: TextStyle(
                                            fontFamily: lang == 'ar'
                                                ? 'arabic2'
                                                : 'poppins',
                                            fontSize: lang == 'ar' ? 12 : 14,
                                            color: const Color.fromARGB(
                                                181, 255, 255, 255),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            lang == 'ar'
                                                ? 'تسجيل الدخول'
                                                : 'Login now',
                                            style: TextStyle(
                                              fontFamily: lang == 'ar'
                                                  ? 'arabic2'
                                                  : 'poppins',
                                              fontSize: lang == 'ar' ? 13 : 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                fallback: (context) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/University.png"),
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
          ),
        );
      },
    );
  }
}
