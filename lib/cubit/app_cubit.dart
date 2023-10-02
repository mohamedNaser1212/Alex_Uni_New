import 'dart:io';
import 'package:alex_uni_new/cache_helper.dart';
import 'package:alex_uni_new/models/both_news_model.dart';
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
import '../models/news_model.dart';
import '../models/settings_model.dart';
import '../models/user_model.dart';
import '../screens/user_screens/settings_details_screen_layout.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    // const ChatScreen(),
    // const NotificationScreen(),
    const SettingsLayoutScreen(),
  ];
  List<IconData> bottomNavIcons = [
    Icons.home,
    // Icons.chat,
    // Icons.notifications,
    Icons.settings,
  ];
  List<String> titles = [
    lang == 'en' ? 'Home' : 'الرئيسية',
    // lang == 'en' ? 'Chat' : 'المحادثات',
    // lang == 'en' ? 'Notifications' : 'الاشعارات',
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
          // lang == 'en' ? 'Chat' : 'المحادثات',
          // lang == 'en' ? 'Notifications' : 'الاشعارات',
          lang == 'en' ? 'Settings' : 'الاعدادات',
        ];
        emit(AppChangeLanguageState());
      }).catchError((e) {
        emit(AppChangeLanguageErrorState());
      });
    }
  }

  UserModel? user;
  getUserData() {
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      user = UserModel.fromJson(value.data()!);
      emit(AppGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetUserErrorState(error.toString()));
    });
  }

  updateUser(
      {required String name, String? image, String? phone, String? cover}) {
    emit(UserModelUpdateLoadingState());
    UserModel user2 = UserModel(
        name: name,
        phone: phone,
        email: user!.email,
        uId: user!.uId,
        image: image ?? user!.image,
        cover: cover ?? user!.cover,
        bio: user!.bio,
        universityname: user!.universityname,
        country: user!.country,
        passportId: user!.passportId,
        address: user!.address,
        savedPosts: user!.savedPosts,
        sharePosts: user!.sharePosts,
        underGraduate: user!.underGraduate,
        postGraduate: user!.postGraduate);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(user2.toMap())
        .then((value) {
      FirebaseFirestore.instance.collection('posts').where('userId',isEqualTo: uId).get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.update({
            'userName': name,
            'userImage': image ?? user!.image,
          });
        }
      }).then((value) {
        FirebaseFirestore.instance.collectionGroup('comments').where('ownerId',isEqualTo: uId).get().then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.update({
              'ownerName': name,
              'ownerImage': image ?? user!.image,
            });
          }
        }).then((value) {
          getUserData();
          emit(UserModelUpdateSuccessState());
        }).catchError((error) {
          emit(UserModelUpdateErrorState(error.toString()));
        });
      });
    }).catchError((error) {
      emit(UserModelUpdateErrorState(error.toString()));
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

  File? coverImage;
  var coverPicker = ImagePicker();
  Future<void> getCoverImage() async {
    final pickedFile = await coverPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SelectImageSuccessState());
    } else {}
  }

  void uploadCoverImage({
    required String name,
    required String phone,
  }) {
    emit(UserModelUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, cover: value, phone: phone);
        coverImage = null;
      }).catchError((error) {
        emit(UploadImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(UploadImageErrorState(error.toString()));
    });
  }

  void uploadProfileImage({
    required String name,
    required String phone,
  }) {
    emit(UserModelUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, image: value, phone: phone);
        profileImage = null;
      }).catchError((error) {
        emit(UploadImageErrorState(error().toString()));
      });
    }).catchError((error) {
      emit(UploadImageErrorState(error().toString()));
    });
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  List<String> imageUrl = [];
  FirebaseStorage storageRef = FirebaseStorage.instance;
  void selectImages() async {
    List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    emit(SelectImageSuccessState());
  }

  List<String> list = [];
  Future<void> uploadImages(List<XFile> images, context, String text) async {
    try {
      emit(CreatePostLoadingState());
      List<String> imageUrls = []; // Store download URLs of all images
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(now);

      for (XFile image in images) {
        Reference reference = storageRef.ref().child('posts').child(image.name);

        UploadTask uploadTask = reference.putData(await image.readAsBytes());

        // Wait for the upload task to complete
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL for the current image
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadURL); // Add to the array
      }

      PostModel model = PostModel(
        image: imageUrls, // Store all download URLs
        likes: [],
        userImage: AppCubit.get(context).user!.image!,
        userName: AppCubit.get(context).user!.name!,
        userId: AppCubit.get(context).user!.uId!,
        text: text,
        date: formattedDate,
        showPost: !AppCubit.get(context).settings!.reviewPosts!,
        isReviewed: !AppCubit.get(context).settings!.reviewPosts!,
      );

      // Add the model to Firestore
      await FirebaseFirestore.instance.collection('posts').add(model.toMap());
      imageFileList = [];
      emit(CreatePostSuccessState());

      // Return a success message or value if needed
    } catch (error) {
      // Handle any errors here
      print('Error uploading images: $error');
      // You can throw the error or return an error message if needed
    }
  }

  List<Map<String, PostModel>> posts = [];
  List<PostModel> post = [];
  List postsId = [];
  getPosts() {
    posts = [];
    postsId = [];
    post = [];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('showPost', isEqualTo: true)
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
      emit(GetPostsErrorState(error.toString()));
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
      getUserData();
      emit(LikePostSuccessState());
    }).catchError((error) {});
  }

  writeComment({
    required String text,
    required String postId,
  }) {
    emit(WriteCommentLoadingState());
    CommentDataModel commentModel = CommentDataModel(
      text: text,
      time: DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now()),
      ownerName: user!.name!,
      ownerImage: user!.image!,
      ownerId: user!.uId!,
    );
    FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').add(
      commentModel.toJson(),
    ).then((value) {
      getComments(postId: postId);
      emit(WriteCommentSuccessState());
    }).catchError((error) {
      emit(WriteCommentErrorState());
    });
  }
  // emit(DeleteCommentSuccessState());
  // emit(DeleteCommentErrorState());
  deleteComment({
    required String commentId,
    required String postId,
  }) {
    emit(DeleteCommentLoadingState());
    FirebaseFirestore.instance
    .collection('posts')
    .doc(postId)
    .collection('comments')
    .doc(commentId)
    .delete().then((value){
      getComments(postId: postId);
      emit(DeleteCommentSuccessState());
    }).catchError((error){
      emit(DeleteCommentErrorState());
    });

  }

  List<CommentDataModel> comments = [];
  getComments({
    required String postId,
  }) {
    emit(GetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      comments = [];
      for (var element in value.docs) {
        CommentDataModel currentComment = CommentDataModel.fromJson(element.data());
        currentComment.id = element.id;
        comments.add(currentComment);
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
      value.ref.getDownloadURL().then((value) async {
        var now = await GMT.now();
        sendImage(
          image: value,
          receiverId: receiverId,
          senderId: uId!,
          dateTime: now.toString(),
        );
      }).catchError((error) {
        emit(UploadImageErrorState(error().toString()));
      });
    }).catchError((error) {
      print(error.toString());
      emit(UploadImageErrorState(error().toString()));
    });
  }

  List<Map<String, PostModel>> myPosts = [];
  List<String> myphotos = [];
  List myPostsId = [];
  getMyPosts() {
    myPosts = [];
    myphotos = [];
    myPostsId = [];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('showPost', isEqualTo: true)
        .where('userId', isEqualTo: uId)
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        myPosts.add({
          element.reference.id: PostModel.fromJson(element.data()),
        });
        myPostsId.add(element.id);
        element.data()['image'].forEach((element) {
          myphotos.add(element);
        });
      }
    }).then((value) {
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  addSavePosts({
    required String postId,
    required int index,
    required String text,
    required String date,
    required String userName,
    required String userImage,
    required String userId,
    required List<String> likes,
    required List<String> image,
  }) {
    emit(AddSavePostLoadingState());
    // SavePostsModel savePostsModel = SavePostsModel(
    //   postId: postId,
    //   text: posts[index].values.single.text,
    //   date: posts[index].values.single.date,
    //   userName: posts[index].values.single.userName,
    //   userImage: posts[index].values.single.userImage,
    //   userId: posts[index].values.single.userId,
    //   likes: posts[index].values.single.likes,
    //   image: posts[index].values.single.image,
    // );
    SavePostsModel savePostsModel = SavePostsModel(
      postId: postId,
      text: text,
      date: date,
      userName: userName,
      userImage: userImage,
      userId: userId,
      likes: likes,
      image: image,
    );
    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'savedPosts': FieldValue.arrayUnion([savePostsModel.toMap()]),
    }).then((value) {
      getUserData();
      getSavePosts();
      emit(AddSavePostSuccessState());
    }).catchError((error) {
      emit(AddSavePostErrorState());
    });
  }

  List<SavePostsModel> savedPosts = [];

  getSavePosts() {
    emit(GetSavedPostsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      savedPosts = [];
      for (var element in value.data()!['savedPosts']) {
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
  }) {
    emit(AddSharePostLoadingState());
    SharePostModel sharePostModel = SharePostModel(
      postId: postId,
      text: posts[index].values.single.text,
      date: posts[index].values.single.date,
      userName: posts[index].values.single.userName,
      userImage: posts[index].values.single.userImage,
      userId: posts[index].values.single.userId,
      likes: posts[index].values.single.likes,
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

  List<SharePostModel> sharePosts = [];

  getSharePosts() {
    emit(GetSharedPostsLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      sharePosts = [];
      for (var element in value.data()!['sharePosts']) {
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
    universities = [];
    emit(GetUniversityLoadingState());
    FirebaseFirestore.instance
        .collection('Universities')
        .orderBy('name')
        .get()
        .then((value) {
      for (var element in value.docs) {
        UniversityModel currentUniversity =
            UniversityModel.fromJson(element.data());
        currentUniversity.id = element.id;
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
        DepartmentModel currentDepartment =
            DepartmentModel.fromJson(element.data());
        currentDepartment.id = element.id;
        if (currentDepartment.isUnderGraduate == true) {
          unGraduateDepartments.add(currentDepartment);
        }
        if (currentDepartment.isPostGraduate == true) {
          postGraduateDepartments.add(currentDepartment);
        }
      }
    }).then((value) {
      emit(GetDepartmentSuccessState());
    }).catchError((error) {
      emit(GetDepartmentErrorState(error.toString()));
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
        AdminModel currentAdmin = AdminModel.fromJson(element.data());
        currentAdmin.id = element.id;
        admins.add(currentAdmin);
      }
    }).then((value) {
      emit(GetDepartmentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetDepartmentErrorState(error.toString()));
    });
  }

  List<ArabicNewsModel> news = [];
  getArabicNews() {
    emit(GetNewsLoadingState());
    FirebaseFirestore.instance
        .collection('News')
        .where('type', isEqualTo: 'arabic')
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        news.add(ArabicNewsModel.fromJson(element.data()));
      }
    }).then((value) {
      emit(GetNewsSuccessState());
    }).catchError((error) {
      emit(GetNewsErrorState(error.toString()));
    });
  }

  List<BothNewsModel> bothNews = [];
  getEnglishNews() {
    emit(GetNewsLoadingState());
    FirebaseFirestore.instance
        .collection('News')
        .where('type', isEqualTo: 'both')
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        bothNews.add(BothNewsModel.fromJson(element.data()));
      }
    }).then((value) {
      emit(GetNewsSuccessState());
    }).catchError((error) {
      emit(GetNewsErrorState(error.toString()));
    });
  }

  SettingsModel? settings;

  getSettings() {
    emit(GetSettingsLoadingState());
    FirebaseFirestore.instance
        .collection('Settings')
        .doc('settings')
        .get()
        .then((value) {
      settings = SettingsModel.fromJson(value.data()!);
      print(settings!.reviewPosts);
      emit(GetSettingsSuccessState());
    }).catchError((onError) {
      emit(GetSettingsErrorState(onError.toString()));
    });
  }

  List<AdminModel> admin = [];
  getAllAdmins(index) {
    admin = [];
    emit(GetAllAdminsLoadingState());
    FirebaseFirestore.instance.collection('Admins').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['universityId'] == universities[index].id) {
          admin.add(AdminModel.fromJson(element.data()));
        }
      }
    }).then((value) {
      emit(GetAllAdminsSuccessState());
    }).catchError((error) {
      emit(GetAllAdminsErrorState());
    });
  }

  List<AdminModel> postGraduate = [];
  getPostGraduateAdmins() {
    postGraduate = [];
    for (var element in admin) {
      if (element.postGraduate == true) {
        postGraduate.add(element);
      }
    }
    emit(GetAllAdminsSuccessState());
  }

  List<AdminModel> underGraduate = [];
  getUnderGraduateAdmins() {
    underGraduate = [];
    for (var element in admin) {
      if (element.postGraduate != true) {
        underGraduate.add(element);
      }
    }
    emit(GetAllAdminsSuccessState());
  }

  UserModel? selectedUser;
  getSelectedUser(String id) {
    emit(GetSelectedUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      selectedUser = UserModel.fromJson(value.data()!);
      emit(GetSelectedUserSuccessState());
    }).catchError((error) {
      emit(GetSelectedUserErrorState());
    });
  }

  List<PostModel> selectedUserPosts = [];
  getSelectedUserPosts(String id) {
    emit(GetSelectedUserPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: id)
        .where('showPost', isEqualTo: true)
        .orderBy('date', descending: true)
        .get()
        .then((value) {
      selectedUserPosts = [];
      for (var element in value.docs) {
        PostModel postModel = PostModel.fromJson(element.data());
        postModel.postId = element.id;
        selectedUserPosts.add(PostModel.fromJson(element.data()));
      }
      emit(GetSelectedUserPostsSuccessState());
    }).catchError((error) {
      emit(GetSelectedUserPostsErrorState());
    });
  }

  List<SharePostModel> selectedUserSharedPosts = [];
  getSelectedUserSharedPosts(String id) {
    emit(GetSelectedUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      selectedUserSharedPosts = [];
      for (var element in value.data()!['sharePosts']) {
        SharePostModel sharePostModel = SharePostModel.fromJson(element);
        selectedUserSharedPosts.add(sharePostModel);
      }
      emit(GetSelectedUserSuccessState());
    }).catchError((error) {
      emit(GetSelectedUserErrorState());
    });
  }

  removeSavedPost({required int index}) {
    emit(RemoveSavedPostLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).update({
      'savedPosts': FieldValue.arrayRemove([savedPosts[index].toMap()]),
    }).then((value) {
      getSavePosts();
      getUserData();
      emit(RemoveSavedPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RemoveSavedPostErrorState());
    });
  }

  addSharedSavedPosts({
    required String postId,
    required int index,
    required context,
  }) {
    emit(AddSharePostLoadingState());
    SavePostsModel sharePostModel = SavePostsModel(
      postId: postId,
      text: posts[index].values.single.text,
      date: posts[index].values.single.date,
      userName: posts[index].values.single.userName,
      userImage: posts[index].values.single.userImage,
      userId: posts[index].values.single.userId,
      likes: posts[index].values.single.likes,
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
}
