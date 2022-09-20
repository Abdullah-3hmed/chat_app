import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';
import '../components/constants.dart';
import '../models/message.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);
  static String id = 'chatScreen';
  var controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    CollectionReference messages =
        FirebaseFirestore.instance.collection(kMessagesCollections);
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.data!.docs[0]['message']);
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(
                Message.fromJson(jsonData: snapshot.data!.docs[i]),
              );
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: primaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 70.0,
                    ),
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50.0,
                    ),
                    const Text('Chat'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      physics: const BouncingScrollPhysics(),
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? chatBubble(
                                message: messageList[index],
                              )
                            : chatBubbleForFriend(message: messageList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      // onSubmitted: (data) {
                      //   messages.add(
                      //     {
                      //       kMessage: data,
                      //       kCreatedAt: DateTime.now(),
                      //       'id': email,
                      //     },
                      //   );
                      //   controller.clear();
                      //
                      // },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.0),
                          ),
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            messages.add(
                              {
                                kMessage: controller.text,
                                kCreatedAt: DateTime.now(),
                                'id': email,
                              },
                            );
                            controller.clear();
                            _controller.animateTo(
                              0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          icon: const Icon(Icons.send),
                        ),
                        hintText: 'Send Message',
                        contentPadding: const EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
