import 'package:chat_app/components/components.dart';
import 'package:chat_app/modules/chat_screen.dart';
import 'package:chat_app/modules/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isLoading = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/scholar.png'),
                    ),
                    Text(
                      'Scholar Chat',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 70.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Login ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    defaultTextField(
                      prefixIcon: const Icon(Icons.email_outlined),
                      controller: emailController,
                      hintText: 'Enter Email Address',
                      label: 'Email',
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultTextField(
                      isPassword: isPassword,
                      suffixIcon: isPassword
                          ? IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                            ),
                      prefixIcon: const Icon(Icons.lock_outline),
                      controller: passwordController,
                      hintText: 'Enter Password',
                      label: 'Password',
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    defaultButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            showFlutterToast(
                              message: 'Login Succeeded',
                              color: Colors.green,
                            );
                            Navigator.pushNamed(context, ChatScreen.id,
                                arguments: emailController.text);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              showFlutterToast(
                                message: 'No user found for that email',
                                color: Colors.red,
                              );
                            } else if (ex.code == 'wrong-password') {
                              showFlutterToast(
                                message: 'Wrong Password',
                                color: Colors.red,
                              );
                            }
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'LOGIN',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'don\'t have an account ?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: const Text(
                            '  Register',
                            style: TextStyle(
                              color: Color(0xffC7EDE6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
