import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/university_model.dart';

class UniversityDetailsScreen extends StatelessWidget {
  UniversityDetailsScreen({super.key, required this.university});

  UniversityModel university;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title: Text('University Details'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                  child: Image.network(
                    '${university.image}',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Faculty Of ${university.name} ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${university.description}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: reusableElevatedButton(
                label: 'show departments',
                function: (){},
              backColor: defaultColor,
            ),
          ),
        );
      },
    );
  }
}
