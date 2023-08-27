import 'dart:io';
import 'package:alex_uni_new/states/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';
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

  UserModel user = UserModel();

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
      emit(RegisterSuccessState(value.user!.uid));
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
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
    required String phone,
  }) {
    emit(CreateUserLoadingState());
    user = UserModel(
      name: name,
      uId: uId,
      email: email,
      phone: phone,
      image: uploadedProfileImageLink,
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

  int selectedRadioValue = 1;
  void changeRadioValue(int value) {
    selectedRadioValue = value;
    emit(RegisterChangeRadioValueState());
  }

  bool showEmailField = true;
  void changeEmailFieldState(bool value) {
    showEmailField = value;
    emit(RegisterChangeRadioValueState());
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    var pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if(pickedImage !=null){
      profileImage=File(pickedImage.path);
      emit(RegisterChangeImageProfileSuccessState());
    }else{
      emit(RegisterChangeImageProfileErrorState());
      print('error');
    }
  }

  String uploadedProfileImageLink='';

  Future uploadProfileImage() async {
    emit(RegisterUploadImageProfileLoadingState());
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref = storage.ref().child('users/${Uri.file(profileImage!.path).pathSegments.last}');
    firebase_storage.UploadTask uploadTask = ref.putFile(profileImage!);
    await uploadTask.whenComplete(() async {
      uploadedProfileImageLink = await ref.getDownloadURL();
      print(uploadedProfileImageLink);
      emit(RegisterUploadImageProfileSuccessState());
    }).catchError((onError) {
      emit(RegisterUploadImageProfileErrorState());
      print(onError.toString());
    });
  }


  bool showImagePicker=false;

  void changeShowImagePicker(){
    showImagePicker=!showImagePicker;
    emit(RegisterShowImagePickerChangedState());
  }
}
