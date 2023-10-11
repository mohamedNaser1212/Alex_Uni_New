import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/university_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/home/faculties/university_details_screen.dart';
import 'package:flutter/material.dart';

Widget buildFacultyItem(context, UniversityModel model) => InkWell(
      onTap: () async {
        await AppCubit.get(context).getDepartments(
          universityId: model.id!,
        );
        navigateTo(
          context: context,
          screen: UniversityDetailsScreen(
            university: model,
          ),
        );
      },
      child: SizedBox(
        width: 92,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundColor: const Color(0xffEFEAEA),
                radius: MediaQuery.of(context).size.width / 10.5,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: MediaQuery.of(context).size.width / 11.2,
                  child: Image(
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.width / 8,
                    image: const AssetImage(
                      'assets/images/University.png',
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                lang == 'en' ?
                '${model.name}' : "${model.arabicName}",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff464646),
                ),
              ),
            ),
          ],
        ),
      ),
    );
