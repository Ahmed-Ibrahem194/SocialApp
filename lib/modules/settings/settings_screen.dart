import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/modules/edit_profile/edit_profile_screen.dart';
import 'package:socialapp/shared/componant/componant.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var userModel = SocialCubit.get(context).userrModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                Container(
                  height: 210.0,
                  child:
                  Stack(
                      alignment:AlignmentDirectional.bottomCenter ,
                      children:
                      [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 160.0,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image : DecorationImage(
                                image: NetworkImage(
                                  '${userModel.cover}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 64.0,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage: NetworkImage('${userModel.image}'),
                          ),
                        ),
                      ]
                  ),
                ),
                SizedBox(
                  height: 5.0,),
                Text(
                  '${userModel.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 5.0,),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(
                  height: 5.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '53',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '180',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                '320',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              Text(
                                'Foloowings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),

                    ],
                  ),
                ),
                Row(
                  children:
                  [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        child: Text('Add Photos',
                        ),
                      ),

                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    OutlinedButton(
                        onPressed: ()
                        {
                          navigateTo(context, EditProfileScreen(),);
                        },
                        child: Icon(IconBroken.Edit,
                          size: 16.0,
                        ),
                    ),
                  ],
                ),

                Row(
                  children:
                  [
                    OutlinedButton(
                      child:(
                          Text(
                            'subscribe',
                          )
                      ),
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.subscribeToTopic('announcement');
                      },),
                    SizedBox(
                      width:20.0 ,
                    ),
                    OutlinedButton(
                      child:(
                          Text(
                            'unsubscribe',
                          )
                      ),
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                      },),
                  ],
                ),

              ],
            ),
          ),
        );
      },

    );

  }
}