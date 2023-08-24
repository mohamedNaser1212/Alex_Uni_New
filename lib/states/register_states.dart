abstract class RegisterStates {}

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