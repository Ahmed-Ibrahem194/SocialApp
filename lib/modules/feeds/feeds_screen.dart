import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/cubit/cubit.dart';
import 'package:socialapp/cubit/states.dart';
import 'package:socialapp/models/post_model.dart';
import 'package:socialapp/shared/styles/colors.dart';
import 'package:socialapp/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:  (context,state)
        {
          var cubit =  SocialCubit.get(context);

          return ConditionalBuilder(
            condition: cubit.posts.length > 0 && cubit.userrModel != null ,
            builder: (context) =>  SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children:
                [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8.0,),
                    elevation: 10.0,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children:
                        [
                          Image(
                            image: NetworkImage('https://image.freepik.com/free-photo/teenage-guy-thinking-man-with-blond-hair-wearing-grey-t-shirt-glasses-people-concept-touching-his-chin-concentrating-watching-left-copy-space-isolated-grey-wall_295783-13835.jpg'),
                            fit:BoxFit.cover,
                            height: 200.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('communicate with friends',
                              style:Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white),
                            ),
                          ),
                        ]
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index) => buildPostItem(cubit.posts[index],context , index),
                    separatorBuilder: (context,index) => SizedBox(height:10.0 ,),
                    itemCount:cubit.posts.length,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },

    );
  }



  Widget buildPostItem(PostModel model ,context , index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(horizontal: 8.0,),
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Row(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(Icons.check_circle,
                            color: defultColor,
                            size: 16.0,),
                        ],
                      ),
                      Text(
                        '${model.dateTime}',
                        style:Theme.of(context).textTheme.caption.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15.0,),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 15.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),

            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: Container(
            //     width: double.infinity,
            //     child: Wrap(
            //       children:
            //       [
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               height: 25.0,
            //               child: Text(
            //                 '#software_develoment',
            //                 style: Theme.of(context).textTheme.caption.copyWith(
            //                   color: defultColor,
            //                 ),
            //
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               height: 25.0,
            //               child: Text(
            //                 '#Flutter_develoment',
            //                 style: Theme.of(context).textTheme.caption.copyWith(
            //                   color: defultColor,
            //                 ),
            //
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               height: 25.0,
            //               child: Text(
            //                 '#mobile_develoment',
            //                 style: Theme.of(context).textTheme.caption.copyWith(
            //                   color: defultColor,
            //                 ),
            //
            //               ),
            //             ),
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsetsDirectional.only(end: 6.0),
            //           child: Container(
            //             height: 20.0,
            //             child: MaterialButton(
            //               onPressed: (){},
            //               minWidth: 1.0,
            //               padding: EdgeInsets.zero,
            //               height: 25.0,
            //               child: Text(
            //                 '#agile',
            //                 style: Theme.of(context).textTheme.caption.copyWith(
            //                   color: defultColor,
            //                 ),
            //
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            if(model.postImage != '')
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 15.0,
              ),
              child: Container(
                height: 160.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image : DecorationImage(
                    image: NetworkImage(
                      '${model.postImage}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(

                          children:
                          [
                            Icon(IconBroken.Heart,
                              size: 16.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,),
                            Text(
                              '${SocialCubit.get(context).likes[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                          [
                            Icon(IconBroken.Chat,
                              size: 16.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 5.0,),
                            Text(
                              '${SocialCubit.get(context).comments[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                      onTap: (){},
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10.0),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children:
                      [
                        CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userrModel.image}',),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'write a comment',
                          style:Theme.of(context).textTheme.caption.copyWith(
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    onTap: ()
                    {
                      SocialCubit.get(context).commentPost(SocialCubit.get(context).postsId[index]);
                    },
                  ),
                ),
                InkWell(
                  child: Row(

                    children:
                    [
                      Icon(IconBroken.Heart,
                        size: 16.0,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0,),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                    SocialCubit.get(context).likePost( SocialCubit.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ]
      ),
    ),

  );
}
