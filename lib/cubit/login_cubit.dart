import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../cache_helper.dart';
import '../firebase_options.dart';
import '../models/user_model.dart';
import '../screens/user_screens/home_screen.dart';
import '../states/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
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
      uId=userCredential.user!.uid;
      emit(LoginSuccessState(userCredential.user!.uid));
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

  bool signInBefore=false;
  googleSignIn({
    required context,
  }){
    emit(GoogleSignInLoadingState());
    GoogleSignIn(clientId: DefaultFirebaseOptions.currentPlatform.iosClientId).signIn().then((value){
      value?.authentication.then((value){
        final credential=  GoogleAuthProvider.credential(
            accessToken: value.accessToken,
            idToken: value.idToken
        );
        FirebaseAuth.instance.signInWithCredential(credential).then((value){
          uId=value.user!.uid;
          FirebaseFirestore.instance.collection('users').get().then((n){
            for (var element in n.docs) {
              if (element.data()['uId'] == value.user!.uid) {
                signInBefore=true;
              }
            }
            if(signInBefore==true){
              CacheHelper.saveData(
                key: 'uId',
                value: uId,
              ).then((value) {
                navigateAndFinish(context: context, screen: const HomeScreen());
              });
            }else{
              // userCreate(
              //     name: name,
              //     image: image,
              //     email: email,
              //     uId: uId,
              //     phone: phone,
              //     address: address,
              //     country: country,
              //     universityName: universityName,
              //     underGraduate: underGraduate,
              //     postGraduate: postGraduate,
              //     passportId: passportId,
              //     context: context
              // );
            }

          });


          emit(GoogleSignInSuccessState());
        }).catchError((error){
          emit(GoogleSignInErrorState(error: error.toString()));
        });
      });
    });
  }

  userCreate({
    required String name,
    required String image,
    required String email,
    required String uId,
    required String phone,
    required String address,
    required String country,
    required String universityName,
    required bool underGraduate,
    required bool postGraduate,
    required String passportId,

    required context,
  }){
    emit(CreateUserLoadingState());
    UserModel userModel=UserModel(
        uId: uId,
        name: name,
        email: email,
        image: image,
        cover: '',
        bio: '',
        phone: phone,
        country: country,
        universityname: universityName,
        underGraduate: underGraduate,
        postGraduate: postGraduate,
        address: address,
        passportId: passportId,
        savedPosts: [],
        sharePosts: []
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(userModel.toMap()).then((value){
      emit(CreateUserSuccessState());

    }).catchError((error){
      emit(CreateUserErrorState(error: error.toString()));
    });
  }

  resetPassword({
    required String email,
}){
    emit(ResetPasswordLoadingState());
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPasswordSuccessState());
    }).catchError((error){
      emit(ResetPasswordErrorState(error: error.toString()));
    });
  }

}