abstract class AppStates{}

class AppInitialState extends AppStates{}

//Get User Data
class AppGetUserLoadingState extends AppStates{}
class AppGetUserSuccessState extends AppStates{}
class AppGetUserErrorState extends AppStates{
  final String error;
  AppGetUserErrorState(this.error);
}

class AppLogoutLoadingState extends AppStates{}

class AppLogoutSuccessState extends AppStates{}

class AppLogoutErrorState extends AppStates{}

//Change Bottom Nav Bar
class AppChangeBottomNavBarState extends AppStates{}

class UserModelUpdateLoadingState extends AppStates{}

class UserModelUpdateErrorState extends AppStates{}

class SelectImageSuccessState extends AppStates{}

class SelectImageErrorState extends AppStates{}

class UploadProfileImageSuccessState extends AppStates{}

class UploadImageErrorState extends AppStates{}

class DeleteAccountSuccessState extends AppStates{}

class DeletePostImageSuccessState extends AppStates{}

class CreatePostLoadingState extends AppStates{}

class CreatePostSuccessState extends AppStates{}

class CreatePostErrorState extends AppStates{}