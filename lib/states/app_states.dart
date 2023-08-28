abstract class AppStates{}

class AppInitialState extends AppStates{}

//Get User Data
class AppGetUserLoadingState extends AppStates{}
class AppGetUserSuccessState extends AppStates{}
class AppGetUserErrorState extends AppStates{
  final String error;
  AppGetUserErrorState(this.error);
}
class AppLogoutSuccessState extends AppStates{}

class AppLogoutErrorState extends AppStates{}

//Change Bottom Nav Bar
class AppChangeBottomNavBarState extends AppStates{}