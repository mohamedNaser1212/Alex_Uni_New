import 'dart:io';
import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/states/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool obsecurePassword = true;
  void changePasswordVisibility(){
    obsecurePassword = !obsecurePassword;
    emit(RegisterChangePasswordVisibilityState());
  }


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          uId= value.user!.uid;
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(RegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'weak-password') {
          emit(RegisterErrorState( error: 'كلمه السر ضعيفه',));
        } else if (error.code == 'email-already-in-use') {
          emit(RegisterErrorState(error: 'هذا البريد الالكتروني مسجل بالفعل'));
        } else {
          emit(RegisterErrorState(error: 'حدث خطأ ما,حاول مره اخري'));
        }
      } else {
        emit(RegisterErrorState(error: 'An error occurred: $error'));
      }
      print(error.toString());
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,
  }) {
    emit(CreateUserLoadingState());
   UserModel user = UserModel(
      name: name,
      uId: uId,
      email: email,
      phone: phone,
      image: 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      cover:'',
      bio: '',
      savedPosts: [],
     sharePosts: [],
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(user.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      emit(CreateUserErrorState());
      print(onError.toString());
    });
  }
}
