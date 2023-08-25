import 'package:alex_uni_new/states/guest_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuestCubit extends Cubit<GuestStates> {
  GuestCubit() : super(GuestInitialState());

  static GuestCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [];
  List<BottomNavigationBarItem> bottomItems = [];
  List<String> titles = [];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(GuestChangeBottomNavBarState());
  }
}