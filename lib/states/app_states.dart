abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppGetUserLoadingState extends AppStates {}

class AppGetUserSuccessState extends AppStates {}

class AppGetUserErrorState extends AppStates {
  final String error;
  AppGetUserErrorState(this.error);
}

class AppLogoutLoadingState extends AppStates {}

class AppLogoutSuccessState extends AppStates {}

class AppLogoutErrorState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class UserModelUpdateLoadingState extends AppStates {}

class UserModelUpdateSuccessState extends AppStates {}

class UserModelUpdateErrorState extends AppStates {}

class SelectImageSuccessState extends AppStates {}

class SelectImageErrorState extends AppStates {}

class UploadImageLoadingState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadImageErrorState extends AppStates {}

class DeleteAccountSuccessState extends AppStates {}

class DeletePostImageSuccessState extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {}

class GetPostsLoadingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {}

class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {}

class DeletePostSuccessState extends AppStates {}

class SendMessageSuccessState extends AppStates {}

class SendMessageErrorState extends AppStates {}

class ReceiveMessageLoadingState extends AppStates {}

class ReceiveMessageSuccessState extends AppStates {}

class AppChangeLanguageState extends AppStates {}

class AppChangeLanguageErrorState extends AppStates {}

class WriteCommentLoadingState extends AppStates {}

class WriteCommentSuccessState extends AppStates {}

class WriteCommentErrorState extends AppStates {}

class GetCommentsLoadingState extends AppStates {}

class GetCommentsSuccessState extends AppStates {}

class GetCommentsErrorState extends AppStates{}

class DeleteCommentLoadingState extends AppStates{}

class DeleteCommentSuccessState extends AppStates{}

class DeleteCommentErrorState extends AppStates{}

class AddSavePostLoadingState extends AppStates{}

class AddSavePostSuccessState extends AppStates{}

class AddSavePostErrorState extends AppStates{}

class GetSavedPostsLoadingState extends AppStates{}

class GetSavedPostsSuccessState extends AppStates{}

class GetSavedPostsErrorState extends AppStates{}

class DeleteSavedPostLoadingState extends AppStates{}

class DeleteSavedPostSuccessState extends AppStates{}

class DeleteSavedPostErrorState extends AppStates{}

class AddSharePostLoadingState extends AppStates{}

class AddSharePostSuccessState extends AppStates{}

class AddSharePostErrorState extends AppStates{}

class GetSharedPostsLoadingState extends AppStates{}

class GetSharedPostsSuccessState extends AppStates{}

class GetSharedPostsErrorState extends AppStates{}

class GetUniversityLoadingState extends AppStates{}

class GetUniversitySuccessState extends AppStates{}

class GetUniversityErrorState extends AppStates{}

class GetDepartmentLoadingState extends AppStates{}

class GetDepartmentSuccessState extends AppStates{}

class GetDepartmentErrorState extends AppStates{}
