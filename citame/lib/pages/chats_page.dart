import 'package:citame/Widgets/profile_row.dart';
import 'package:citame/pages/business_registration_page.dart';
import 'package:citame/pages/chat_page.dart';
import 'package:citame/pages/signin_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class ChatsPage extends ConsumerWidget {
  const ChatsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
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
          child: chats(),
          //ElevatedButton(onPressed: () {}, child: Text('Diego')),
        ),
      ),
    );
  }
}

Widget chats() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance.collection('users').snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        print('inicia');
        print(snapshot.error);
        print('termina');
        return const Text('error');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Text('Cola');
      }
      return ListView(
        children: snapshot.data!.docs
            .map<Widget>((doc) => lista(doc, context))
            .toList(),
      );
    },
  );
}

Widget lista(DocumentSnapshot document, BuildContext context) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

  if (auth.currentUser!.email != data['email']) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverUserId: data['uid'],
                displayName: data['displayName'],
              ),
            ));
      },
      tileColor: Colors.amber,
      title: Text(data['displayName']),
    );
  }
  return Container();
}
