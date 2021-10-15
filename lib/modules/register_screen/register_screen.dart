import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/layouts/home_layout/home_layout.dart';
import 'package:socialapp/shared/componant/componant.dart';

import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => SocialRegiterCubit(),
      child: BlocConsumer<SocialRegiterCubit,SocialRegisterStates>(
        listener: (context , state)
        {
          if(state is SocialCreatUserSuccessfulState)
            {
              navigateAndFinish(context,HomeLayout(),);
            }
        },
        builder: (context , state)
        {
          return  Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("RIGISTER",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Register now to communicate with friends",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (value)
                          {
                            if (value.isEmpty)
                            {
                              return "Enter your name";
                            }

                          },
                          labelText: "Name",
                          prefix: Icons.person,),

                        SizedBox(
                          height: 20.0,
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
                          suffix: SocialRegiterCubit.get(context).mySuffix,
                          isPassword: SocialRegiterCubit.get(context).isPasswordd,
                          suffixPressud:()
                          {
                            SocialRegiterCubit.get(context).suffixChange();
                          } ,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),

                        defultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (value)
                          {
                            if (value.isEmpty)
                            {
                              return "Enter your phone";
                            }

                          },
                          labelText: "Phone",
                          prefix: Icons.phone,),

                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                          condition:state is!SocialRegiterLoadingStates ,
                          builder:(context) =>  Container(
                            width: double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                if(formkey.currentState.validate())
                                {
                                  SocialRegiterCubit.get(context).userRegiter(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              child: Text("register",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
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
