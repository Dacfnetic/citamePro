import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CajaDeServicios extends StatelessWidget {
  const CajaDeServicios({
    super.key,
    required this.nombre,
    required this.precio,
    required this.duracion,
    required this.esDueno,
  });
  final bool esDueno;
  final String nombre;
  final String precio;
  final String duracion;
  @override
  Widget build(BuildContext context) {
    if (esDueno) {
      return Slidable(
        dragStartBehavior: DragStartBehavior.start,
        startActionPane: ActionPane(motion: BehindMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.delete,
            backgroundColor: Colors.red,

            // borderRadius: BorderRadius.circular(12),
          ),
        ]),
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) {},
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            //borderRadius: BorderRadius.circular(12),
          ),
        ]),
        child: Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.8),
              //borderRadius: BorderRadius.circular(12),
              color: Colors.white),
          //margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.cut, size: 32),
                  )),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 30),
                  //padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombre,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        duracion,
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.7),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
              //Spacer(flex: 3),
              Text(precio,
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
            ],
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
          color: Colors.white, // Color de fondo del Container
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(2),
              child: Icon(Icons.cut, size: 35),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 10, top: 0, bottom: 0, right: 30),
                //padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 6),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nombre,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(
                      duracion,
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.7),
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
            //Spacer(flex: 3),
            Text(precio, style: TextStyle(fontSize: 20, color: Colors.green)),
          ],
        ),
      );
    }
  }
}
