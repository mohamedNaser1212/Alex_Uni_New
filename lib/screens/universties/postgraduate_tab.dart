import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/universties/department_details_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/department_model.dart';

class PostGraduateTab extends StatelessWidget {
  PostGraduateTab({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        AppCubit cubit = AppCubit.get(context);

        return ConditionalBuilder(
          condition: state is! GetDepartmentLoadingState,
          builder: (context) {
            return cubit.postGraduateDepartments.length>0?Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child:  Text(
                      'Fields of study',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1/0.88,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(
                        cubit.postGraduateDepartments.length,
                            (index) => buildDepartmentItem(
                          context: context,
                          department: cubit.postGraduateDepartments[index],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ):Center(
              child: Text(
                'No Departments Added Yet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator(
            color: defaultColor,
          ),),
        );
      },
    );
  }

  Widget buildDepartmentItem({
    required BuildContext context,
    required DepartmentModel department,
  })=>InkWell(
    onTap: (){
      AppCubit.get(context).getDepartmentAdmins(departmentId: department.id!, universityId:department.universityId!);
      navigateTo(context: context, screen: DepartmentDetailsScreen(departmentModel: department,));
    },
    child: Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10,),
        color: defaultColor,
      ),
      child: Column(
        children: [
          Container(
            height: 35,
            width: double.infinity,
            decoration: BoxDecoration(
              color: defaultColor,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,8,8,0,),
              child: Text(
                lang=='en'?department.name!:department.arabicName!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,0,8,8,),
            child: Container(
              height: MediaQuery.of(context).size.height / 7,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                    '${department.sectionImages[0]}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

}
