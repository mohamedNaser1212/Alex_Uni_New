import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/screens/home/faculties/postgraduate_tab.dart';
import 'package:alex_uni_new/screens/home/faculties/undergraduate_tab.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/university_model.dart';

class UniversityDetailsScreen extends StatelessWidget {
  const UniversityDetailsScreen({
    super.key,
    required this.university,
  });

  final UniversityModel university;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: defaultColor,
                ),
              ),
              title: Text(
                lang=='en'?'Faculty of ${university.name}':'كلية ${university.arabicName}',
                style: TextStyle(
                  color: defaultColor,
                  fontSize: university.name!.length > 18 ? 19.5 : 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: defaultColor,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                labelColor: defaultColor,
                tabs: [
                  Tab(
                      text: lang=='en'?'Undergraduate Stage':'المرحلة الجامعية',
                    ),
                    Tab(
                      text: lang=='en'?'Postgraduate Stage':'الدراسات العليا',
                    ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                UnderGraduateTab(),
                PostGraduateTab(),
              ],
            ),
          ),
        );
      },
    );
  }
}
