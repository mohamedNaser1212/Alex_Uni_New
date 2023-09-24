import 'dart:io';
import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/models/department_model.dart';
import 'package:alex_uni_new/models/post_model.dart';
import 'package:alex_uni_new/models/university_model.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:alex_uni_new/screens/chat_screens/chat_screen.dart';
import 'package:alex_uni_new/screens/user_screens/home_screen.dart';
import 'package:alex_uni_new/screens/user_screens/notification_screen.dart';
import 'package:alex_uni_new/screens/user_screens/settings_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmt/gmt.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../main.dart';
import '../models/admin_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];
  List<IconData> bottomNavIcons = [
    Icons.home,
    Icons.chat,
    Icons.notifications,
    Icons.settings,
  ];
  List<String> titles = [
    lang == 'en' ? 'Home' : 'الرئيسية',
    lang == 'en' ? 'Chat' : 'المحادثات',
    lang == 'en' ? 'Notifications' : 'الاشعارات',
    lang == 'en' ? 'Settings' : 'الاعدادات',
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void changeAppLanguage({
    required BuildContext context,
    required Locale? newLocale,
  }) {
    if (newLocale != null) {
      lang = newLocale.toString();
      CacheHelper.saveData(
        key: 'lang',
        value: newLocale.toString(),
      ).then((value) {
        MyApp.setLocale(
          context,
          newLocale,
        );
        titles = [
          lang == 'en' ? 'Home' : 'الرئيسية',
          lang == 'en' ? 'Chat' : 'المحادثات',
          lang == 'en' ? 'Notifications' : 'الاشعارات',
          lang == 'en' ? 'Settings' : 'الاعدادات',
        ];
        emit(AppChangeLanguageState());
      }).catchError((e) {
        emit(AppChangeLanguageErrorState());
      });
    }
  }

  UserModel? user;
  getUserData(){
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value){
      user = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  updateUser({required String name, String? image, String? phone}) {
    emit(UserModelUpdateLoadingState());
    UserModel user2 = UserModel(
        name: name,
        phone: phone,
        email: user!.email,
        uId: user!.uId,
        image: image ?? user!.image,
        cover: user!.cover,
        bio: user!.bio,
        universityname: user!.universityname,
        country: user!.country,
        passportId: user!.passportId,
        address: user!.address,
        savedPosts: user!.savedPosts,
        sharePosts: user!.sharePosts,
        underGraduate: user!.underGraduate,
        postGraduate: user!.postGraduate
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(user2.toMap())
        .then((value) {
      getUserData();
      emit(UserModelUpdateSuccessState());
    }).catchError((error) {
      emit(UserModelUpdateErrorState());
    });
  }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SelectImageSuccessState());
    } else {}
  }

  void uploadProfileImage({
    required String name,
  }) {
    emit(UserModelUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, image: value);
        profileImage = null;
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  File? postImage;
  var picker1 = ImagePicker();
  Future<void> getPostImage() async {
    final pickedFile = await picker1.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SelectImageSuccessState());
    } else {}
  }

  void uploadPostImage({
    required String text,
    context,
  }) {
    emit(UserModelUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          image: value,
          context: context,
        );
        postImage = null;
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  removePostImage() {
    postImage = null;
    emit(DeletePostImageSuccessState());
  }

  createPost({
    required String text,
    required String image,
    context,
  }) {
    emit(CreatePostLoadingState());
    PostModel postModel = PostModel(
      text: text,
      date: DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now()),
      userName: user!.name,
      userImage: user!.image,
      userId: user!.uId,
      likes: [],
      comments: [],
      image: image,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      getPosts();
      emit(CreatePostSuccessState());
      Navigator.pop(context);
    });
  }

  List<Map<String, PostModel>> posts = [];
  List<PostModel> post = [];
  List postsId = [];
  getPosts() {
    posts = [];
    postsId = [];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        post.add(PostModel.fromJson(element.data()));
        posts.add({
          element.reference.id: PostModel.fromJson(element.data()),
        });
        postsId.add(element.id);
      }
    }).then((value) {
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }

  updatePostLikes(Map<String, PostModel> post) {
    if (post.values.single.likes!.any((element) => element == user!.uId)) {
      debugPrint('exist and remove');

      post.values.single.likes!.removeWhere((element) => element == user!.uId);
    } else {
      post.values.single.likes!.add(user!.uId!);
    }

    FirebaseFirestore.instance
        .collection('posts')
        .doc(post.keys.single)
        .update(post.values.single.toMap())
        .then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {});
  }

  writeComment({
    required String text,
    required String postId,
}){
    emit(WriteCommentLoadingState());
    CommentDataModel commentModel = CommentDataModel(
      text: text,
      time: DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now()),
      ownerName: user!.name!,
      ownerImage: user!.image!,
      ownerId: user!.uId!,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update({
      'comments': FieldValue.arrayUnion([commentModel.toJson()])
    }).then((value) {
      getComments(postId: postId);
      emit(WriteCommentSuccessState());
    }).catchError((error) {
      emit(WriteCommentErrorState());
    });
  }

  deleteComment(index, postId){
    emit(DeleteCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update({
      'comments': FieldValue.arrayRemove([comments[index].toJson()])
    }).then((value) {
      getComments(postId: postId);
      emit(DeleteCommentSuccessState());
    }).catchError((error) {
      emit(DeleteCommentErrorState());
    });
  }

  List<CommentDataModel> comments = [];
  getComments({
    required String postId,
}){
    emit(GetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      comments = [];
      for (var element in value.data()!['comments']) {
        comments.add(CommentDataModel.fromJson(element));
      }
      emit(GetCommentsSuccessState());
    }).catchError((error) {
      emit(GetCommentsErrorState());
    });
  }
  deletePost(String id) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(id)
        .delete()
        .then((value) {
      getPosts();
      getMyPosts();
      emit(DeletePostSuccessState());
    });
  }


  List<MessageModel> messages = [];

  sendMessage({
    required String receiverId,
    required String text,
    String? image,
  }) async {
    var now = await GMT.now();
    MessageModel messageModel = MessageModel(
      image: image ?? '',
      senderId: user!.uId,
      receiverId: receiverId,
      dateTime: now.toString(),
      message: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(user!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  receiveMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(ReceiveMessageSuccessState());
    });
  }

  File? image;
  pickPhoto({
    required ImageSource source,
    required String receiverId,
  }) {
    ImagePicker().pickImage(source: source).then((value) {
      image = File(value!.path);
      uploadImage(receiverId);
    }).catchError((error) {
      emit(SelectImageErrorState());
    });
  }

  sendImage({
    required String image,
    required String dateTime,
    required String receiverId,
    required String senderId,
  }) {
    MessageModel messageModel = MessageModel(
      message: '',
      dateTime: dateTime,
      image: image,
      receiverId: receiverId,
      senderId: senderId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  uploadImage(String receiverId) {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('chats/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value)async {
        var now = await GMT.now();
        sendImage(
          image: value,
          receiverId: receiverId,
          senderId: uId!,
          dateTime: now.toString(),
        );
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadImageErrorState());
    });
  }

  List<Map<String, PostModel>> myPosts = [];
  List myPostsId = [];
  getMyPosts() {
    myPosts = [];
    myPostsId = [];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['userId'] == uId) {
          myPosts.add({
            element.reference.id: PostModel.fromJson(element.data()),
          });
          myPostsId.add(element.id);
        }
      }
    }).then((value) {
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState());
    });
  }

  addSavePosts({
    required String postId,
    required int index
}){
    emit(AddSavePostLoadingState());
   SavePostsModel savePostsModel=SavePostsModel(
       postId: postId,
       text: posts[index].values.single.text,
       date: posts[index].values.single.date,
       userName: posts[index].values.single.userName,
       userImage: posts[index].values.single.userImage,
       userId: posts[index].values.single.userId,
       likes: posts[index].values.single.likes,
       comments: posts[index].values.single.comments,
       image: posts[index].values.single.image,
   );
    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'savedPosts': FieldValue.arrayUnion([savePostsModel.toMap()]),
    }).then((value) {
      emit(AddSavePostSuccessState());
    }).catchError((error) {
      emit(AddSavePostErrorState());
    });
  }

  List<SavePostsModel> savedPosts=[];

  getSavePosts(){
    emit(GetSavedPostsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      savedPosts=[];
      for(var element in value.data()!['savedPosts']){
        savedPosts.add(SavePostsModel.fromJson(element));
      }
      emit(GetSavedPostsSuccessState());
    }).catchError((error) {
      emit(GetSavedPostsErrorState());
    });
  }

  addSharedPosts({
    required String postId,
    required int index,
    required context,
}){
    emit(AddSharePostLoadingState());
   SharePostModel sharePostModel=SharePostModel(
       postId: postId,
       text: posts[index].values.single.text,
       date: posts[index].values.single.date,
       userName: posts[index].values.single.userName,
       userImage: posts[index].values.single.userImage,
       userId: posts[index].values.single.userId,
       likes: posts[index].values.single.likes,
       comments: posts[index].values.single.comments,
       image: posts[index].values.single.image,
   );
    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'sharePosts': FieldValue.arrayUnion([sharePostModel.toMap()]),
    }).then((value) {
      showFlushBar(
          context: context,
          message: 'Shared Successfully',
      );
      emit(AddSharePostSuccessState());
    }).catchError((error) {
      emit(AddSharePostErrorState());
    });
  }

  List<SharePostModel> sharePosts=[];

  getSharePosts(){
    emit(GetSharedPostsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      sharePosts=[];
      for(var element in value.data()!['sharePosts']){
        sharePosts.add(SharePostModel.fromJson(element));
      }
      emit(GetSharedPostsSuccessState());
    }).catchError((error) {
      emit(GetSharedPostsErrorState());
    });
  }


  logout(context) {
    emit(AppLogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId').then((value) {
        currentIndex = 0;
        uId = null;
        navigateAndFinish(
          context: context,
          screen: const LoginScreen(),
        );
      });
      emit(AppLogoutSuccessState());
    }).catchError((onError) {
      emit(AppLogoutErrorState());
    });
  }

  deleteUser({
    required context,
    required String id,
  }) {
    FirebaseFirestore.instance.collection("users").doc(id).delete().then((_) {
      var user = FirebaseAuth.instance.currentUser!;
      user.delete().then((value) {
        logout(context);
        emit(DeleteAccountSuccessState());
      });
    });
  }



  List<UniversityModel> universities = [];
  getUniversities() {
    emit(GetUniversityLoadingState());
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
      emit(GetUniversitySuccessState());
    }).catchError((error) {
      emit(GetUniversityErrorState());
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
    emit(GetDepartmentLoadingState());
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
        if(currentDepartment.underGraduate==true){
          unGraduateDepartments.add(currentDepartment);
        }
          if(currentDepartment.postGraduate==true){
            postGraduateDepartments.add(currentDepartment);
          }
      }
    }).then((value) {
      emit(GetDepartmentSuccessState());
    }).catchError((error) {
      emit(GetDepartmentErrorState());
    });
  }

  List<AdminModel> admins = [];
  getDepartmentAdmins({
    required String universityId,
    required String departmentId,
  }) {
    emit(GetDepartmentLoadingState());
    FirebaseFirestore.instance
        .collection('Universities')
        .doc(universityId)
        .collection('Departments')
        .doc(departmentId)
        .collection('Admins')
        .get()
        .then((value) {
      for (var element in value.docs) {
        AdminModel currentAdmin=AdminModel.fromJson(element.data());
        currentAdmin.id=element.id;
        admins.add(currentAdmin);
      }
    }).then((value) {
      emit(GetDepartmentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDepartmentErrorState());
    });
  }

}
