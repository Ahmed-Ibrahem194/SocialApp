
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/shared/componant/componant.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController =  TextEditingController();
  var bioController =   TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
        {
          var userModel = SocialCubit.get(context).userrModel;
          var profileImage = SocialCubit.get(context).profileImage;
          var coverImage = SocialCubit.get(context).coverImage;

          nameController.text = userModel.name;
          bioController.text = userModel.bio;
          phoneController.text = userModel.phone;

         return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: ()
            {
              Navigator.pop(context);
            },
            icon: Icon(IconBroken.Arrow___Left_2,),
          ),
          title: Text(
            'Edit Profile',),
          titleSpacing: 5.0,
          actions:
          [
            TextButton(
              onPressed: ()
              {
                SocialCubit.get(context).updateUser(
                    name: nameController.text,
                    phone: phoneController.text,
                    bio: bioController.text,
                );
                Navigator.pop(context);
              },
              child: Text(
                'UBDATE',
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        ),
           body: Padding(
             padding: const EdgeInsets.all(8.0),
             child: SingleChildScrollView(
               child: Column(
                 children:
                 [
                   if(state is SocialUserUpdateLoadingState)
                   LinearProgressIndicator(),
                       SizedBox(
                            height: 10.0,
                             ),

                   Container(
                   height: 210.0,
                   child:
                   Stack(
                   alignment:AlignmentDirectional.bottomCenter ,
                   children:
                   [
                   Stack(
                   alignment: AlignmentDirectional.topEnd,
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
                   image:
                   coverImage == null? NetworkImage(
                                     '${userModel.cover}',
                                   ) : FileImage(coverImage),
                                   fit: BoxFit.cover,
                                 ),
                               ),
                                 ),
                             ),
                                IconButton(
                                  icon: CircleAvatar(

                                    radius: 20.0,
                                      child: Icon(
                                          IconBroken.Camera,
                                        size: 16.0,
                                    ),
                                    ),
                                   onPressed: ()
                                   {
                                     SocialCubit.get(context).getCoverImage();
                                   },
                                ),
                            ]
                           ),
                           Stack(
                             alignment: AlignmentDirectional.bottomEnd,
                             children:
                             [
                               CircleAvatar(
                               radius: 64.0,
                               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                               child: CircleAvatar(
                                 radius: 60.0,
                                 backgroundImage: profileImage == null? NetworkImage(''
                                     '${userModel.image}') : FileImage(profileImage),
                               ),
                             ),
                               IconButton(
                                 icon: CircleAvatar(

                                   radius: 20.0,
                                   child: Icon(
                                     IconBroken.Camera,
                                     size: 16.0,
                                   ),
                                 ),
                                 onPressed: ()
                                 {
                                   SocialCubit.get(context).getProfileImage();
                                 },
                               ),
                            ]
                           ),
                         ]

                     ),
                   ),
                   SizedBox(
                     height: 20.0,),

                   if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                   Row(
                     children:
                     [
                       if(SocialCubit.get(context).profileImage != null)
                       Expanded(
                         child: Column(
                           children: [
                             defaultButton(
                                 function: ()
                                 {
                                   SocialCubit.get(context).uploadProfileImage(
                                       name: nameController.text,
                                       phone: phoneController.text,
                                       bio: bioController.text);

                                 },
                                 text: 'upload profile',
                             ),
                             if(state is SocialUserUpdateLoadingState)
                             SizedBox(
                               height: 5.0,),
                             if(state is SocialUserUpdateLoadingState)
                             LinearProgressIndicator(),

                           ],
                         ),
                       ),
                       SizedBox(
                      width: 5.0
                    ),

                    if(SocialCubit.get(context).coverImage != null)
                       Expanded(
                         child: Column(
                           children: [
                             defaultButton(
                               function: ()
                               {
                                 SocialCubit.get(context).uploadCoverImage(
                                     name: nameController.text,
                                     phone: phoneController.text,
                                     bio: bioController.text);
                               },
                               text: 'upload cover',
                             ),
                             if(state is SocialUserUpdateLoadingState)
                             SizedBox(
                               height: 5.0,),
                             if(state is SocialUserUpdateLoadingState)
                             LinearProgressIndicator(),
                           ],
                         ),
                       ),
                     ],
                   ),

                   if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage != null )
                   SizedBox(
                   height: 20.0,),

                   defultFormField(
                     controller: nameController,
                       type: TextInputType.text,
                       validate: (String value)
                       {
                         if(value.isEmpty)
                         {
                           return 'Enter Your Name' ;
                         }
                       },
                       labelText: 'Name',
                       prefix: IconBroken.User,
                   ),

                   SizedBox(
                     height: 15.0,),
                   defultFormField(
                     controller: bioController,
                     type: TextInputType.text,
                     validate: (String value)
                     {
                       if(value.isEmpty)
                       {
                         return 'Enter Your bio' ;
                       }
                     },
                     labelText: ' Bio ...',
                     prefix: IconBroken.Info_Circle,
                   ),

                   SizedBox(
                     height: 15.0,),
                   defultFormField(
                     controller:phoneController,
                     type: TextInputType.phone,
                     validate: (String value)
                     {
                       if(value.isEmpty)
                       {
                         return 'Enter Your Phone' ;
                       }
                     },
                     labelText: 'Phone',
                     prefix: IconBroken.Call,
                   ),
                 ],
               ),
             ),
           ),
      );
        },

    );
  }
}
