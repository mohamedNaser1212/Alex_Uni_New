// ignore_for_file: must_be_immutable

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/admin_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/chat/chat_details_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class ChooseScreen extends StatelessWidget {
  ChooseScreen({Key? key}) : super(key: key);

  AdminModel? chatUserModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              lang == "en" ? 'college programs' : 'برامج الكلية',
              style: TextStyle(
                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                lang == 'en'
                    ? IconlyBold.arrow_left_circle
                    : IconlyBold.arrow_right_circle,
                color: defaultColor,
                size: 35,
              ),
            ),
            centerTitle: true,
          ),
          body: ConditionalBuilder(
            condition: AppCubit.get(context).admin.isNotEmpty,
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          navigateTo(
                            context: context,
                            screen: ChatDetailsScreen(
                              chatUserModel: AppCubit.get(context).admin[index],
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 8,
                                left: 8,
                                bottom: 12,
                                top: 55,
                              ),
                              height: lang == 'ar' ? MediaQuery.of(context).size.height * 0.3 : MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                color: defaultColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.only(top: 70),
                                        child: Column(
                                          children: [
                                            Text(
                                              "${AppCubit.get(context).admin[index].name}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            AppCubit.get(context)
                                                        .admin[index]
                                                        .postGraduate ==
                                                    true
                                                ? Text(
                                                    lang == 'ar'
                                                        ? 'دراسات عليا'
                                                        : "Postgraduate",
                                                    style: TextStyle(
                                                      fontFamily: lang == 'ar'
                                                          ? 'arabic2'
                                                          : 'poppins',
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                : Text(
                                                    lang == 'ar'
                                                        ? 'مرحلة جامعية'
                                                        : "Undergraduate",
                                                    style: TextStyle(
                                                      fontFamily: lang == 'ar'
                                                          ? 'arabic2'
                                                          : 'poppins',
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex:1,
                                    child: Align(
                                      child: InkWell(
                                        onTap: () {
                                          navigateTo(
                                            context: context,
                                            screen: ChatDetailsScreen(
                                              chatUserModel:
                                                  AppCubit.get(context)
                                                      .admin[index],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: lang == 'en' ? 8 : 4,
                                          ),
                                          margin:
                                              const EdgeInsets.only(bottom: 11),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                              255,
                                              76,
                                              113,
                                              135,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          child: Text(
                                            lang == 'en' ? 'Chat' : 'تحدث',
                                            style: TextStyle(
                                              fontFamily: lang == 'ar'
                                                  ? 'arabic2'
                                                  : 'poppins',
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 9.0),
                                child: CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.13,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    decoration: const BoxDecoration(),
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.11,
                                      backgroundColor: Colors.white,
                                      backgroundImage: const AssetImage(
                                        "assets/images/admin.jpg",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      itemCount: AppCubit.get(context).admin.length,
                    ),
                  ],
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.73,
                    child: Text(
                      lang == 'ar' ? 'نأسف لكم, لا يوجد احد من ممثلي الكلية هنا !!' : "Sorry we have no admins here !!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                        color: defaultColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
