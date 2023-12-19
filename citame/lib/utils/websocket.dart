import 'package:citame/services/api_service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'json.dart';

class Websocket {
  late IOWebSocketChannel channel;

  Websocket() {
    channel = IOWebSocketChannel.connect('ws://${API.server}');
  }

  void disconnectFromServer() {
    //  error handling, for now it will crash and burn
    channel.sink.close(status.goingAway);
  }

  void listenForMessages(void Function(dynamic message) onMessageReceived) {
    //  error handling, for now it will crash and burn
    channel.stream.listen(onMessageReceived);
    print('now listening for messages');
  }

  void sendMessage(String message) {
    print('sending a message: $message');
    //  error handling, for now it will crash and burn
    channel.sink.add(Json.encodeMessageJSON(message));
  }
}
