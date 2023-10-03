import 'package:alex_uni_new/constants.dart';
import 'package:alex_uni_new/states/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/department_model.dart';
import '../models/university_model.dart';
import '../models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  UniversityModel? currentSelectedUniversity;
  DepartmentModel? currentSelectedDepartment;
  bool selecteddegree=false;

  void changRadioValue(bool value){
    selecteddegree=value;
    emit(ChangeRadioValueState());
  }

  void changeSelectedUniversity(UniversityModel universityModel) {
    currentSelectedUniversity = universityModel;
    currentSelectedDepartment = null;
    emit(RegisterChangeSelectedUniversityState());
  }


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String passportId,
    required String address,
    required String universityname,
    required bool underGraduate,
    required bool postGraduate,

    required String country,
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
        underGraduate: underGraduate,
        postGraduate: postGraduate,
        passportId: passportId,
        address: address,
        universityname: universityname,

        country: country,
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
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String uId,
    required String phone,
    required String passportId,
    required String address,
    required String universityname,
    required bool underGraduate,
    required bool postGraduate,

    required String country,
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
      passportId: passportId,
      underGraduate: underGraduate,
      postGraduate: postGraduate,
      address: address,
      universityname: universityname,
      country: country,
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
    });
  }
  List<UniversityModel> universities = [];
  getUniversities() {
    universities = [];
    emit(GetUniversitiesLoadingState());
    FirebaseFirestore.instance
        .collection('Universities')
        .orderBy('name')
        .get()
        .then((value) {
      for (var element in value.docs) {
        UniversityModel currentUniversity=UniversityModel.fromJson(element.data());
        currentUniversity.id=element.id;
        universities.add(currentUniversity);
      }
    }).then((value) {
      emit(GetUniversitiesSuccessState());
    }).catchError((error) {
      emit(GetUniversitiesErrorState(error: error.toString()));
    });
  }
// List<PostModel> likedPosts=[];
// getLikedPosts(){
//   likedPosts=[];
//   emit(GetLikedPostsLoadingState());
//   FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
//     for(var element in value.data()!['likedPosts']){
//       likedPosts.add(PostModel.fromJson(element));
//     }
//     emit(GetLikedPostsSuccessState());
//   }).catchError((error) {
//     emit(GetLikedPostsErrorState());
//   });
//
// }

  List<DepartmentModel> unGraduateDepartments = [];
  List<DepartmentModel> postGraduateDepartments = [];
  getDepartments({
    required String universityId,
  }) {
    unGraduateDepartments = [];
    postGraduateDepartments = [];
    emit(GetDepartmentsLoadingState());
    FirebaseFirestore.instance
        .collection('Universities')
        .doc(universityId)
        .collection('Departments')
        .orderBy('name')
        .get()
        .then((value) {
      for (var element in value.docs) {
        DepartmentModel currentDepartment=DepartmentModel.fromJson(element.data());
        currentDepartment.id=element.id;
        if(currentDepartment.isUnderGraduate==true){
          unGraduateDepartments.add(currentDepartment);
        }
        if(currentDepartment.isPostGraduate==true){
          postGraduateDepartments.add(currentDepartment);
        }
      }
    }).then((value) {
      emit(GetDepartmentsSuccessState());
    }).catchError((error) {
      emit(GetDepartmentsErrorState(
        error: error.toString(),
      ));
    });
  }



}
