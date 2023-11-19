import 'package:citame/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  final String displayName;
  final String receiverUserId;
  const ChatPage(
      {super.key, required this.displayName, required this.receiverUserId});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    final ChatService chatService = ChatService();
    final FirebaseAuth auth = FirebaseAuth.instance;
    void sendMessage() async {
      if (messageController.text.isNotEmpty) {
        await chatService.sendMessages(
            widget.receiverUserId, messageController.text);
        messageController.clear();
      }
    }

    Widget messageInput() {
      return Container(
        margin: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Escribí algo prro',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(5),
                ),
              ),
            ),
            IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward))
          ],
        ),
      );
    }

    Widget message(DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      var alignment = (data['senderId'] == auth.currentUser!.uid)
          ? Alignment.centerRight
          : Alignment.centerLeft;
      var textAlignment = (data['senderId'] == auth.currentUser!.uid)
          ? TextAlign.left
          : TextAlign.right;
      var colores = (data['senderId'] == auth.currentUser!.uid)
          ? Colors.amber
          : Colors.purple;

      return Container(
        alignment: alignment,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colores,
            ),
            child: Text(
              data['message'],
              textAlign: textAlignment,
            ),
          ),
        ),
      );
    }

    Widget listaDeMensajes() {
      return StreamBuilder(
        stream: chatService.getMessages(
            widget.receiverUserId, auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error ${snapshot.error.toString()}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          }
          return ListView(
            children: snapshot.data!.docs
                .map((document) => message(document))
                .toList(),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.displayName,
          style: GoogleFonts.plusJakartaSans(
            color: Color(0xff14181b),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(240, 240, 240, 1),
          child: Column(
            children: [
              Expanded(child: listaDeMensajes()),
              messageInput(),
            ],
          ),
          //ElevatedButton(onPressed: () {}, child: Text('Diego')),
        ),
      ),
    );
  }
}
