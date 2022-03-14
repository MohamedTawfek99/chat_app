import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../shared/component/component.dart';
import '../shared/component/constans.dart';
import '../shared/network/local/cash_helper.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is LoginWithNewUseState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>  ChatScreen()), (route) => false);

          }
        },
        builder: (context, state) => ModalProgressHUD(
          inAsyncCall: RegisterCubit.get(context).isLoading,
       color: Colors.grey.withOpacity(0.5),


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
                            Text('REGISTER',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(color: Colors.white)),
                            const SizedBox(height: 25.0),
                            Text('Register To Chat With Our Friends!',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                            const SizedBox(height: 40.0),
                            // defaultTextField(
                            //     controller: nameController,
                            //     hint: 'Name',
                            //     prefix: Icons.person),
                            const SizedBox(height: 20.0),
                            defaultTextField(

                                controller: emailController,
                                hint: 'Email',

                                prefix: Icons.email),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              validator: (value) {
                                if(value!.length<6){
                                  return 'Password must be at least 6 characters';

                                }
                                return null;
                              },
                              obscureText: obscure,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: defaultColor),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: defaultColor),
                                      borderRadius: BorderRadius.circular(20)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: defaultColor),
                                      borderRadius: BorderRadius.circular(20)),
                                  prefixIcon: const Icon(Icons.lock,color:defaultColor ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        obscure
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off,color:defaultColor ),
                                    onPressed: () {
                                      setState(() {
                                        obscure = !obscure;
                                      });
                                    },
                                  )),
                            ),
                            const SizedBox(height: 20.0),

                            // defaultTextField(
                            //     controller: phoneController,
                            //     hint: 'Phone',
                            //      type: TextInputType.phone,
                            //      prefix: Icons.phone),
                            const SizedBox(height: 20.0),
                   Container(
                          height: 45.0,
                          width: double.infinity,
                          color: defaultColor,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                print(passwordController.text);

                                RegisterCubit.get(context).createAccount(
                                  context:context ,
                                    email: emailController.text,
                                    password: passwordController.text);
                               }
                             },
                            child:   Text(
                              'REGISTER',
                              style: TextStyle(
                                  fontSize: 20.0, color: HexColor('192734')),
                            ),
                          )),


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
