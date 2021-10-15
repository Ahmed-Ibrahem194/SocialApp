import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/register_screen/cubit/register_states.dart';

class SocialRegiterCubit extends Cubit<SocialRegisterStates> {

  bool isPasswordd = true;
  IconData mySuffix = Icons.visibility;

  SocialRegiterCubit() :super(SocialRegiterInitialStates());

  static SocialRegiterCubit get(context) => BlocProvider.of(context);

  void suffixChange()
  {
    isPasswordd =! isPasswordd ;
    if(isPasswordd){mySuffix =Icons.visibility; }
    else mySuffix = Icons.visibility_off;
    emit(SocialRegisterSuffixChangeStates());
  }

  void userRegiter({
    @required String name ,
    @required String email ,
    @required String password ,
    @required String phone ,

  }) {
    emit(SocialRegiterLoadingStates());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value)
    {
      userCreate(
        uId: value.user.uid,
        name: name,
        email: email,
        phone: phone,
      );
    }).catchError((error)
    {
      emit(SocialRegisterErrorStates(error.toString()));
    });
  }


  void userCreate({
    @required String name ,
    @required String email ,
    @required String phone ,
    @required String uId ,
})
  {
    UserModel userModel = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio',
      isEmailVerfied: false,
      image: 'https://console.firebase.google.com/project/socialapp-e8a4a/authentication/users',
      cover: 'https://console.firebase.google.com/project/socialapp-e8a4a/authentication/users',
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
         .then((value)
    {
      emit(SocialCreatUserSuccessfulState());
    }).catchError((error)
    {
      emit(SocialCreatUserErrorStates(error.toString()));
    });
  }
}