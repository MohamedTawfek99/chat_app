import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
   style: TextStyle(color: Colors.white),
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
        hintStyle: TextStyle(color: defaultColor),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: defaultColor),
            borderRadius: BorderRadius.circular(20)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: defaultColor),
            borderRadius: BorderRadius.circular(20)),
        prefixIcon: Icon(prefix,color:defaultColor ,)

    ),


  );


}
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context, text) {
 return ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(text,style: TextStyle(color: HexColor('192734')),),
   backgroundColor: defaultColor,
  ),
 );
}

Bubble buildSendedChatBubble({required String text}) {
 return Bubble(
  margin: BubbleEdges.only(top: 10),
  alignment: Alignment.topLeft,
  nip: BubbleNip.leftTop,
  color: defaultColor,
  child: Text(text, textAlign: TextAlign.right),
 );
 // return Align(
 //  alignment: Alignment.centerLeft,
 //
 //   child: Container(
 //
 //    padding: EdgeInsetsDirectional.only(
 //        bottom: 15.0,
 //        end: 10.0,
 //        start: 10.0,
 //        top: 15.0),
 //    child: Text(
 //    text,
 //     style: TextStyle(
 //      fontSize: 20.0,
 //     ),
 //    ),
 //    decoration: BoxDecoration(
 //     shape: BoxShape.rectangle,
 //     color:defaultColor ,
 //     borderRadius: BorderRadius.only(
 //      topRight: Radius.circular(20.0),
 //      bottomRight: Radius.circular(20.0),
 //     //  // bottomLeft:Radius.circular(20.0) ,
 //     topLeft: Radius.circular(20.0),
 //     ),
 //    ),
 //   ),
 // );
}
Bubble buildReceivedChatBubble({required String text}) {
 return Bubble(
  margin: BubbleEdges.only(top: 10),
  alignment: Alignment.topRight,
  nip: BubbleNip.rightTop,
  child: Text(text),
 );
 // return Align(
 //  alignment: Alignment.centerRight,
 //
 //  child: Container(
 //
 //   padding:  EdgeInsetsDirectional.only(
 //       bottom: 10.0,end: 10.0,start: 15.0,top: 10.0),
 //   child: Text(
 //    text,
 //    style: TextStyle(
 //     fontSize: 25.0,
 //    ),
 //   ),
 //   decoration: BoxDecoration(
 //    color: Colors.blueGrey,
 //    borderRadius: BorderRadius.only(
 //     topRight: Radius.circular(50.0),
 //     bottomLeft: Radius.circular(50.0),
 //
 //     topLeft: Radius.circular(50.0),
 //    ),
 //   ),
 //  ),
 // );
}


