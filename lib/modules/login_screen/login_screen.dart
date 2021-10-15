
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/home_layout/home_layout.dart';
import 'package:socialapp/modules/register_screen/register_screen.dart';
import 'package:socialapp/network/local/cash_helper.dart';
import 'package:socialapp/shared/componant/componant.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState> () ;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit() ,
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
              {
               showToast(msg: state.error, state:ToastStates.ERROR );
              };

          if(state is SocialLoginSuccessfulStates)
            {
              CashHelper.saveData(
                  key: 'uId',
                  value: state.uId,
               ).then((value)
              {
                navigateAndFinish(context, HomeLayout(),);
              });
            }
        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("LOGIN",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Login now to communicate with friends",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value)
                          {
                            if (value.isEmpty)
                            {
                              return "Enter your email";
                            }

                          },
                          labelText: "Email Adress",
                          prefix: Icons.email_outlined,),

                        SizedBox(
                          height: 20.0,
                        ),

                        defultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value)
                          {
                            if (value.isEmpty)
                            {
                              return "Enter your password";
                            }

                          },
                          labelText:  "Password",
                          prefix: Icons.lock_open_outlined,
                          suffix: SocialLoginCubit.get(context).mySuffix,
                          isPassword: SocialLoginCubit.get(context).iisPassword,
                          suffixPressud:()
                          {
                            SocialLoginCubit.get(context).suffixChange();
                          } ,
                        ),


                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition:state is! SocialLoginLoadingStates ,
                          builder:(context) =>  Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(formKey.currentState.validate())
                                {
                                  SocialLoginCubit.get(context).userLogin
                                    (email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text("LOGIN",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text("Dont have an account?",),
                            TextButton(
                              onPressed: ()
                              {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text("Register now",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },

      ),
    );
  }
}
