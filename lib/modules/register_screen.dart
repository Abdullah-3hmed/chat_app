import 'package:chat_app/components/components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/constants.dart';
import 'chat_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static String id = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isLoading = false;

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
                          'Register ',
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
                                .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                            // ignore: use_build_context_synchronously
                            showFlutterToast(
                              message: 'Login Succeed',
                              color: Colors.green,
                            );
                            Navigator.pushNamed(context, ChatScreen.id,
                                arguments: emailController.text);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'weak-password') {
                              showFlutterToast(
                                message: 'Weak Password',
                                color: Colors.grey,
                              );
                            } else if (ex.code == 'email-already-in-use') {
                              showFlutterToast(
                                message: 'Email Already In Use',
                                color: Colors.red,
                              );
                            }
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'REGISTER',
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have account ?',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '  Login',
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
