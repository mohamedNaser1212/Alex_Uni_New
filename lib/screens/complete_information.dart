import 'dart:io';
import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/login_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/user_layout_screen.dart';
import 'package:alex_uni_new/states/login_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CompleteInformationScreen extends StatefulWidget {
  const CompleteInformationScreen({Key? key}) : super(key: key);

  @override
  State<CompleteInformationScreen> createState() => _CompleteInformationScreenState();
}

class _CompleteInformationScreenState extends State<CompleteInformationScreen> {
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
    LoginCubit.get(context).getUniversities();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool isArabic = lang == 'ar';
    TextDirection textDirection =
    isArabic ? TextDirection.rtl : TextDirection.ltr;
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if(state is CreateUserLoginSuccessState){
          CacheHelper.saveData(key: 'uId', value: uId).then((value){
            navigateAndFinish(context:context, screen:const UserLayout());
          });
        }
      },
      builder: (context, state) {

        LoginCubit cubit = LoginCubit.get(context);
        isUndergraduateSelected = cubit.selecteddegree;

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Waiting-image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            body: ConditionalBuilder(
              condition: state is! GetUniversityLoadingState,
              builder: (context)=> SafeArea(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.35,
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
                                const SizedBox(
                                  height: 20,
                                ),
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
                                    counterStyle: const TextStyle(
                                      color: Color(0xffffffff),
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  initialCountryCode: 'EG',
                                  onChanged: (data) {
                                    phone = data.completeNumber;
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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF),
                                      ),
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
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: const Color(0xffffffff),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: DropdownButton(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    underline: const SizedBox(),
                                    dropdownColor: const Color(0xff3E657B),
                                    style: const TextStyle(
                                      color: Color(0xffffffff),
                                    ),
                                    alignment: Alignment.center,
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(15.0),
                                    iconSize: 35,
                                    icon: const Icon(
                                      Icons.arrow_drop_down_sharp,
                                      size: 28,
                                    ),
                                    value: cubit.currentSelectedUniversity??cubit.universities.first,
                                    items: cubit.universities
                                        .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.name!),
                                    ),
                                    ).toList(),
                                    onChanged: (value) {
                                      cubit.changeSelectedUniversity(value!);
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
                                      activeColor: Colors.white,
                                      groupValue: isUndergraduateSelected,
                                      onChanged: (bool? value) {
                                        cubit.changRadioValue(value!);
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
                                      activeColor: Colors.white,

                                      value: false,
                                      groupValue: isUndergraduateSelected,
                                      onChanged: (bool? value) {
                                        cubit.changRadioValue(value!);
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
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        lang == 'ar' ? 'تسجيل الدخول' : 'Login',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ConditionalBuilder(
                                  condition: state is! CreateUserLoginLoadingState,
                                  builder: (context) => reusableElevatedButton(
                                      label: 'Sign Up',
                                      backColor: Colors.white,
                                      textColor: defaultColor,
                                      function: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.userCreate(
                                              name: name!,
                                              image: image!,
                                              email: email!,
                                              uId: uId!,
                                              phone: phone!,
                                              address: addressController.text,
                                              country: countryController.text,
                                              universityName: cubit.currentSelectedUniversity!.name!,
                                              underGraduate: isUndergraduateSelected,
                                              postGraduate: !isUndergraduateSelected,
                                              passportId: idController.text,
                                              context: context,
                                          );
                                        }
                                      }
                                      ),
                                  fallback: (context) => Center(
                                      child: Platform.isIOS
                                          ? const CupertinoActivityIndicator()
                                          : const CircularProgressIndicator(
                                        color: Colors.white,
                                      )),
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
              fallback: (context)=> const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
