import 'dart:io';

import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/models/post_model.dart';
import 'package:alex_uni_new/reusable_widgets.dart';
import 'package:alex_uni_new/screens/login_screen.dart';
import 'package:alex_uni_new/screens/user_screens/chat_screen.dart';
import 'package:alex_uni_new/screens/user_screens/home_screen.dart';
import 'package:alex_uni_new/screens/user_screens/settings_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    lang=='en'?'Home':'الرئيسية',
    lang=='en'?'Chat':'المحادثات',
    lang=='en'?'Settings':'الاعدادات',
  ];

  void changeBottomNavBar(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  UserModel ?user ;
  void getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      emit(AppGetUserSuccessState());
      user = UserModel.fromJson(value.data());
    }).catchError((onError) {
      emit(AppGetUserErrorState(onError.toString()));
    });
  }

  updateUser({required String name, String? image,String ?phone}) {
    emit(UserModelUpdateLoadingState());
    UserModel user2 = UserModel(
        name: name,
        phone: phone,
        email: user!.email,
        uId: user!.uId,
        image: image ?? user!.image);
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

  removePostImage(){
    postImage=null;
    emit(DeletePostImageSuccessState());
  }

  createPost({
    required String text,
    required String image,
    context,
}){
    emit(CreatePostLoadingState());
    PostModel postModel=PostModel(
        text: text,
        date: DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now()),
        userName: user!.name,
        userImage: user!.image,
        userId: user!.uId,
        likes: [],
        comments: [],
        image: image,
    );
    FirebaseFirestore.instance.collection('posts').add(postModel.toMap()).then((value){
      getPosts();
      emit(CreatePostSuccessState());
      Navigator.pop(context);
    });
  }

  List<Map<String,PostModel>> posts=[];
  List<PostModel> post=[];
  List postsId=[];
  getPosts(){
    posts=[];
    postsId=[];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').orderBy('date',descending: true).get().then((value){
      for (var element in value.docs) {
        post.add(PostModel.fromJson(element.data()));
        posts.add(
          {
            element.reference.id: PostModel.fromJson(element.data()),
          }
        );
        postsId.add(element.id);
      }}).then((value){
        emit(GetPostsSuccessState());
    }).catchError((error){
      emit(GetPostsErrorState());
    });
  }

  updatePostLikes(Map<String, PostModel> post) {
    if (post.values.single.likes!.any((element) => element == user!.uId)) {
      debugPrint('exist and remove');

      post.values.single.likes
          !.removeWhere((element) => element == user!.uId);
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

  deletePost(String id){
    FirebaseFirestore.instance.collection('posts').doc(id).delete().then((value){
      getPosts();
      emit(DeletePostSuccessState());
    });
  }



  List<UserModel> users = [];

  void getAllUsers() {
    users = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
          users.add(UserModel.fromJson(element.data()));
      }
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }
  List<MessageModel> messages=[];

  sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String ? image,
  }) {
    MessageModel messageModel = MessageModel(
      image: image?? '',
      senderId: user!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
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
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(ReceiveMessageSuccessState());
    });
  }

  File ?image;
  pickPhoto({
    required ImageSource source,
    required String receiverId,
  }){
    ImagePicker().pickImage(source: source).then((value){
      image=File(value!.path);
      uploadImage(receiverId);
      emit(SelectImageSuccessState());
    }).catchError((error){
      emit(SelectImageErrorState());
    });
  }

  sendImage({
    required String image,
    required String dateTime,
    required String receiverId,
    required String senderId,
  }){
    MessageModel messageModel=MessageModel(
      message: '',
      dateTime: dateTime,
      image: image,
      receiverId: receiverId,
      senderId: senderId,
    );
    FirebaseFirestore.instance.collection('users').doc(senderId).collection('chats').doc(receiverId).collection('messages').add(messageModel.toMap()).then((value){
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });
  }

  uploadImage(String receiverId){
    emit(UploadImageErrorState());
    FirebaseStorage.instance.ref().child('chats/${Uri.file(image!.path).pathSegments.last}').putFile(image!).then((value){
      value.ref.getDownloadURL().then((value){
        sendImage(
          image: value,
          dateTime: DateTime.now().toString(),
          receiverId: receiverId,
          senderId: uId!,
        );
      }).catchError((error){
        emit(UploadImageErrorState());
      });
    }).catchError((error){
      emit(UploadImageErrorState());
    });
  }

  logout(context){
    emit(AppLogoutLoadingState());
    FirebaseAuth.instance.signOut().then((value) {
      CacheHelper.removeData(key: 'uId').then((value){
        currentIndex=0;
        navigateAndFinish(
            context: context,
            screen: const LoginScreen(),
        );
      });
      emit(AppLogoutSuccessState());
    }).catchError((onError){
      emit(AppLogoutErrorState());
    });
  }

  deleteUser({
    required context,
    required String id,
  }){
    FirebaseFirestore.instance.collection("users").doc(id).delete().then((_){
      var user =  FirebaseAuth.instance.currentUser!;
      user.delete().then((value){
        logout(context);
        emit(DeleteAccountSuccessState());
      });
    });
  }
}