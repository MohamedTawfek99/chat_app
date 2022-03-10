import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/constans.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatStates>{
  ChatCubit(): super(InitialChatState());
 static ChatCubit get(context)=>BlocProvider.of(context);
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessages);

  Future<void> addMessage({required String message}) {
  emit ( SendMessageLoadingState());
     return messages
        .add({
     'message':message,

    })
        .then((value) {  emit ( SendMessageSuccessState());})
        .catchError((error){  emit ( SendMessageErrorState());});
  }
}