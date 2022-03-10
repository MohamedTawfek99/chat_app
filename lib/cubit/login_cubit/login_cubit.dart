import 'package:chat_app/cubit/login_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/component.dart';
import '../../shared/network/local/cash_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(InitialLoginState());
static  LoginCubit get (context)=>BlocProvider.of(context);

  Future<UserCredential?> login({required String email,required String password,required context})async{
  emit(LoginLoadingState());
  return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password:password
  ).then((value)async {
    emit(LoginSuccessState());
  await  CashHelper.setData(key: 'isLogin', value: true);

  }).catchError((e){

    emit(LoginErrorState());
    if (e.code == 'user-not-found') {
      showSnackBar(context,'user not found');
    } else if (e.code == 'wrong-password') {
       showSnackBar(context,'Wrong password for that user.');

    }
    else{
      showSnackBar(context,'Error');

    }

  });



}


}