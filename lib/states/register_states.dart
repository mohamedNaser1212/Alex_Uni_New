abstract class RegisterStates {}

class ChangeRadioValueState extends RegisterStates {}

class RegisterChangeSelectedUniversityState extends RegisterStates {}

class RegisterInitialState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {}
class RegisterSuccessState extends RegisterStates {
  final String uId;
  RegisterSuccessState(this.uId);
}
class RegisterErrorState extends RegisterStates {
   String error;
   RegisterErrorState({required this.error});
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class CreateUserLoadingState extends RegisterStates {}
class CreateUserSuccessState extends RegisterStates {}
class CreateUserErrorState extends RegisterStates {}

class RegisterChangeRadioValueState extends RegisterStates {}

class RegisterChangeImageProfileSuccessState extends RegisterStates {}
class RegisterChangeImageProfileErrorState extends RegisterStates {}

class RegisterUploadImageProfileSuccessState extends RegisterStates {}
class RegisterUploadImageProfileErrorState extends RegisterStates {}
class RegisterUploadImageProfileLoadingState extends RegisterStates {}

class RegisterShowImagePickerChangedState extends RegisterStates {}

class ChangeSelectedDepartment extends RegisterStates {}
class ChangeVisibility extends RegisterStates {}

class GetUniversitiesLoadingState extends RegisterStates {}
class GetUniversitiesSuccessState extends RegisterStates {}
class GetUniversitiesErrorState extends RegisterStates {
  final String error;
  GetUniversitiesErrorState({required this.error});
}

class GetDepartmentsLoadingState extends RegisterStates {}
class GetDepartmentsSuccessState extends RegisterStates {}
class GetDepartmentsErrorState extends RegisterStates {
  final String error;
  GetDepartmentsErrorState({required this.error});
}

