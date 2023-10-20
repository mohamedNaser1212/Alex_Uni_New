import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/chat/chat_details_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Choose Chat'),
          ),
          body: ConditionalBuilder(
              condition: AppCubit.get(context).admin.isNotEmpty,
              builder: (context)=>SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                          itemBuilder: (context,index)=> InkWell(
                            onTap: (){
                              navigateTo(context:context,screen: ChatDetailsScreen(chatUserModel: AppCubit.get(context).admin[index],));
                            },
                            child: SizedBox(
                              height: 50,
                              width: double.infinity,
                              child:AppCubit.get(context).admin[index].postGraduate==true? Text(
                                '${AppCubit.get(context).admin[index].name} (Post graduate)',
                                textAlign: TextAlign.center,
                                style:const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ):Text(
                                '${AppCubit.get(context).admin[index].name} (Under graduate)',
                                textAlign: TextAlign.center,
                                style:const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context,index)=>  const SizedBox(height: 10),
                          itemCount: AppCubit.get(context).admin.length
                      ),
                    ],
                  ),
                ),
              ),
              fallback: (context)=>const Center(child: CircularProgressIndicator())
          ),
        );
      },
    );
  }
}
