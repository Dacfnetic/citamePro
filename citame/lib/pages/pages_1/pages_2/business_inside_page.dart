import 'package:citame/Widgets/worker.dart';
import 'package:citame/models/service_model.dart';
import 'package:citame/models/worker_moder.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/menu_page.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/reservation_page.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:citame/services/api_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessInsidePage extends ConsumerWidget {
  BusinessInsidePage({
    Key? key,
    required this.businessName,
    required this.imagen,
    required this.description,
  }) : super(key: key);
  final String businessName;
  final Uint8List imagen;
  final String description;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Service> listaDeServicios =
        ref.watch(myBusinessStateProvider.notifier).getService();

    List<CajaDeServicios> servicios = listaDeServicios
        .map((servicio) => CajaDeServicios(
              nombre: servicio.nombreServicio,
              precio: servicio.precio.toStringAsFixed(2),
              duracion: servicio.duracion,
              esDueno: false,
            ))
        .toList();

    List<Worker> workers =
        ref.watch(myBusinessStateProvider.notifier).obtenerWorkers();

    ref.watch(reRenderProvider);

    List<WorkerBox> trabajadores = workers
        .map((e) => WorkerBox(
              worker: e,
              ref: ref,
              imagen: Uint8List.fromList(e.imgPath[0]),
              isDueno: false,
            ))
        .toList();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        'Informacion',
                        style: TextStyle(fontSize: 14),
                      ),
                      icon: Icon(Icons.store, size: 30),
                    ),
                    Tab(
                      child: Text('Servicios', style: TextStyle(fontSize: 14)),
                      icon: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                    ),
                    Tab(
                        child: Text('Trabajadores',
                            style: TextStyle(fontSize: 14)),
                        icon: Icon(
                          Icons.group,
                          size: 30,
                        ))
                  ]),
              Expanded(
                  child: TabBarView(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(businessName, style: API.estiloJ24negro),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.memory(
                            imagen,
                            width: double.infinity,
                            height: 230,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              userAPI.addToFavoritesBusiness(ref
                                  .read(myBusinessStateProvider.notifier)
                                  .getActualBusiness());
                            },
                            child: Icon(Icons.favorite)),
                        Text('Horario'),
                        Text('Descripción'),
                        Text(description, style: API.estiloJ14gris),
                        ElevatedButton(
                            onPressed: () {}, child: Text('Reservar cita'))
                      ],
                    ),
                  ),
                ),
                servicios.isNotEmpty
                    ? SizedBox(
                        height: 210,
                        child: ListView(shrinkWrap: true, children: servicios))
                    : Text('Este negocio no tiene servicios'),
                workers.isNotEmpty
                    ? ListView(shrinkWrap: true, children: trabajadores)
                    : Container(),
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
