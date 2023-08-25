import 'package:alex_uni_new/states/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool obsecurePassword = true;
  void changePasswordVisibility(){
    obsecurePassword = !obsecurePassword;
    emit(RegisterChangePasswordVisibilityState());
  }

  UserModel user = UserModel();

  void userRegister({
    required String name,
    required String email,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(RegisterSuccessState(value.user!.uid));
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        uId: value.user!.uid,
      );
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
  }) {
    emit(CreateUserLoadingState());
    user = UserModel(
      name: name,
      uId: uId,
      email: email,
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
