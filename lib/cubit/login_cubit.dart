import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import '../models/user_model.dart'; // Import your user model
import '../reusable_widgets.dart';
import '../screens/home_screen.dart';
import '../states/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  File? selectedImage; // Add this line to declare selectedImage

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(userCredential.user!.uid));
      print(userCredential.user!.email);
      print(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'حدث خطأ ما';
      if (e.code == 'user-not-found') {
        emit(LoginErrorState(error:'لم يتم العثور على مستخدم بهذا البريد الإلكتروني.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorState(error: 'كلمه السر خطأ'));
      }else if(e.code == 'invalid-email') {
        emit(LoginErrorState(error: 'البريد الإلكتروني غير صالح'))  ;
      }else{
        emit(LoginErrorState(error:errorMessage));

      }

      print(e.toString());
    } catch (e) {
      emit(LoginErrorState(error: 'حدث خطأ ما',  ));
      print(e.toString());
    }
  }


  createUser({
    required String email,
    required String name,
    required String id,
    context,
  }) {
    emit(CreateUserLoginLoadingState());
    UserModel model = UserModel(
      email: email,
      name: name,
      uId: id,
      profileImage: '', // Initialize with an empty string
    );
    FirebaseFirestore.instance.collection('users').doc(id).set(model.toMap()).then((value) {
      if (selectedImage != null) {
        // Upload the selected image to Firebase Storage
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('$id.jpg');
        UploadTask uploadTask = storageReference.putFile(selectedImage!);

        uploadTask.then((res) {
          res.ref.getDownloadURL().then((downloadUrl) {
            // Update the profileImage field with the download URL
            FirebaseFirestore.instance
                .collection('users')
                .doc(id)
                .update({'profileImage': downloadUrl})
                .then((_) {
              navigateAndFinish(context: context, screen: HomeScreen(email: email));
              emit(CreateUserLoginSuccessState());
            });
          });
        });
      } else {
        navigateAndFinish(context: context, screen: HomeScreen(email: email));
        emit(CreateUserLoginSuccessState());
      }
    }).catchError((error) {
      emit(CreateUserLoginErrorState());
    });
  }
}
