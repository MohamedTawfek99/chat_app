import 'package:chat_app/modules/register__screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
 import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_states.dart';
import '../shared/component/component.dart';
import '../shared/component/constans.dart';
import '../shared/network/local/cash_helper.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool obscure = true;
  bool isLoading=false;
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {

          if(state is LoginSuccessState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>  ChatScreen()), (route) => false);

          }


        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall:isLoading ,
          child: Scaffold(
            appBar: AppBar(),
                body: Padding(
                 padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Form(
                        key: formKey,
                        child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('LOGIN',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.black)),
                            const SizedBox(height: 25.0),
                            Text('Login To Chat With Our Friends!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                            const SizedBox(height: 40.0),
                            defaultTextField(

                                controller: emailController,
                                hint: 'Email',
                                prefix: Icons.email),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              validator: (value){
                                // if(value!.isEmpty){
                                //   return 'This Field must not be null';
                                //
                                // }
                                if(value!.length<6){
                                  return 'Password must be at least 6 characters';

                                }

                                return null;
                              },
                              obscureText: obscure,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  border: OutlineInputBorder(),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(obscure
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                  )),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                                height: 45.0,
                                width: double.infinity,
                                color: defaultColor,
                                child: MaterialButton(
                                  onPressed: () {

                                    if(formKey.currentState!.validate()){
                                      print(passwordController.text);
                                      isLoading=true;
                                      LoginCubit.get(context).login(email: emailController.text, password: passwordController.text, context: context
                                      ).then((value) {
                                        isLoading=false;

                                      });

                                    }




                                  },
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(height: 25.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                ),
                                const SizedBox(width: 2.0),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()));
                                  },
                                  child: const Text(
                                    'REGISTER',
                                    style: TextStyle(fontSize: 20.0,
                                    fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        ));
  }
}
