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

class UserModelUpdateErrorState extends AppStates {
  final String error;

  UserModelUpdateErrorState(this.error){
    print(error);
  }
}

class SelectImageSuccessState extends AppStates {}

class SelectImageErrorState extends AppStates {}

class UploadImageLoadingState extends AppStates {}

class UploadProfileImageSuccessState extends AppStates {}

class UploadImageErrorState extends AppStates {
  final String error;

  UploadImageErrorState(this.error){
    print(error);
  }
}

class DeleteAccountSuccessState extends AppStates {}

class DeletePostImageSuccessState extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}
class CreatePostErrorState extends AppStates {}

class GetPostsLoadingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {
  final String error;

  GetPostsErrorState(this.error){
    print(error);
  }
}

class LikePostSuccessState extends AppStates {}

class LikePostErrorState extends AppStates {}

class DeletePostLoadingState extends AppStates {}

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

class GetCommentsErrorState extends AppStates{
  final String error;

  GetCommentsErrorState(this.error){
    print(error);
  }
}

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
class GetDepartmentErrorState extends AppStates{
  final String error;

  GetDepartmentErrorState(this.error){
    print(error);
  }

}

class GetDepartmentAdminsLoadingState extends AppStates{}
class GetDepartmentAdminsSuccessState extends AppStates{}
class GetDepartmentAdminsErrorState extends AppStates{}

class GetNewsLoadingState extends AppStates{}
class GetNewsSuccessState extends AppStates{}
class GetNewsErrorState extends AppStates{
  final String error;

  GetNewsErrorState(this.error){
    print(error);
  }

}

class GetSettingsLoadingState extends AppStates {}
class GetSettingsSuccessState extends AppStates {}
class GetSettingsErrorState extends AppStates {
  final String error;

  GetSettingsErrorState(this.error);
}

class GetAllAdminsLoadingState extends AppStates {}

class GetAllAdminsSuccessState extends AppStates {}

class GetAllAdminsErrorState extends AppStates {}

class GetSelectedUserLoadingState extends AppStates {}

class GetSelectedUserSuccessState extends AppStates {}

class GetSelectedUserErrorState extends AppStates {}

class GetSelectedUserPostsLoadingState extends AppStates {}
class GetSelectedUserPostsSuccessState extends AppStates {}
class GetSelectedUserPostsErrorState extends AppStates {}




class RemoveSavedPostLoadingState extends AppStates {}
class RemoveSavedPostSuccessState extends AppStates {}
class RemoveSavedPostErrorState extends AppStates {}

class ChangePasswordSuccessState extends AppStates{}
class ChangePasswordLoadingState extends AppStates{}

class ChangePasswordErrorState extends AppStates{}

class LoadMorePostsLoadingState extends AppStates{}
class LoadMorePostsSuccessState extends AppStates{}
class LoadMorePostsErrorState extends AppStates{
  final String error;

  LoadMorePostsErrorState(this.error);
}

class GetLastPostsSuccessState extends AppStates{}

class GetLastPostsErrorState extends AppStates{
  final String error;

  GetLastPostsErrorState(this.error){
    print(error.toString());
  }
}

class GetLastPostsLoadingState extends AppStates{}

class GetLastNewsLoadingState extends AppStates{}

class GetLastNewsSuccessState extends AppStates{}

class GetLastNewsErrorState extends AppStates{
  final String error;

  GetLastNewsErrorState(this.error){
    print(error.toString());
  }
}

class GetLastSavedPostsLoadingState extends AppStates{}

class GetLastSavedPostsSuccessState extends AppStates{}

class GetLastSavedPostsErrorState extends AppStates{
  final String error;

  GetLastSavedPostsErrorState(this.error){
    print(error.toString());
  }
}

class GetMyPhotosSuccessState extends AppStates{}

class GetMyPhotosErrorState extends AppStates{
  final String error;

  GetMyPhotosErrorState(this.error){
    print(error.toString());
  }
}

class GetMyPhotosLoadingState extends AppStates{}

class GetLastMyPhotosLoadingState extends AppStates{}

class GetLastMyPhotosSuccessState extends AppStates{}

class GetLastMyPhotosErrorState extends AppStates{
  final String error;

  GetLastMyPhotosErrorState(this.error){
    print(error.toString());
  }
}

class GetPersonPhotosLoadingState extends AppStates{}

class GetPersonPhotosSuccessState extends AppStates{}

class GetPersonPhotosErrorState extends AppStates{
  final String error;

  GetPersonPhotosErrorState(this.error){
    print(error.toString());
  }
}

class GetLastPersonPhotosSuccessState extends AppStates{}

class GetLastPersonPhotosErrorState extends AppStates{
  final String error;

  GetLastPersonPhotosErrorState(this.error){
    print(error.toString());
  }
}

class GetLastPersonPhotosLoadingState extends AppStates{}

class GetLastSelectedUserPostsSuccessState extends AppStates{}

class GetLastSelectedUserPostsErrorState extends AppStates{
  final String error;

  GetLastSelectedUserPostsErrorState(this.error){
    print(error.toString());
  }
}

class GetLastSelectedUserPostsLoadingState extends AppStates{}

class GetLastCommentsLoadingState extends AppStates{}

class GetLastCommentsSuccessState extends AppStates{}

class GetLastCommentsErrorState extends AppStates{
  final String error;

  GetLastCommentsErrorState(this.error){
    print(error.toString());
  }
}

