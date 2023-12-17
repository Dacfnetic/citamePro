import 'package:citame/utils/websocket.dart';

class ChatService {
  //  Maybe messages array should just live in the service? decide on design
  late Websocket websocket;

  ChatService() {
    websocket = Websocket();
  }

  void startService(void Function(dynamic message) onMessageReceived) {
    //  Error handling, for now it will crash and burn
    websocket.listenForMessages(onMessageReceived);
  }

  void sendMessage(String message) {
    websocket.sendMessage(message);
  }
}
