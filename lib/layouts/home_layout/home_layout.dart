import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/modules/new_post/new_post_screen.dart';
import 'package:socialapp/shared/componant/componant.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<SocialCubit,SocialStates>
       (
        listener: (context,state)
        {
          if(state is SocialNewPostState)
            {
              navigateTo(context, NewPostScreen());
            }
        },
        builder: (context,state)
        {
          var cubit =SocialCubit.get(context);
          
          return  Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions:
              [
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),

              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap:(index)
              {
                cubit.changeBottomNav(index);
              },
              items:
              [
                BottomNavigationBarItem(
                  icon:Icon(IconBroken.Home,),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon:Icon(IconBroken.Chat,),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon:Icon(IconBroken.Paper_Upload,),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon:Icon(IconBroken.Location),
                  label: 'Location',
                ),
                BottomNavigationBarItem(
                  icon:Icon(IconBroken.Setting,),
                  label: 'Setting',

                ),
              ],
            ),
          );
        }
        );

  }
}
