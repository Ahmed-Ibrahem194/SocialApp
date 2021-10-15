import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defultFormField({
  @required TextEditingController controller ,
  @required TextInputType type ,
  Function onSubmit,
  Function onChange,
  @required  Function validate,
  @required String labelText ,
  @required IconData prefix,
  IconData suffix,
  bool isPassword = false,
  Function suffixPressud,
  Function onTap ,


}) {
  return TextFormField(
    controller:controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted:(s){onSubmit;} ,
    onChanged:(s){onChange;} ,
    onTap:(){onTap;} ,
    decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      suffixIcon: IconButton(onPressed:suffixPressud,
          icon: Icon(suffix)),
      labelText: labelText,
      border: OutlineInputBorder(),
    ),
    validator: validate,
  );
}

void showToast({
  @required String msg,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg:msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chosoToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0 ,
    );

enum ToastStates {SUCCESS, ERROR , WARNING}

Color chosoToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.SUCCESS: color = Colors.green;
    break;
    case ToastStates.ERROR: color = Colors.red;
    break;
    case ToastStates.WARNING: color= Colors.amber;
    break;
  }
  return color;
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildListProduct( model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children:
      [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(model.image),
              height: 120.0,
              width: 120.0,
            ),
            if(model.discount != 0)
              Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                  child: Text("DISCOUNT",
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  if(model.discount != 0)
                    Text(
                      model.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: ()
                    {
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      child: Icon(
                        Icons.favorite_border,
                        color:Colors.white,
                        size: 12.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

