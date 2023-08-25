import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:alex_uni_new/states/guest_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../cubit/guest_cubit.dart';

class GuestLayoutScreen extends StatelessWidget {
  const GuestLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuestCubit(),
      child: BlocConsumer<GuestCubit, GuestStates>(
        listener: (context, state) {},
        builder: (context, state) {
          GuestCubit cubit = GuestCubit.get(context);
          GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                lang == 'ar' ? 'مرحبا بك' : 'Home Page',
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  icon: Icon(Icons.login),
                ),
              ],
            ),
            body: Center(
              child: Text('Guest Layout'),
            ),
          );
        },
      ),
    );
  }
}
