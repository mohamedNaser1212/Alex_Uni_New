import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/models/news_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/home/news/arabic_news_details_screen.dart';
import 'package:alex_uni_new/screens/home/news/english_news_details_screen.dart';
import 'package:flutter/material.dart';

Widget buildNewsItem({
  required BuildContext context,
  model,
}) =>
    InkWell(
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
                flex: 2,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                fontFamily:
                                    lang == 'ar' ? 'arabic2' : 'poppins',
                                color: Colors.black,
                                fontSize: 18,
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
                                color: const Color.fromARGB(255, 111, 111, 111),
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
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'poppins',
                                color: Color.fromARGB(255, 111, 111, 111),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : Text(
                              model.descriptions[0]!,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: 'arabic2',
                                color: Color.fromARGB(255, 111, 111, 111),
                                fontSize: 13,
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
    );
