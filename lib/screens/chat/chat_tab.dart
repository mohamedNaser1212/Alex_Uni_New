import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/cubit/app_cubit.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // AppCubit cubit = AppCubit.get(context);
        // UserModel userModel = cubit.user!;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/University.png'),
            const SizedBox(
              height: 18,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.73,
              child: Text(
                lang == 'ar'
                    ? 'مرحبا بكم في المحادثات!!'
                    : "Welcome to our University chat !!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                  color: defaultColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

//   Widget buildChatItem({
//     required BuildContext context,
//     required UserModel userModel,
//   }) =>
//       InkWell(
//         onTap: () {},
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(
//                   '${userModel.image}',
//                 ),
//                 radius: 25,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.73,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       mainAxisSize: MainAxisSize.max,
//                       children: [
//                         Text(
//                           '${userModel.name}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         const Text(
//                           'Date',
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: MediaQuery.of(context).size.width * 0.73,
//                     child: const Text(
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
// }
