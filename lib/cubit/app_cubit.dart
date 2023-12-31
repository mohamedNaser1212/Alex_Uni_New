// ignore_for_file: avoid_print

import 'dart:io';
import 'package:alex_uni_new/constants/cache_helper.dart';
import 'package:alex_uni_new/constants/constants.dart';
import 'package:alex_uni_new/models/both_news_model.dart';
import 'package:alex_uni_new/models/department_model.dart';
import 'package:alex_uni_new/models/posts/post_model.dart';
import 'package:alex_uni_new/models/university_model.dart';
import 'package:alex_uni_new/widgets/reusable_widgets.dart';
import 'package:alex_uni_new/screens/auth/login_screen.dart';
import 'package:alex_uni_new/screens/chat/chat_screen.dart';
import 'package:alex_uni_new/screens/home/home_screen.dart';
import 'package:alex_uni_new/screens/profile/profile_screen.dart';
import 'package:alex_uni_new/states/app_states.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmt/gmt.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import '../models/admin_model.dart';
import '../models/message_model.dart';
import '../models/news_model.dart';
import '../models/posts/shared_post_model.dart';
import '../models/settings_model.dart';
import '../models/user_model.dart';
import '../screens/notifications/notification_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  List<IconData> bottomNavIcons = [
    IconlyBold.home,
    IconlyBold.message,
    IconlyBold.notification,
    IconlyBold.profile,
  ];

  List<String> titles = [
    lang == 'en' ? 'Good Morning !' : 'اهلا بك !',
    // lang == 'en' ? 'Chat' : 'المحادثات',
    lang == 'en' ? 'Notifications' : 'الاشعارات',
    lang == 'en' ? 'Profile' : 'الملف الشخصي',
  ];

  List<IconData> settingsIcons = [
    Icons.public,
    IconlyBold.lock,
    IconlyBold.delete,
    Icons.headset_mic,
  ];
  List<String> settingsTitles = [
    lang == 'en' ? 'Langauge' : 'اللغة',
    lang == 'en' ? 'Change Password' : 'تغيير كلمة السر',
    lang == 'en' ? 'Delete Account' : 'حذف الحساب',
    lang == 'en' ? 'Help & FAQs' : 'مساعدة',
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
          lang == 'en' ? 'Good Morning !' : 'اهلا بك !',
          // lang == 'en' ? 'Chat' : 'المحادثات',
          lang == 'en' ? 'Notifications' : 'الاشعارات',
          lang == 'en' ? 'Profile' : 'الملف الشخصي',
        ];
        settingsTitles = [
          lang == 'en' ? 'Langauge' : 'اللغة',
          lang == 'en' ? 'Change Password' : 'تغيير كلمة السر',
          lang == 'en' ? 'Delete Account' : 'حذف الحساب',
          lang == 'en' ? 'Help & FAQs' : 'مساعدة',
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
    if (uId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        user = UserModel.fromJson(value.data()!);
        emit(AppGetUserSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetUserErrorState(error.toString()));
      });
    }
  }

  updateUser(
      {required String name,
      String? image,
      String? phone,
      String? cover,
      String? bio}) {
    emit(UserModelUpdateLoadingState());
    UserModel user2 = UserModel(
        name: name,
        phone: phone,
        email: user!.email,
        uId: user!.uId,
        image: image ?? user!.image,
        cover: cover ?? user!.cover,
        bio: bio,
        universityname: user!.universityname,
        country: user!.country,
        passportId: user!.passportId,
        address: user!.address,
        underGraduate: user!.underGraduate,
        postGraduate: user!.postGraduate);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(user2.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: uId)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.update({
            'userName': name,
            'userImage': image ?? user!.image,
          });
        }
      }).then((value) {
        FirebaseFirestore.instance
            .collectionGroup('comments')
            .where('ownerId', isEqualTo: uId)
            .get()
            .then((snapshot) {
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
    required String name, bio,
    required String phone,
  }) {
    emit(UserModelUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, cover: value, phone: phone, bio: bio);
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
    required String bio,
  }) {
    emit(UserModelUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, image: value, phone: phone, bio: bio);
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

      //make document for post
      final postRef = FirebaseFirestore.instance.collection('posts').doc();

      postRef.set({
        'isFinished': false,
      });

      for (XFile image in images) {
        Reference reference = storageRef
            .ref()
            .child('posts/${postRef.id}/image${images.indexOf(image)}');

        UploadTask uploadTask = reference.putData(await image.readAsBytes());

        // Wait for the upload task to complete
        TaskSnapshot taskSnapshot = await uploadTask;

        // Get the download URL for the current image
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(downloadURL); // Add to the array
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .collection('photos')
            .add({
          'image': downloadURL,
          'date': formattedDate,
          'postId': postRef.id,
        });
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

      final firestore = FirebaseFirestore.instance;

      WriteBatch batch = firestore.batch();
      batch.set(postRef, {
        ...model.toMap(),
        'isFinished': true,
      });
      batch.commit();
      imageFileList = [];
      emit(CreatePostSuccessState());
    } catch (error) {
      print('Error uploading images: $error');
    }
  }

  List post = [];
  List postsId = [];

  DocumentSnapshot? lastPost;

  bool isLastPost = false;

  removePosts() {
    post = [];
    postsId = [];
  }

  getPosts() {
    removePosts();
    isLastPost = false;
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('isFinished', isEqualTo: true)
        .where('showPost', isEqualTo: true)
        .orderBy('date', descending: true)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          post.add(currentPost);
          postsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          post.add(currentPost);
          postsId.add(element.id);
        }
      }
      lastPost = value.docs[value.docs.length - 1];
      if (value.docs.length < 5) {
        isLastPost = true;
      }
    }).then((value) {
      emit(GetPostsSuccessState());
    }).catchError((error) {
      isLastPost = true;
      emit(GetPostsErrorState(error.toString()));
    });
  }

  getPostsFromLast() {
    emit(GetLastPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('isFinished', isEqualTo: true)
        .where('showPost', isEqualTo: true)
        .orderBy('date', descending: true)
        .startAfterDocument(lastPost!)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          post.add(currentPost);
          postsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          post.add(currentPost);
          postsId.add(element.id);
        }
      }
      lastPost = value.docs[value.docs.length - 1];
      if (value.docs.length < 5) {
        isLastPost = true;
      }
    }).then((value) {
      emit(GetLastPostsSuccessState());
    }).catchError((error) {
      isLastPost = true;
      emit(GetLastPostsErrorState(error.toString()));
    });
  }

  updatePostLikes(post) {
    if (post.likes!.any((element) => element == uId)) {
      post.likes!.removeWhere((element) => element == uId);
    } else {
      post.likes!.add(uId!);
    }
    FirebaseFirestore.instance.collection('posts').doc(post.postId).update({
      'likes': post.likes!.map((e) => e).toList(),
    }).then((value) {
      FirebaseFirestore.instance
          .collectionGroup('savedPosts')
          .where('postId', isEqualTo: post.postId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          element.reference.update({
            'likes': post.likes!.map((e) => e).toList(),
          });
        }
      });
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
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(
          commentModel.toJson(),
        )
        .then((value) {
      // getComments(postId: postId);
      comments.add(commentModel);
      emit(WriteCommentSuccessState());
    }).catchError((error) {
      emit(WriteCommentErrorState());
    });
  }

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
        .delete()
        .then((value) {
      // getComments(postId: postId);
      comments.removeWhere((element) => element.id == commentId);
      emit(DeleteCommentSuccessState());
    }).catchError((error) {
      emit(DeleteCommentErrorState());
    });
  }

  List<CommentDataModel> comments = [];
  DocumentSnapshot? lastComment;
  bool isLastComment = false;

  removeComments() {
    comments = [];
    lastComment = null;
    isLastComment = false;
  }

  getComments({
    required String postId,
  }) {
    removeComments();
    emit(GetCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .limit(20)
        .get()
        .then((value) {
      comments = [];
      for (var element in value.docs) {
        CommentDataModel currentComment =
            CommentDataModel.fromJson(element.data());
        currentComment.id = element.id;
        comments.add(currentComment);
      }
      if (value.docs.isNotEmpty) {
        lastComment = value.docs[value.docs.length - 1];
      }
      if (value.docs.length < 20) {
        isLastComment = true;
      }
      emit(GetCommentsSuccessState());
    }).catchError((error) {
      emit(GetCommentsErrorState(error.toString()));
    });
  }

  getCommentsFromLast({
    required String postId,
  }) {
    emit(GetLastCommentsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .startAfterDocument(lastComment!)
        .limit(20)
        .get()
        .then((value) {
      for (var element in value.docs) {
        CommentDataModel currentComment =
            CommentDataModel.fromJson(element.data());
        currentComment.id = element.id;
        comments.add(currentComment);
      }
      lastComment = value.docs[value.docs.length - 1];
      if (value.docs.length < 20) {
        isLastComment = true;
      }
      emit(GetLastCommentsSuccessState());
    }).catchError((error) {
      emit(GetLastCommentsErrorState(error.toString()));
    });
  }

  deletePost(model) {
    emit(DeletePostLoadingState());
    if (model is PostModel) {
      for (var element in model.image!) {
        FirebaseStorage.instance.refFromURL(element).delete();
      }
      FirebaseFirestore.instance
          .collection('posts')
          .doc(model.postId)
          .delete()
          .then((value) {
        FirebaseFirestore.instance
            .collectionGroup('savedPosts')
            .where('postId', isEqualTo: model.postId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            element.reference.delete();
          }
        });
        FirebaseFirestore.instance
            .collection('users')
            .doc(uId)
            .collection('photos')
            .where('postId', isEqualTo: model.postId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            element.reference.delete();
          }
        });
        FirebaseFirestore.instance
            .collection('posts')
            .where('isShared', isEqualTo: true)
            .where('postId', isEqualTo: model.postId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            element.reference.delete();
          }
          if (currentIndex == 0) {
            getPosts();
          } else if (currentIndex == 3) {
            getSavePosts();
            getMyPosts();
          }
        });
        emit(DeletePostSuccessState());
      });
    } else if (model is SharePostModel) {
      print(model.postId);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(model.postId)
          .delete()
          .then((value) {
        FirebaseFirestore.instance
            .collectionGroup('savedPosts')
            .where('sharedPostId', isEqualTo: model.postId)
            .get()
            .then((value) {
          for (var element in value.docs) {
            element.reference.delete();
          }
        });
      });
    }
    emit(DeletePostSuccessState());
  }

  bool isExist=false;
  sendMessage({
    required String receiverId,
    required String text,
    required String image,
  })async{
    var now=await GMT.now();
    MessageModel model=MessageModel(
      senderId: user!.uId,
      receiverId: receiverId,
      dateTime: now.toString(),
      message: text,
      image: image,
    );
    print('first $isExist');
    FirebaseFirestore.instance.collection('users').doc(uId).collection('chats').get().then((value){
      for (var element in value.docs) {
        if(element.id==receiverId){
          isExist=true;
        }
      }
      print('second $isExist');

      if(isExist){
        print('hello');
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('chats')
            .doc(receiverId)
            .update({
          'messages':FieldValue.arrayUnion([model.toMap()])
        })
            .then((value){
          emit(SendMessageSuccessState());
        }).catchError((error){
          emit(SendMessageErrorState());
        });

        FirebaseFirestore.instance
            .collection('Admins')
            .doc(receiverId)
            .collection('chats')
            .doc(user!.uId)
            .update({
          'messages':FieldValue.arrayUnion([model.toMap()])
        })
            .then((value){
          emit(SendMessageSuccessState());
        }).catchError((error){
          emit(SendMessageErrorState());
        });
        isExist=false;
      }else{
        print('hello 2');
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('chats')
            .doc(receiverId)
            .set({
          'messages':FieldValue.arrayUnion([model.toMap()])
        })
            .then((value){
          emit(SendMessageSuccessState());
        }).catchError((error){
          emit(SendMessageErrorState());
        });
        FirebaseFirestore.instance.collection('Admins').doc(receiverId).collection('chats').doc(user!.uId).set(
            {'messages':FieldValue.arrayUnion([model.toMap()])
            }).then((value){
          emit(SendMessageSuccessState());
        });
      }
    });
  }

  List messages=[];

  receiveMessages({
    required String receiverId,
  }){
    messages=[];
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .snapshots()
        .listen((event) {
      messages=[];
      event.data()?['messages'].forEach((element) {
        messages.add(MessageModel.fromJson(element));
      });
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

  uploadImage(String receiverId) {
    emit(UploadImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('chats/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendImage(
          image: value,
          receiverId: receiverId,
          senderId: uId!,
        );
      }).catchError((error) {
        emit(UploadImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(UploadImageErrorState(error.toString()));
    });
  }

  sendImage({
    required String image,
    required String receiverId,
    required String senderId,
  }) async{
    var now = await GMT.now();
    MessageModel model = MessageModel(
      message: '',
      dateTime: now.toString(),
      image: image,
      receiverId: receiverId,
      senderId: senderId,
    );
    print('first $isExist');
    FirebaseFirestore.instance.collection('users').doc(uId).collection('chats').get().then((value){
      for (var element in value.docs) {
        if(element.id==receiverId){
          isExist=true;
        }
      }
      print('second $isExist');

      if(isExist){
        print('hello');
        FirebaseFirestore.instance
            .collection('users')
            .doc(senderId)
            .collection('chats')
            .doc(receiverId)
            .update({
          'messages':FieldValue.arrayUnion([model.toMap()])
        })
            .then((value){
          emit(SendMessageSuccessState());
        }).catchError((error){
          emit(SendMessageErrorState());
        });

        FirebaseFirestore.instance
            .collection('Admins')
            .doc(receiverId)
            .collection('chats')
            .doc(senderId)
            .update({
          'messages':FieldValue.arrayUnion([model.toMap()])
        })
            .then((value){
          emit(SendMessageSuccessState());
        }).catchError((error){
          emit(SendMessageErrorState());
        });
        isExist=false;
      }else{
        print('hello 2');
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uId)
            .collection('chats')
            .doc(receiverId)
            .set({
          'messages':FieldValue.arrayUnion([model.toMap()])
        })
            .then((value){
          emit(SendMessageSuccessState());
        }).catchError((error){
          emit(SendMessageErrorState());
        });
        FirebaseFirestore.instance.collection('Admins').doc(receiverId).collection('chats').doc(user!.uId).set(
            {'messages':FieldValue.arrayUnion([model.toMap()])
            }).then((value){
          emit(SendMessageSuccessState());
        });
      }
    });
  }

  List myPosts = [];
  List myPostsId = [];

  DocumentSnapshot? lastMyPost;
  bool isLastMyPost = false;

  removeMyPosts() {
    myPosts = [];
    myPostsId = [];
    lastMyPost = null;
    isLastMyPost = false;
  }

  getMyPosts() {
    removeMyPosts();
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('showPost', isEqualTo: true)
        .where('userId', isEqualTo: uId)
        .orderBy('date', descending: true)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          myPosts.add(currentPost);
          // myphotos.addAll(currentPost.image!);
          myPostsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          myPosts.add(currentPost);
          myPostsId.add(element.id);
          // myphotos.addAll(currentPost.postModel!.image!);
        }
      }
      if (value.docs.length < 5) {
        isLastMyPost = true;
      }
      if(value.docs.isNotEmpty) {
        lastMyPost = value.docs[value.docs.length - 1];
      }
    }).then((value) {
      emit(GetPostsSuccessState());
    }).catchError((error) {
      isLastMyPost = true;
      emit(GetPostsErrorState(error.toString()));
    });
  }

  getMyPostsFromLast() {
    emit(GetLastPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('showPost', isEqualTo: true)
        .where('userId', isEqualTo: uId)
        .orderBy('date', descending: true)
        .startAfterDocument(lastMyPost!)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          myPosts.add(currentPost);
          // myphotos.addAll(currentPost.image!);
          myPostsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          myPosts.add(currentPost);
          myPostsId.add(element.id);
        }
      }
      if (value.docs.length < 5) {
        isLastMyPost = true;
      }
      lastMyPost = value.docs[value.docs.length - 1];
    }).then((value) {
      emit(GetLastPostsSuccessState());
    }).catchError((error) {
      isLastMyPost = true;
      emit(GetLastPostsErrorState(error.toString()));
    });
  }

  List<String> myPhotos = [];
  DocumentSnapshot? lastMyPhoto;
  bool isLastMyPhoto = false;

  removeMyPhotos() {
    myPhotos = [];
    lastMyPhoto = null;
    isLastMyPhoto = false;
  }

  getMyPhotos() {
    removeMyPhotos();
    emit(GetMyPhotosLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('photos')
        .orderBy('date', descending: true)
        .limit(15)
        .get()
        .then((value) {
      for (var element in value.docs) {
        myPhotos.add(element.data()['image']);
      }
      if (value.docs.length < 15) {
        isLastMyPhoto = true;
      }
      lastMyPhoto = value.docs[value.docs.length - 1];
    }).then((value) {
      emit(GetMyPhotosSuccessState());
    }).catchError((error) {
      isLastMyPhoto = true;
      emit(GetMyPhotosErrorState(error.toString()));
    });
  }

  getMyPhotosFromLast() {
    emit(GetLastMyPhotosLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('photos')
        .orderBy('date', descending: true)
        .startAfterDocument(lastMyPhoto!)
        .limit(15)
        .get()
        .then((value) {
      for (var element in value.docs) {
        myPhotos.add(element.data()['image']);
      }
      if (value.docs.length < 15) {
        isLastMyPhoto = true;
      }
      lastMyPhoto = value.docs[value.docs.length - 1];
    }).then((value) {
      emit(GetLastMyPhotosSuccessState());
    }).catchError((error) {
      isLastMyPhoto = true;
      emit(GetLastMyPhotosErrorState(error.toString()));
    });
  }

  List<String> personPhotos = [];
  DocumentSnapshot? lastPersonPhoto;
  bool isLastPersonPhoto = false;

  removePersonPhotos() {
    personPhotos = [];
    lastPersonPhoto = null;
    isLastPersonPhoto = false;
  }

  getPersonPhotos(String userId) {
    removePersonPhotos();
    emit(GetPersonPhotosLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('photos')
        .orderBy('date', descending: true)
        .limit(15)
        .get()
        .then((value) {
      for (var element in value.docs) {
        personPhotos.add(element.data()['image']);
      }
      if (value.docs.length < 15) {
        isLastPersonPhoto = true;
      }
      lastPersonPhoto = value.docs[value.docs.length - 1];
    }).then((value) {
      emit(GetPersonPhotosSuccessState());
    }).catchError((error) {
      isLastPersonPhoto = true;
      emit(GetPersonPhotosErrorState(error.toString()));
    });
  }

  getPersonPhotosFromLast(String userId) {
    emit(GetLastPersonPhotosLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('photos')
        .orderBy('date', descending: true)
        .startAfterDocument(lastPersonPhoto!)
        .limit(15)
        .get()
        .then((value) {
      for (var element in value.docs) {
        personPhotos.add(element.data()['image']);
      }
      if (value.docs.length < 15) {
        isLastPersonPhoto = true;
      }
      lastPersonPhoto = value.docs[value.docs.length - 1];
    }).then((value) {
      emit(GetLastPersonPhotosSuccessState());
    }).catchError((error) {
      isLastPersonPhoto = true;
      emit(GetLastPersonPhotosErrorState(error.toString()));
    });
  }

  addSavePosts({
    required model,
  }) {
    emit(AddSavePostLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('savedPosts')
        .doc('${model.postId}')
        .set(
          model is PostModel
              ? model.toMap()
              : {
                  ...model.toMap(),
                  'sharedPostId': model.postId,
                },
        )
        .then((value) {
      savedPostsId.add(model.postId);
      savedPosts.add(model);
      selectedUserSavedPostsId.add(model.postId);
      selectedUserSavedPosts.add(model);
      // getSavePosts();
      emit(AddSavePostSuccessState());
    }).catchError((error) {
      emit(AddSavePostErrorState());
    });
  }

  List savedPosts = [];
  List<String> savedPostsId = [];

  DocumentSnapshot? lastSavedPost;
  bool isLastSavedPost = false;

  getSavePosts() {
    removeSavedPosts();
    emit(GetSavedPostsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('savedPosts')
        .orderBy('date', descending: true)
        .limit(5)
        .get()
        .then((value) {
      savedPosts = [];
      savedPostsId = [];
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          savedPosts.add(currentPost);
          savedPostsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          savedPosts.add(currentPost);
          savedPostsId.add(element.id);
        }
      }
      if (value.docs.length < 5) {
        isLastSavedPost = true;
      }
      if (value.docs.isNotEmpty) {
        lastSavedPost = value.docs[value.docs.length - 1];
      }
      emit(GetSavedPostsSuccessState());
    }).catchError((error) {
      isLastSavedPost = true;
      emit(GetSavedPostsErrorState());
    });
  }

  getSavedPostsFromLast() {
    emit(GetLastSavedPostsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('savedPosts')
        .orderBy('date', descending: true)
        .startAfterDocument(lastSavedPost!)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          savedPosts.add(currentPost);
          savedPostsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          savedPosts.add(currentPost);
          savedPostsId.add(element.id);
        }
      }
      if (value.docs.length < 5) {
        isLastSavedPost = true;
      }
      if (value.docs.isNotEmpty) {
        lastSavedPost = value.docs[value.docs.length - 1];
      }
      emit(GetLastSavedPostsSuccessState());
    }).catchError((error) {
      isLastSavedPost = true;
      emit(GetLastSavedPostsErrorState(error.toString()));
    });
  }

  List selectedUserSavedPosts = [];
  List<String> selectedUserSavedPostsId = [];
  DocumentSnapshot? lastSelectedUserSavedPost;
  bool isLastSelectedUserSavedPost = false;

  removeSelectedUserSavedPosts() {
    selectedUserSavedPosts = [];
    selectedUserSavedPostsId = [];
    lastSelectedUserSavedPost = null;
    isLastSelectedUserSavedPost = false;
  }

  getSelectedUserSavedPosts(String userId) {
    removeSelectedUserSavedPosts();
    emit(GetSelectedUserSavedPostsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('savedPosts')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserSavedPosts.add(currentPost);
          selectedUserSavedPostsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserSavedPosts.add(currentPost);
          selectedUserSavedPostsId.add(element.id);
        }
      }
      if (value.docs.length < 5) {
        isLastSelectedUserSavedPost = true;
      }
      if (value.docs.isNotEmpty) {
        lastSelectedUserSavedPost = value.docs[value.docs.length - 1];
      }
      emit(GetSelectedUserSavedPostsSuccessState());
    }).catchError((error) {
      isLastSelectedUserSavedPost = true;
      emit(GetSelectedUserSavedPostsErrorState(error.toString()));
    });
  }

  getSelectedUserSavedPostsFromLast(String userId) {
    emit(GetLastSelectedUserSavedPostsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('savedPosts')
        .where('userId', isEqualTo: userId)
        .orderBy('date', descending: true)
        .startAfterDocument(lastSelectedUserSavedPost!)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserSavedPosts.add(currentPost);
          selectedUserSavedPostsId.add(element.id);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserSavedPosts.add(currentPost);
          selectedUserSavedPostsId.add(element.id);
        }
      }
      if (value.docs.length < 5) {
        isLastSelectedUserSavedPost = true;
      }
      lastSelectedUserSavedPost = value.docs[value.docs.length - 1];
      emit(GetLastSelectedUserSavedPostsSuccessState());
    }).catchError((error) {
      isLastSelectedUserSavedPost = true;
      emit(GetLastSelectedUserSavedPostsErrorState(error.toString()));
    });
  }

  removeSavedPosts() {
    savedPosts = [];
    savedPostsId = [];
    lastSavedPost = null;
    isLastSavedPost = false;
  }

  sharePost({
    required PostModel model,
    required String text,
    required BuildContext context,
  }) {
    emit(AddSharePostLoadingState());
    SharePostModel sharePostModel = SharePostModel(
      postModel: model,
      shareUserName: user!.name!,
      shareUserImage: user!.image!,
      shareUserId: uId,
      sharePostText: text,
    );
    sharePostModel.postModel!.postId = model.postId;
    FirebaseFirestore.instance.collection('posts').add({
      ...sharePostModel.toMap(),
      'isFinished': true,
    }).then((value) {
      emit(AddSharePostSuccessState());
    }).catchError((error) {
      emit(AddSharePostErrorState());
    });
  }

  removeSavedPost({required String postId}) {
    emit(RemoveSavedPostLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('savedPosts')
        .doc(postId)
        .delete()
        .then((value) {
      savedPosts.removeWhere((element) => element.postId == postId);
      savedPostsId.removeWhere((element) => element == postId);
      selectedUserSavedPosts.removeWhere((element) => element.postId == postId);
      selectedUserSavedPostsId.removeWhere((element) => element == postId);
      emit(RemoveSavedPostSuccessState());
    }).catchError((error) {
      emit(RemoveSavedPostErrorState());
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

  bool isLastNews = false;

  List<ArabicNewsModel> news = [];
  DocumentSnapshot? lastArabicNews;

  removeNews() {
    news = [];
    bothNews = [];
    lastBothNews = null;
    lastArabicNews = null;
    isLastNews = false;
  }

  getArabicNews() {
    removeNews();
    emit(GetNewsLoadingState());
    FirebaseFirestore.instance
        .collection('News')
        .orderBy('date', descending: true)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        news.add(ArabicNewsModel.fromJson(element.data()));
      }
      lastArabicNews = value.docs[value.docs.length - 1];
      if (value.docs.length < 5) {
        isLastNews = true;
      }
    }).then((value) {
      emit(GetNewsSuccessState());
    }).catchError((error) {
      isLastNews = true;
      emit(GetNewsErrorState(error.toString()));
    });
  }

  getArabicNewsFromLast() {
    emit(GetLastNewsLoadingState());
    FirebaseFirestore.instance
        .collection('News')
        .where('type', isEqualTo: 'arabic')
        .orderBy('date', descending: true)
        .startAfterDocument(lastArabicNews!)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        news.add(ArabicNewsModel.fromJson(element.data()));
      }
      lastArabicNews = value.docs[value.docs.length - 1];
      if (value.docs.length < 5) {
        isLastNews = true;
      }
    }).then((value) {
      emit(GetLastNewsSuccessState());
    }).catchError((error) {
      isLastNews = true;
      emit(GetLastNewsErrorState(error.toString()));
    });
  }

  List<BothNewsModel> bothNews = [];
  DocumentSnapshot? lastBothNews;

  getEnglishNews() {
    removeNews();
    emit(GetNewsLoadingState());
    FirebaseFirestore.instance
        .collection('News')
        .where('type', isEqualTo: 'both')
        .orderBy('date', descending: true)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        bothNews.add(BothNewsModel.fromJson(element.data()));
      }
      lastBothNews = value.docs[value.docs.length - 1];
      if (value.docs.length < 5) {
        isLastNews = true;
      }
    }).then((value) {
      emit(GetNewsSuccessState());
    }).catchError((error) {
      isLastNews = true;
      emit(GetNewsErrorState(error.toString()));
    });
  }

  getEnglishNewsFromLast() {
    emit(GetLastNewsLoadingState());
    FirebaseFirestore.instance
        .collection('News')
        .where('type', isEqualTo: 'both')
        .orderBy('date', descending: true)
        .startAfterDocument(lastBothNews!)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        bothNews.add(BothNewsModel.fromJson(element.data()));
      }
      lastBothNews = value.docs[value.docs.length - 1];
      if (value.docs.length < 5) {
        isLastNews = true;
      }
    }).then((value) {
      emit(GetLastNewsSuccessState());
    }).catchError((error) {
      isLastNews = true;
      emit(GetLastNewsErrorState(error.toString()));
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

  List selectedUserPosts = [];
  List<String> selectedUserPhotos = [];

  DocumentSnapshot? lastSelectedUserPost;
  bool isLastSelectedUserPost = false;

  removeSelectedUserPosts() {
    selectedUserPosts = [];
    selectedUserPhotos = [];
    lastSelectedUserPost = null;
    isLastSelectedUserPost = false;
  }

  getSelectedUserPosts(String id) {
    removeSelectedUserPosts();
    emit(GetSelectedUserPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: id)
        .where('showPost', isEqualTo: true)
        .orderBy('date', descending: true)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserPosts.add(currentPost);
          selectedUserPhotos.addAll(currentPost.image!);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserPosts.add(currentPost);
          selectedUserPhotos.addAll(currentPost.postModel!.image!);
        }
      }
      if (value.docs.length < 5) {
        isLastSelectedUserPost = true;
      }
      lastSelectedUserPost = value.docs[value.docs.length - 1];
      emit(GetSelectedUserPostsSuccessState());
    }).catchError((error) {
      isLastSelectedUserPost = true;
      emit(GetSelectedUserPostsErrorState());
    });
  }

  getSelectedUserPostsFromLast(String id) {
    emit(GetLastSelectedUserPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: id)
        .where('showPost', isEqualTo: true)
        .orderBy('date', descending: true)
        .startAfterDocument(lastSelectedUserPost!)
        .limit(5)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['isShared'] == false) {
          PostModel currentPost = PostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserPosts.add(currentPost);
        } else {
          SharePostModel currentPost = SharePostModel.fromJson(element.data());
          currentPost.postId = element.id;
          selectedUserPosts.add(currentPost);
        }
      }
      if (value.docs.length < 5) {
        isLastSelectedUserPost = true;
      }
      lastSelectedUserPost = value.docs[value.docs.length - 1];
      emit(GetLastSelectedUserPostsSuccessState());
    }).catchError((error) {
      isLastSelectedUserPost = true;
      emit(GetLastSelectedUserPostsErrorState(error.toString()));
    });
  }

  customDialog({
    required BuildContext context,
    void Function()? leftBtn,
    void Function()? rightBtn,
    String leftBtnText = "Cancel",
    String rightBtnText = "Delete",
    CrossAxisAlignment crossAxis = CrossAxisAlignment.start,
    String title = "Attention",
    String desc1 =
        "Alexandria University is not responsible for this action, you will lose your data forever and won't be able to restore it again.",
    String desc2 = "Do you want to proceed ?",
    DialogType type = DialogType.warning,
    bool hasDesc2 = true,
    Color bgColor = const Color.fromARGB(255, 216, 229, 239),
    Color leftBtnColor = Colors.green,
    Color rightBtnColor = Colors.red,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      dialogBackgroundColor: bgColor,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                fontWeight: FontWeight.w900,
                fontSize: 23,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            Column(
              crossAxisAlignment: crossAxis,
              children: [
                Text(
                  desc1,
                  style: TextStyle(
                    fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (hasDesc2 == true)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                if (hasDesc2 == true)
                  Text(
                    desc2,
                    style: TextStyle(
                      fontFamily: lang == 'ar' ? 'arabic2' : 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: leftBtnColor,
                          borderRadius: BorderRadius.circular(21),
                          child: InkWell(
                            onTap: leftBtn,
                            borderRadius: BorderRadius.circular(21),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: leftBtnColor,
                                borderRadius: BorderRadius.circular(21),
                              ),
                              child: Center(
                                child: Text(
                                  leftBtnText,
                                  style: TextStyle(
                                    fontFamily:
                                        lang == 'ar' ? 'arabic2' : 'poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      Expanded(
                        child: Material(
                          color: rightBtnColor,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: rightBtn,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                child: Text(
                                  rightBtnText,
                                  style: TextStyle(
                                    fontFamily:
                                        lang == 'ar' ? 'arabic2' : 'poppins',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ).show();
  }

  changePassword({
    required String newPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    User user = await FirebaseAuth.instance.currentUser!;
    user.updatePassword(newPassword).then((_) {
      emit(ChangePasswordSuccessState());
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
      emit(ChangePasswordErrorState());
    });
  }

  // bool hasMore = false;
  // loadMorePosts(){
  //   emit(LoadMorePostsLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .where('showPost', isEqualTo: true)
  //       .orderBy('date', descending: true)
  //       .startAfterDocument(post[10])
  //       .limit(10)
  //       .get()
  //       .then((value) {
  //     for (var element in value.docs) {
  //       if (element.data()['isShared'] == false) {
  //         PostModel currentPost = PostModel.fromJson(element.data());
  //         currentPost.postId = element.id;
  //         post.add(currentPost);
  //         postsId.add(element.id);
  //         hasMore = true;
  //       } else {
  //         SharePostModel currentPost = SharePostModel.fromJson(element.data());
  //         currentPost.postId = element.id;
  //         post.add(currentPost);
  //         postsId.add(element.id);
  //         hasMore = true;
  //       }
  //
  //       if (value.docs.length < 10) {
  //         hasMore = false;
  //       }
  //     }
  //     emit(LoadMorePostsSuccessState());
  //   }).catchError((error) {
  //     emit(LoadMorePostsErrorState(error.toString()));
  //   });
  // }
}
