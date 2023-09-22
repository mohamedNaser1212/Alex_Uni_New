import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/screens/universties/postgraduate_tab.dart';
import 'package:alex_uni_new/screens/universties/undergraduate_tab.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/university_model.dart';

class UniversityDetailsScreen extends StatelessWidget {
  UniversityDetailsScreen({super.key, required this.university});

  UniversityModel university;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: defaultColor,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  'Faculty of ${university.name}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  tabs: [
                    Tab(
                      text: 'Undergraduate Stage',
                    ),
                    Tab(
                      text: 'Postgraduate Stage',
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  UnderGraduateTab(),
                  PostGraduateTab(),
                ],
              )),
        );
      },
    );
  }
}
