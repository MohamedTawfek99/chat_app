import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/bloc_observer.dart';
 import 'cubit/chat_cubit/chat_cubit.dart';
import 'cubit/login_cubit/login_cubit.dart';
import 'cubit/register/register_cubit.dart';
import 'modules/login_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
        home:   LoginScreen(),
      ),

    );
  }
}