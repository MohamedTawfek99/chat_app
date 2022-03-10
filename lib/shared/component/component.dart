import 'package:flutter/material.dart';

import 'constans.dart';

Widget defaultTextField(
{
 required TextEditingController controller,
  TextInputType type=TextInputType.text,
  required String hint,
  required IconData prefix,
 }
    ){
  return   TextFormField(
   validator: (value){
    if(value!.isEmpty){
     return 'This Field must not be null';

    }
    return null;
   },
    controller: controller,
    keyboardType:type ,
    decoration: InputDecoration(
        hintText: hint,

        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix)

    ),


  );


}
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context, text) {
 return ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(text),
   backgroundColor: defaultColor,
  ),
 );
}

Align buildSendedChatBubble({required String text}) {
 return Align(
  alignment: Alignment.centerLeft,

   child: Container(
    padding: EdgeInsetsDirectional.only(
        bottom: 10.0,
        end: 10.0,
        start: 15.0,
        top: 10.0),
    child: Text(
    text,
     style: TextStyle(
      fontSize: 25.0,
     ),
    ),
    decoration: BoxDecoration(
     color:defaultColor ,
     borderRadius: BorderRadius.only(
      topRight: Radius.circular(50.0),
      bottomRight: Radius.circular(50.0),
      topLeft: Radius.circular(50.0),
     ),
    ),
   ),
 );
}
Align buildReceivedChatBubble({required String text}) {
 return Align(
  alignment: Alignment.centerRight,

  child: Container(
   padding:  EdgeInsetsDirectional.only(
       bottom: 10.0,end: 10.0,start: 15.0,top: 10.0),
   child: Text(
    text,
    style: TextStyle(
     fontSize: 25.0,
    ),
   ),
   decoration: BoxDecoration(
    color: Colors.grey[300],
    borderRadius: BorderRadius.only(
     topRight: Radius.circular(50.0),
     bottomLeft: Radius.circular(50.0),

     topLeft: Radius.circular(50.0),
    ),
   ),
  ),
 );
}


