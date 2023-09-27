import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/models/department_model.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/admin_model.dart';

class DepartmentDetailsScreen extends StatefulWidget {
  const DepartmentDetailsScreen({super.key,required this.department});

  final DepartmentModel department;

  @override
  State<DepartmentDetailsScreen> createState() => _DepartmentDetailsScreenState();
}

class _DepartmentDetailsScreenState extends State<DepartmentDetailsScreen> {
  int index = 0;
  List<GlobalKey> leftIconButtonKeys = [];
  List<GlobalKey> rightIconButtonKeys = [];

  @override
  void initState() {
    super.initState();

    // Initialize unique keys for each IconButton
    for (int i = 0; i < widget.department.sectionImages.length; i++) {
      leftIconButtonKeys.add(GlobalKey());
      rightIconButtonKeys.add(GlobalKey());
    }
  }

  void goToPreviousImage() {
    if (index > 0) {
      setState(() {
        index--;
      });
    }
  }

  void goToNextImage() {
    if (index < widget.department.sectionImages.length - 1) {
      setState(() {
        index++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPreviousImage = index > 0;
    final hasNextImage = index < widget.department.sectionImages.length - 1;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {

        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.department.name!),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Stack(
                          children: [
                            Image.network(
                              widget.department.sectionImages[index]!,
                              width: double.infinity,
                            ),
                            if (hasPreviousImage)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  key: leftIconButtonKeys[index],
                                  onTap: goToPreviousImage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff2238455E).withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: IconButton(
                                      onPressed: goToPreviousImage,
                                      icon: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (hasNextImage)
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  key: rightIconButtonKeys[index],
                                  onTap: goToNextImage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff2238455E).withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: IconButton(
                                      onPressed: goToNextImage,
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 0.65,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                widget.department.sectionDescriptions[index]!,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

//   Widget buildAdminItem({
//     required BuildContext context,
//     required AdminModel admin,
// })=>Row(
//     children: [
//       Container(
//         width: 12,
//         height: 12,
//         decoration: BoxDecoration(
//           color: admin.isAvailable! ? Colors.green : Colors.red,
//           shape: BoxShape.circle,
//         ),
//       ),
//       SizedBox(width: 10,),
//       Text('${admin.name}',),
//       Spacer(),
//       IconButton(onPressed: (){}, icon: Icon(Icons.call),),
//       IconButton(onPressed: (){}, icon: Icon(Icons.chat_outlined),),
//     ],
//   );
//


}
