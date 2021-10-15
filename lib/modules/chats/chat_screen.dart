
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/user_model.dart';
import 'package:socialapp/modules/chat_details/chat_details_screen.dart';
import 'package:socialapp/shared/componant/componant.dart';

class ChatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener:(context , state){} ,
         builder:(context , state)
         {
           return ConditionalBuilder(
             condition:SocialCubit.get(context).users.length > 0 ,
             builder: (context) => ListView.separated(
                 physics: BouncingScrollPhysics(),
                 itemBuilder:(context, index) => buildChatItem(SocialCubit.get(context).users[index],context),
                 separatorBuilder:(context, index) => myDivider() ,
                 itemCount:SocialCubit.get(context).users.length),
            fallback: (context) => Center(child: CircularProgressIndicator()),
           );
         } ,
    );

  }

  Widget buildChatItem(UserModel model , context) => InkWell(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children:
        [
          CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage(
                  '${model.image}',
            ),
          ),
          SizedBox(
            width: 15.0,),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
  );
}