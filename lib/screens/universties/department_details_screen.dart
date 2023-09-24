import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/department_model.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/admin_model.dart';

class DepartmentDetailsScreen extends StatelessWidget {
  const DepartmentDetailsScreen({super.key,required this.department});

  final DepartmentModel department;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(department.name!),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (context,index)=>buildAdminItem(
                  context: context,
                  admin: cubit.admins[index],
                ),
                separatorBuilder: (context,index)=>SizedBox(height: 10,),
                itemCount: cubit.admins.length,
            ),
          ),
        );
      },
    );
  }

  Widget buildAdminItem({
    required BuildContext context,
    required AdminModel admin,
})=>Row(
    children: [
      Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: admin.isAvailable! ? Colors.green : Colors.red,
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(width: 10,),
      Text('${admin.name}',),
      Spacer(),
      IconButton(onPressed: (){}, icon: Icon(Icons.call),),
      IconButton(onPressed: (){}, icon: Icon(Icons.chat_outlined),),
    ],
  );

}
