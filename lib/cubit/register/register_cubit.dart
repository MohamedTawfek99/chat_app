import 'package:bloc/bloc.dart';
import 'package:chat_app/cubit/register/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/component.dart';
import '../login_cubit/login_cubit.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
bool isLoading=false;
  createAccount(
      {required String email,
      required String password,
      required context}) async {
    isLoading=true;
    emit(CreateUserLoadingState());
    UserCredential? userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(CreateUserSuccessState());
      showSnackBar(context, 'The account has been created successfully');
      LoginCubit.get(context).login(email: email, password: password, context: context);
      emit(LoginWithNewUseState());
    }).catchError((e) {
      emit(CreateUserErrorState());
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      } else {
        showSnackBar(context, 'There is an Error.');
      }
    });
    isLoading=false;

  }

}
