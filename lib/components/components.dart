import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

Widget defaultTextField({
  dynamic controller,
  String? hintText,
  required String label,
  required Widget prefixIcon,
  bool isPassword = false,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    obscureText: isPassword,
    decoration: InputDecoration(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      contentPadding: const EdgeInsets.all(
        24.0,
      ),
    ),
    validator: (data) {
      if (data!.isEmpty) {
        return ' field required';
      }
      return null;
    },
  );
}

Widget defaultButton({VoidCallback? onPressed, required String text}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    width: double.infinity,
    height: 50,
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(text),
    ),
  );
}

Future<bool?> showFlutterToast(
    {required String message, required Color color}) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 20.0,
  );
}

Widget chatBubble({required Message message}) => Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
            topLeft: Radius.circular(32.0),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget chatBubbleForFriend({required Message message}) => Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff006d84),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
            topLeft: Radius.circular(32.0),
          ),
        ),
        child: Text(
          message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
