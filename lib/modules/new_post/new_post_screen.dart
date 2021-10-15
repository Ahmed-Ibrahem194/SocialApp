import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
        var cubit = SocialCubit.get(context);
        UserModel userModel;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2,),
            ),
            title: Text('Creat Post',),
            actions:
            [
              TextButton(
                onPressed: ()
                {
                  var now = DateTime.now();

                  if(cubit.postImage == null)
                    {
                      cubit.creatPost(
                          dateTime:now.toString() ,
                          text: textController.text,);
                    }else
                      {
                        cubit.uploadPostImage(
                            dateTime: now.toString(),
                            text: textController.text ,);
                      }
                },
                child: Text(
                    'Post'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                if(state is SocialCreatPostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatPostLoadingState)
                SizedBox(
                height: 20.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/portrait-serious-frowning-male-with-blond-hair-wearing-grey-t-shirt-glasses-people-emotion-concept-touching-his-chin-thinks_295783-13851.jpg'),
                    ),
                    SizedBox(
                      width: 15.0,),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${'Ahmed Qaneshy'}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is in your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,),
                if(cubit.postImage != null)
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
                              borderRadius: BorderRadius.circular(4.0,),
                              image : DecorationImage(
                                image:
                              FileImage(cubit.postImage) ,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: CircleAvatar(

                            radius: 20.0,
                            child: Icon(
                              Icons.close,
                              size: 16.0,
                            ),
                          ),
                          onPressed: ()
                          {
                            cubit.removePostImage();
                          },
                        ),
                      ]
                  ),
                SizedBox(
                  height: 20.0,),
               Row(
                 children: [
                   Expanded(
                     child: TextButton(
                         onPressed: ()
                         {
                           cubit.getPostImage();
                         },
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children:
                           [
                             Icon(IconBroken.Image),
                             SizedBox(width: 5.0,),
                             Text('add photo',),
                           ],
                         ),
                     ),
                   ),
                   Expanded(
                     child: TextButton(
                       onPressed: (){},
                      child: Text('# tags',),
                     ),
                   ),
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
