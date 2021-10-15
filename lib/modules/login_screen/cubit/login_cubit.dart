
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  bool iisPassword = true;
  IconData mySuffix = Icons.visibility;
  static SocialLoginCubit get(context) => BlocProvider.of(context);


  SocialLoginCubit() : super(InitialLoginStates());

  void suffixChange()
  {
    iisPassword =! iisPassword ;
    if(iisPassword){mySuffix =Icons.visibility; }
    else mySuffix = Icons.visibility_off;

    emit(SocialLoginSuffixChangeStates());
  }


  void userLogin({
    @required String email ,
    @required String password ,
  })
  {
    emit(SocialLoginLoadingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
       ).then((value)
          {
          emit(SocialLoginSuccessfulStates(value.user.uid));
          })
        .catchError((error)
       {
       emit(SocialLoginErrorState(error.toString()));
      });
  }
}