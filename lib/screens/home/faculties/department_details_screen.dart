import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/models/department_model.dart';
import 'package:flutter/material.dart';

class DepartmentDetailsScreen extends StatefulWidget {
  const DepartmentDetailsScreen({super.key, required this.departmentModel});

  final DepartmentModel departmentModel;

  @override
  State<DepartmentDetailsScreen> createState() =>
      _DepartmentDetailsScreenState();
}

class _DepartmentDetailsScreenState extends State<DepartmentDetailsScreen> {
  int index = 0;
  List<GlobalKey> leftIconButtonKeys = [];
  List<GlobalKey> rightIconButtonKeys = [];

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize unique keys for each IconButton
    for (int i = 0; i < widget.departmentModel.sectionImages.length; i++) {
      leftIconButtonKeys.add(GlobalKey());
      rightIconButtonKeys.add(GlobalKey());
    }
  }

  void goToPreviousImage() {
    if (index > 0) {
      setState(() {
        index--;
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  void goToNextImage() {
    if (index < widget.departmentModel.sectionImages.length - 1) {
      setState(() {
        index++;
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasPreviousImage = index > 0;
    final hasNextImage =
        index < widget.departmentModel.sectionImages.length - 1;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          widget.departmentModel.name!.length > 32 ||
                  widget.departmentModel.arabicName!.length > 32
              ? 63
              : 50,
        ),
        child: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang == 'en'
                    ? 'Degree: ${widget.departmentModel.degree!}'
                    : 'الدرجة العلمية: ${widget.departmentModel.arabicDegree!}',
                style: TextStyle(
                  fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  lang == 'en'
                      ? widget.departmentModel.name!
                      : widget.departmentModel.arabicName!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: widget.departmentModel.name!.length > 17 ||
                          widget.departmentModel.arabicName!.length > 17
                      ? 2
                      : 1,
                  style: TextStyle(
                    fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: defaultColor,
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              lang == 'en'
                  ? Icons.keyboard_arrow_left
                  : Icons.keyboard_arrow_right,
              color: Colors.black,
              size: 32,
            ),
          ),
        ),
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
                    height: MediaQuery.of(context).size.height * 0.332,
                    child: Stack(
                      children: [
                        Image.network(
                          widget.departmentModel.sectionImages[index]!,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.4,
                          fit: BoxFit.cover,
                        ),
                        if (hasPreviousImage)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              key: leftIconButtonKeys[index],
                              onTap: goToPreviousImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff38455e).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: IconButton(
                                  onPressed: goToPreviousImage,
                                  icon: const Icon(
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
                                  color:
                                      const Color(0xff38455e).withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: IconButton(
                                  onPressed: goToNextImage,
                                  icon: const Icon(
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
                    margin: const EdgeInsets.only(bottom: 4),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.departmentModel.name!,
                              style: TextStyle(
                                fontFamily:
                                    lang == 'ar' ? 'arabic2' : 'poppins',
                                fontSize: 19.5,
                                fontWeight: FontWeight.w900,
                                color: defaultColor,
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                            if (index == 0)
                              const SizedBox(
                                height: 7.0,
                              ),
                            Padding(
                              padding: lang == 'en'
                                  ? const EdgeInsets.only(right: 128.0)
                                  : const EdgeInsets.only(left: 128.0),
                              child: const Divider(
                                thickness: 2,
                                color: Color.fromARGB(255, 239, 239, 239),
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              lang == 'en'
                                  ? widget.departmentModel
                                      .sectionDescriptions[index]!
                                  : widget.departmentModel
                                      .arabicSectionDescriptions[index]!,
                              style: TextStyle(
                                fontFamily:
                                    lang == 'ar' ? 'arabic2' : 'poppins',
                                fontSize: 16.0,
                                height: 1.5,
                                color: const Color.fromARGB(255, 63, 63, 63),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1.0,
            color: Colors.grey,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${index + 1}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/images/University.png',
                    width: MediaQuery.of(context).size.width * 0.08,
                  ),
                  Text(
                    '${widget.departmentModel.sectionImages.length}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:alex_uni_new/cubit/app_cubit.dart';
// import 'package:alex_uni_new/models/department_model.dart';
// import 'package:alex_uni_new/states/app_states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../models/admin_model.dart';
//
// class DepartmentDetailsScreen extends StatefulWidget {
//   const DepartmentDetailsScreen({super.key,required this.department});
//
//   final DepartmentModel department;
//
//   @override
//   State<DepartmentDetailsScreen> createState() => _DepartmentDetailsScreenState();
// }
//
// class _DepartmentDetailsScreenState extends State<DepartmentDetailsScreen> {
//   int index = 0;
//   List<GlobalKey> leftIconButtonKeys = [];
//   List<GlobalKey> rightIconButtonKeys = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize unique keys for each IconButton
//     for (int i = 0; i < widget.department.sectionImages.length; i++) {
//       leftIconButtonKeys.add(GlobalKey());
//       rightIconButtonKeys.add(GlobalKey());
//     }
//   }
//
//   void goToPreviousImage() {
//     if (index > 0) {
//       setState(() {
//         index--;
//       });
//     }
//   }
//
//   void goToNextImage() {
//     if (index < widget.department.sectionImages.length - 1) {
//       setState(() {
//         index++;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final hasPreviousImage = index > 0;
//     final hasNextImage = index < widget.department.sectionImages.length - 1;
//     return BlocConsumer<AppCubit,AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//
//         AppCubit cubit = AppCubit.get(context);
//
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(widget.department.name!),
//             centerTitle: true,
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment.topCenter,
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: MediaQuery.of(context).size.height * 0.3,
//                         child: Stack(
//                           children: [
//                             Image.network(
//                               widget.department.sectionImages[index]!,
//                               width: double.infinity,
//                             ),
//                             if (hasPreviousImage)
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: InkWell(
//                                   key: leftIconButtonKeys[index],
//                                   onTap: goToPreviousImage,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Color(0xff2238455E).withOpacity(0.9),
//                                       borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                     child: IconButton(
//                                       onPressed: goToPreviousImage,
//                                       icon: Icon(
//                                         Icons.arrow_back_ios_new,
//                                         color: Color(0xffFFFFFF),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             if (hasNextImage)
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: InkWell(
//                                   key: rightIconButtonKeys[index],
//                                   onTap: goToNextImage,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Color(0xff2238455E).withOpacity(0.9),
//                                       borderRadius: BorderRadius.circular(30.0),
//                                     ),
//                                     child: IconButton(
//                                       onPressed: goToNextImage,
//                                       icon: Icon(
//                                         Icons.arrow_forward_ios,
//                                         color: Color(0xffFFFFFF),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.5),
//                               spreadRadius: 5,
//                               blurRadius: 15,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                           color: Colors.white,
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(30.0),
//                             topRight: Radius.circular(30.0),
//                           ),
//                         ),
//                         height: MediaQuery.of(context).size.height * 0.65,
//                         width: double.infinity,
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const SizedBox(
//                                 height: 10.0,
//                               ),
//                               Text(
//                                 widget.department.sectionDescriptions[index]!,
//                                 style: const TextStyle(
//                                   fontSize: 20.0,
//                                 ),
//                                 textAlign: TextAlign.start,
//                               ),
//                               const SizedBox(
//                                 height: 10.0,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
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
//
//
// }
