import 'package:alex_uni_new/states/app_states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import '../models/user_model.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [];
  List<String> titles = [];

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  UserModel user = UserModel();
  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(AppGetUserSuccessState());
      user = UserModel.fromJson(value.data());
      print(value.data());
    }).catchError((onError) {
      emit(AppGetUserErrorState(onError.toString()));
      print(onError.toString());
    });
  }
}