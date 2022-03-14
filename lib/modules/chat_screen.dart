import 'package:chat_app/shared/component/constans.dart';
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
        future: ChatCubit.get(context).messages.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ChatCubit.get(context).putMessages(snapshot.data!.docs);
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Chat',
                    style: TextStyle(
                      color: defaultColor,
                      fontSize: 30.0,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => buildSendedChatBubble(
                                text:
                                    '${ChatCubit.get(context).messagesList[index].message}'),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10.0,
                                ),
                            itemCount:
                                ChatCubit.get(context).messagesList.length),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          onFieldSubmitted: (value) {
                            if (messageController.text.isNotEmpty) {
                              setState(() {
                                ChatCubit.get(context).addMessage(
                                    message: messageController.text);
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
                              hintStyle: TextStyle(color: defaultColor),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: defaultColor),
                                  borderRadius: BorderRadius.circular(20)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: defaultColor),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: defaultColor),
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: const Icon(
                                Icons.message,
                                color: defaultColor,
                              ),
                              suffixIcon: messageController.text.isEmpty
                                  ? Icon(
                                      Icons.send,
                                      color: Colors.grey[300],
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.send,
                                        color: defaultColor,
                                      ),
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
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
