import 'package:chat_app/modules/chat_screen.dart';
import 'package:chat_app/shared/network/local/cash_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/bloc_observer.dart';
 import 'cubit/chat_cubit/chat_cubit.dart';
import 'cubit/login_cubit/login_cubit.dart';
import 'cubit/register/register_cubit.dart';
import 'firebase_options.dart';
import 'modules/login_screen.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await CashHelper.init();
 bool? isLogin=await CashHelper.getData(key: 'isLogin') ;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(isLogin: isLogin,));

}

class MyApp extends StatelessWidget {
  bool?isLogin;
  MyApp({  this.isLogin}) ;
   @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) =>RegisterCubit(),

        ),

        BlocProvider(
          create: (BuildContext context) =>ChatCubit(),

        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Font',
          appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
            elevation: 0.0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,

              statusBarIconBrightness:Brightness.dark
            ),
            color: Colors.white


          ),
          scaffoldBackgroundColor: Colors.white

        ),
        home: isLogin==true?ChatScreen() : LoginScreen(),
      ),

    );
  }
}