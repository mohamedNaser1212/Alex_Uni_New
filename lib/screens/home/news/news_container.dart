import 'dart:ui';

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/models/news_model.dart';
import 'package:alex_uni_new/screens/drawer/news/drawer_news_screen.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/home/news/arabic_news_details_screen.dart';
import 'package:alex_uni_new/screens/home/news/english_news_details_screen.dart';
import 'package:flutter/material.dart';

Widget buildNewsItem({
  required BuildContext context,
  model,
  required int index,
}) =>
    index != 3
        ? InkWell(
            onTap: () {
              if (model is ArabicNewsModel) {
                navigateTo(
                  context: context,
                  screen: ArabicNewsDetailsScreen(
                    newsModel: model,
                  ),
                );
              } else {
                navigateTo(
                  context: context,
                  screen: BothNewsDetailsScreen(
                    newsModel: model,
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.2, -0.7),
                  tileMode: TileMode.decal,
                  colors: [
                    Color.fromARGB(255, 171, 250, 202),
                    Color.fromARGB(255, 190, 245, 245),
                    Color.fromARGB(255, 189, 233, 247),
                    Color.fromARGB(255, 211, 250, 255),
                    Color.fromARGB(255, 188, 251, 240),
                    Color.fromARGB(255, 205, 248, 225),
                    Color.fromARGB(255, 200, 243, 215),
                    Color.fromARGB(255, 221, 240, 250),
                    Color.fromARGB(255, 217, 253, 231),
                    Color.fromARGB(255, 209, 237, 253),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(98, 158, 172, 193),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(model.images[0]!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.73),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                            bottomLeft: Radius.circular(19),
                            bottomRight: Radius.circular(19),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    model.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily:
                                          lang == 'ar' ? 'arabic2' : 'poppins',
                                      color: Colors.black,
                                      fontSize: MediaQuery.of(context)
                                              .size
                                              .aspectRatio *
                                          32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${model.date}',
                                    style: TextStyle(
                                      fontFamily:
                                          lang == 'ar' ? 'arabic2' : 'poppins',
                                      color: const Color.fromARGB(
                                          255, 111, 111, 111),
                                      fontSize: 11.4,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: lang == 'en' ? 5 : 0,
                            ),
                            lang == 'en'
                                ? Text(
                                    model.descriptions[0]!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'poppins',
                                      color: const Color.fromARGB(
                                          255, 111, 111, 111),
                                      fontSize: MediaQuery.of(context)
                                              .size
                                              .aspectRatio *
                                          27,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
                                    model.descriptions[0]!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'arabic2',
                                      color: const Color.fromARGB(
                                          255, 111, 111, 111),
                                      fontSize: MediaQuery.of(context)
                                              .size
                                              .aspectRatio *
                                          26,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : InkWell(
            onTap: () {
              if (model is ArabicNewsModel) {
                navigateTo(
                  context: context,
                  screen: ArabicNewsDetailsScreen(
                    newsModel: model,
                  ),
                );
              } else {
                navigateTo(
                  context: context,
                  screen: BothNewsDetailsScreen(
                    newsModel: model,
                  ),
                );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(0.2, -0.7),
                  tileMode: TileMode.decal,
                  colors: [
                    Color.fromARGB(255, 171, 250, 202),
                    Color.fromARGB(255, 190, 245, 245),
                    Color.fromARGB(255, 189, 233, 247),
                    Color.fromARGB(255, 211, 250, 255),
                    Color.fromARGB(255, 188, 251, 240),
                    Color.fromARGB(255, 205, 248, 225),
                    Color.fromARGB(255, 200, 243, 215),
                    Color.fromARGB(255, 221, 240, 250),
                    Color.fromARGB(255, 217, 253, 231),
                    Color.fromARGB(255, 209, 237, 253),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(98, 158, 172, 193),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(model.images[0]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.73),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(19),
                                bottomRight: Radius.circular(19),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        model.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: lang == 'ar'
                                              ? 'arabic2'
                                              : 'poppins',
                                          color: Colors.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio *
                                              32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${model.date}',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontFamily: lang == 'ar'
                                              ? 'arabic2'
                                              : 'poppins',
                                          color: const Color.fromARGB(
                                              255, 111, 111, 111),
                                          fontSize: lang == 'ar' ? 10.1 : 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: lang == 'en' ? 5 : 0,
                                ),
                                lang == 'en'
                                    ? Text(
                                        model.descriptions[0]!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'poppins',
                                          color: const Color.fromARGB(
                                              255, 111, 111, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio *
                                              27,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : Text(
                                        model.descriptions[0]!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'arabic2',
                                          color: const Color.fromARGB(
                                              255, 111, 111, 111),
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .aspectRatio *
                                              26,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                          color: defaultColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(18)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
                          child: SizedBox(
                            child: TextButton(
                              onPressed: () {
                                navigateTo(
                                  context: context,
                                  screen: const DrawerNewsScreen(),
                                );
                              },
                              child: Text(
                                lang == 'en' ? 'Read More' : 'قراءة المزيد',
                                style: TextStyle(
                                  fontFamily:
                                      lang == 'en' ? 'poppins' : 'arabic2',
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
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
          );
