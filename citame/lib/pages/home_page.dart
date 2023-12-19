import 'package:citame/Widgets/bottom_bar.dart';
import 'package:citame/Widgets/home_row.dart';
import 'package:citame/providers/categories_provider.dart';
import 'package:citame/providers/geolocator_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends ConsumerWidget {
  HomePage({
    super.key,
  });
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    IO.Socket socket;
    List<HomeRow> categorias = ref.watch(categoriesProvider);
    ref.watch(geoProvider.notifier).obtener();
    CategoristListNotifier categoriesController =
        ref.read(categoriesProvider.notifier);

    void connect() {
      socket = IO.io('http://ubuntu.citame.store/', <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      });
      socket.connect();
      socket.emit("/test", "Hello World");
      socket.onConnect((data) => print('Connected'));
      print(socket.connected);
      //socket.disconnect();
    }

    connect();

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
          color: Colors.white,
          //decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 12, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Color(0xFF606A85),
                          size: 24,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                            child: SizedBox(
                              child: TextField(
                                onChanged: (value) => {
                                  categoriesController.filtrar(value),
                                },
                                controller: searchBarController,
                                decoration: InputDecoration(
                                  labelStyle: API.estiloJ14gris,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: API.estiloJ14negro,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text('Categorias', style: API.estiloJ24negro),
                SizedBox(height: 12),
                Expanded(child: ListView(children: categorias)),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          BarraInferior(searchBarController: searchBarController, tip: 1),
    );
  }
}
