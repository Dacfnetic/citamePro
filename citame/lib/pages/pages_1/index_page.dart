import 'package:citame/Widgets/chat.dart';
import 'package:citame/Widgets/chatBottom.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: EdgeInsets.only(top: 2),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 8.0, // Ajusta la elevación según tus preferencias
              shadowColor: Colors.black,
              // Ajusta el color de la sombra según tus preferencias
              backgroundColor: Color.fromRGBO(243, 226, 226, 0.698),
              title: Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black, // Color del borde
                          width: 2.0, // Ancho del borde
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 22.0,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text("Jorge damian"),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
          children: [
            ChatSample(),
          ],
        ),
        bottomSheet: ChatBottom(),
      ),
    );
  }
}
