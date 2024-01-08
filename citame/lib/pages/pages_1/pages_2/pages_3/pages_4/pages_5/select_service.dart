import 'dart:typed_data';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool isChecked = false;
List<Text> serviciosSeleccionados = [];

class SelectService extends ConsumerWidget {
  const SelectService({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Usuario user = ref.read(myBusinessStateProvider.notifier).getDatosUsuario();
    List<Service> listaDeServicios =
        ref.watch(myBusinessStateProvider.notifier).getService();
    List<CajaDeServicios> servicios = listaDeServicios
        .map((servicio) => CajaDeServicios(
              nombre: servicio.nombreServicio,
              idServicio: servicio.id,
              //precio: servicio.precio.toStringAsFixed(2),
              //duracion: servicio.duracion,
              //esDueno: true
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles',
          style: API.estiloJ16negro,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Selecciona los servicios que quieres'),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(height: 10),
              ListView(
                shrinkWrap: true,
                children: [
                  servicios.isNotEmpty
                      ? SizedBox(
                          height: 300,
                          child:
                              ListView(shrinkWrap: true, children: servicios))
                      : Text(''),
                ],
              ),
              ListView(shrinkWrap: true, children: serviciosSeleccionados),
              //ElevatedButton(onPressed: onPressed, child: child)
            ],
          ),
        )),
      ),
    );
  }
}

class CajaDeServicios extends StatefulWidget {
  const CajaDeServicios({
    Key? key,
    required this.nombre,
    required this.idServicio,
  }) : super(key: key);

  final String nombre;
  final String idServicio;
  @override
  _CajaDeServiciosState createState() => _CajaDeServiciosState();
}

class _CajaDeServiciosState extends State<CajaDeServicios> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      //visualDensity: VisualDensity(horizontal: -4.0, vertical: -3.0),
      activeColor: Colors.green,
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text(widget.nombre),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          if (isChecked) {
            serviciosSeleccionados.add(Text(widget.nombre));
          } else {
            serviciosSeleccionados.remove(Text(widget.nombre));
          }
        });
      },
    );
  }
}
