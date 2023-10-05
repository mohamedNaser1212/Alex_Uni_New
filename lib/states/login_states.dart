abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  final String uId;
  LoginSuccessState(this.uId);
}
class LoginErrorState extends LoginStates{
  String error;
  LoginErrorState({required this.error});
}

class CreateUserLoginLoadingState extends LoginStates{}
class CreateUserLoginSuccessState extends LoginStates{}
class CreateUserLoginErrorState extends LoginStates{}

class ResetPasswordLoadingState extends LoginStates{}
class ResetPasswordSuccessState extends LoginStates{}
class ResetPasswordErrorState extends LoginStates{
  String error;
  ResetPasswordErrorState({required this.error});
}

class GoogleSignInLoadingState extends LoginStates{}

class GoogleSignInSuccessState extends LoginStates{}

class GoogleSignInErrorState extends LoginStates{
  String error;
  GoogleSignInErrorState({required this.error});
}

class CreateUserLoadingState extends LoginStates{}

class CreateUserSuccessState extends LoginStates{}

class CreateUserErrorState extends LoginStates{
  String error;
  CreateUserErrorState({required this.error});
}

class GetUniversityLoadingState extends LoginStates{}

class GetUniversitySuccessState extends LoginStates{}

class GetUniversityErrorState extends LoginStates{
  String error;
  GetUniversityErrorState({required this.error});
}

class ChangeRadioValueState extends LoginStates{}

class RegisterChangeSelectedUniversityState extends LoginStates{}