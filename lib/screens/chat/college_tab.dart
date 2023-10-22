// ignore_for_file: unused_local_variable

import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/models/university_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/chat/choose_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/app_cubit.dart';
import '../../models/user_model.dart';
import '../../states/app_states.dart';

class CollegeTab extends StatelessWidget {
  const CollegeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        UserModel universityModel = cubit.user!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                cubit.getAllAdmins(index);
                navigateTo(context: context, screen: ChooseScreen());
              },
              child: buildChatItem(
                context: context,
                universityModel: AppCubit.get(context).universities[index],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: AppCubit.get(context).universities.length,
          ),
        );
      },
    );
  }

  Widget buildChatItem({
    required BuildContext context,
    required UniversityModel universityModel,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                'assets/images/University.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.73,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          lang == 'en' ? '${universityModel.name}' : '${universityModel.arabicName}',
                          style: const TextStyle(
                            fontFamily: 'arabic1',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  lang == 'ar' ?
                  'يمكنك التحدث الى احد ممثلي الكلية' : 'you can talk to our representitive',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      );
}
