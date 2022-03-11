import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../cubit/chat_cubit/chat_cubit.dart';
import '../shared/component/component.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Object?>>(
     future:ChatCubit.get(context).messages.get(),

        builder: (context, snapshot) {
       if(snapshot.hasData) {
         ChatCubit.get(context).putMessages(snapshot.data!.docs);
         return Scaffold(
             appBar: AppBar(
               title: Text(
                 'Chat',
                 style: TextStyle(
                   color: Colors.black,
                   fontSize: 30.0,
                 ),
               ),
               centerTitle: true,
             ),
             body: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0),
               child: Column(
                 children: [
                   Expanded(
                     child: ListView.separated(
                     itemBuilder: (context,index)=>buildSendedChatBubble(text: '${ChatCubit.get(context).messagesList[index].message}'),
          separatorBuilder:(context,index)=> SizedBox(height: 10.0,),

          itemCount: ChatCubit.get(context).messagesList.length),
                     ),











                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 15.0),
                     child: TextFormField(
                       onFieldSubmitted: (value) {
                         if (messageController.text.isNotEmpty) {
                           setState(() {
                             ChatCubit.get(context)
                                 .addMessage(message: messageController.text);
                             messageController.clear();
                           });
                         }
                       },
                       validator: (value) {
                         if (value!.isEmpty) {
                           return 'This Field must not be null';
                         }
                         return null;
                       },
                       controller: messageController,
                       onChanged: (v) {
                         setState(() {});
                       },
                       decoration: InputDecoration(
                           hintText: 'Type Message',
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20)),
                           prefixIcon: const Icon(Icons.message),
                           suffixIcon: messageController.text.isEmpty
                               ? Icon(
                             Icons.send,
                             color: Colors.grey[300],
                           )
                               : IconButton(
                             icon: Icon(Icons.send),
                             onPressed: () {
                               setState(() {
                                 ChatCubit.get(context).addMessage(
                                     message: messageController.text);
                                 messageController.clear();
                               });
                             },
                           )),
                     ),
                   ),
                 ],
               ),
             ));
       }
       else {
         return Scaffold(
             body: Center(child: CircularProgressIndicator()));
       }
        }
    );
  }
}
