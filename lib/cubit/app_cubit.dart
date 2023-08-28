import 'dart:io';

import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:alex_uni_new/screens/user_screens/chat_screen.dart';
import 'package:alex_uni_new/screens/user_screens/home_screen.dart';
import 'package:alex_uni_new/screens/user_screens/settings_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../models/user_model.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'HomeScreen',
    'Chats',
    'Settings',
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  UserModel ?user ;
  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(AppGetUserSuccessState());
      user = UserModel.fromJson(value.data());
    }).catchError((onError) {
      emit(AppGetUserErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  updateUser({required String name, String? image}) {
    emit(UserModelUpdateLoadingState());
    UserModel user2 = UserModel(
        name: name,
        phone: user!.phone,
        email: user!.email,
        uId: user!.uId,
        image: image ?? user!.image);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(user2.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserModelUpdateErrorState());
    });
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SelectImageSuccessState());
    } else {}
  }

  void uploadProfileImage({
    required String name,
  }) {
    emit(UserModelUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, image: value);
        profileImage = null;
      }).catchError((error) {
        print(error.toString());
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadImageErrorState());
    });
  }

  logout(context){
    emit(AppLogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId').then((value){
        currentIndex=0;
        navigateAndFinish(
            context: context,
            screen: const LoginScreen(),
        );
      });
      emit(AppLogoutSuccessState());
    }).catchError((onError){
      emit(AppLogoutErrorState());
    });
  }

  deleteUser({
    required context,
    required String id,
  }){
    FirebaseFirestore.instance.collection("users").doc(id).delete().then((_){
      var user =  FirebaseAuth.instance.currentUser!;
      user.delete().then((value){
        logout(context);
        emit(DeleteAccountSuccessState());
      });
    });
  }
}