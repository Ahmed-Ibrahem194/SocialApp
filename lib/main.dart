import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/home_layout/home_layout.dart';
import 'package:socialapp/shared/componant/componant.dart';
import 'package:socialapp/shared/constants/constants.dart';
import 'package:socialapp/shared/styles/themes.dart';
import 'cubit/cubit.dart';
import 'modules/login_screen/login_screen.dart';
import 'network/local/cash_helper.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{

}

void main() async{

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 var token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event)
  {
    showToast(msg: 'on message', state: ToastStates.SUCCESS,);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event)
    {
      showToast(msg: 'on opened message', state: ToastStates.SUCCESS,);
    });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  await CashHelper.init();

  uId = CashHelper.getData(key: 'uId');

Widget widget;

 if(uId !=  null)
  {
    widget = HomeLayout();
  }else
    {
      widget = LoginScreen();
    }


  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
            create: (BuildContext context) => SocialCubit()..getUserData()..getPost(),
        ),
      ],
      child: MaterialApp(
        home:startWidget,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
      ),
    );
  }
}
