import 'package:citame/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //Enivar
  Future<void> sendMessages(String id, String message) async {
    final String currentUserId = auth.currentUser!.uid;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        receiverId: id,
        message: message,
        timestamp: timestamp);

    List<String> ids = [currentUserId, id];
    ids.sort();
    String chatRoomId = ids.join("_");

    await db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String id, String otherId) {
    List<String> ids = [id, otherId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
