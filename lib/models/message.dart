import '../components/constants.dart';

class Message {
  final String message;
  final String id;

  Message({required this.message, required this.id});

  factory Message.fromJson({required jsonData}) {
    return Message(
      message: jsonData[kMessage],
      id: jsonData['id'],
    );
  }
}
