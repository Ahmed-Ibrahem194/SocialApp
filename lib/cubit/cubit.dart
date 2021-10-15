
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/message_model.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chats/chat_screen.dart';
import 'package:socialapp/modules/feeds/feeds_screen.dart';
import 'package:socialapp/modules/new_post/new_post_screen.dart';
import 'package:socialapp/modules/settings/settings_screen.dart';
import 'package:socialapp/modules/users/users_screen.dart';
import 'package:socialapp/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntioalState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel userrModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userrModel = UserModel.fromJson(value.data());

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }


  int currentIndex = 0;

  List<Widget> screens =
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  void changeBottomNav(int index)
  {
    if(index == 1)
      getAllUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      emit(SocialChangeBottomNavState());
      currentIndex = index;
    }
  }

  List<String> titles =
  [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  File profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path,);
      emit(SocialProfileImagePickedSuccessState());
    }
    else {
      emit(SocialProfileImagePickedErrorState());
    }
  }


  File coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path,);
      emit(SocialCoverImagePickedSuccessState());
    }
    else {
      emit(SocialCoverImagePickedErrorState());
    }
  }


  //Profile Image

  void uploadProfileImage({
    @required String name,
    @required String phone,
    @required String bio,}) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage.path)
        .pathSegments
        .last}')
        .putFile(profileImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      });
    });
  }


  //Cover

  void uploadCoverImage({
    @required String name,
    @required String phone,
    @required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(coverImage.path)
        .pathSegments
        .last}')
        .putFile(coverImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      });
    });
  }


  //Users

  void updateUser({
    @required String name,
    @required String phone,
    @required String bio,
    String cover,
    String image,
  }) {
    UserModel userModel = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      isEmailVerfied: false,
      cover: cover ?? userrModel.cover,
      image: image ?? userrModel.image,
      email: userrModel.email,
      uId: userrModel.uId,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(userModel.uId)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    });
  }


//Posts

  File postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      postImage = File(pickedFile.path,);
      emit(SocialPostImagePickedSuccessState());
    }
    else {
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }


  void uploadPostImage({
    String dateTime,
    String text,
  }) {
    emit(SocialCreatPostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri
        .file(postImage.path)
        .pathSegments
        .last}')
        .putFile(postImage)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        creatPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      });
    });
  }


  void creatPost({
    @required String dateTime,
    @required String text,
    String postImage,
  }) {
    emit(SocialCreatPostLoadingState());
    PostModel postModel = PostModel(
      image: userrModel.image,
      name: userrModel.name,
      uId: userrModel.uId,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatPostSuccessState());
    });
  }


  List <PostModel> posts = [];

  List <String> postsId = [];

  List <int> likes = [];

  List <int> comments = [];

  void getPost() {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference
            .collection('likes',)
            .get()
            .then((value) {
          likes.add(value.docs.length);
        });
      });

      value.docs.forEach((element) {
        element.reference
            .collection('comments',)
            .get()
            .then((value) {
          comments.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        });
        emit(SocialGetPostsSuccessState());
      });
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userrModel.uId)
        .set({'like': true,})
        .then((value) {
      emit(SocialLikePostsSuccessState());
    });
  }

  void commentPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(userrModel.uId)
        .set({'comment': true,})
        .then((value) {
      emit(SocialCommentPostsSuccessState());
    });
  }


  List<UserModel>  users ;

  void getAllUsers()
  {
   users = [];
    emit(SocialGetAllUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
       {
        value.docs.forEach((element)
        {
        // if(element.data()['uId'] != userrModel.uId)
        users.add(UserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccessState());
      });
  }

  void sendMessage({
    @required String reciverId,
    @required String dateTime,
    @required String text,
})
{
  MessageModel model = MessageModel(
    text: text,
    dateTime: dateTime,
    reciverId: reciverId,
    senderId: userrModel.uId,
  );

  FirebaseFirestore.instance
      .collection('users')
      .doc(userrModel.uId)
      .collection('chats')
      .doc(reciverId)
      .collection('messages')
      .add(model.toMap())
      .then((value)
       {
          emit(SocialSendMessageSuccessState());
       });

  FirebaseFirestore.instance
      .collection('users')
      .doc(reciverId)
      .collection('chats')
      .doc(userrModel.uId)
      .collection('messages')
      .add(model.toMap())
      .then((value)
  {
    emit(SocialGetMessageSuccessState());
  });
}

List <MessageModel> messages = [];
  
  void getMessages({
    @required String reciverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userrModel.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages = [];
      event.docs.forEach((element)
      {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }
}