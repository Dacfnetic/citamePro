import 'package:citame/pages/AUN%20NO%20S%C3%89/profile_inside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfiguracionDeHorarioGeneralDelNegocio extends StatelessWidget {
  const ConfiguracionDeHorarioGeneralDelNegocio(
      {super.key, required this.horario, required this.ref});

  final Map horario;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
      child: ListView(children: [
        ContenedorDeHorario2(horario: horario, day: 'lunes', ref: ref),
        ContenedorDeHorario2(horario: horario, day: 'martes', ref: ref),
        ContenedorDeHorario2(horario: horario, day: 'miercoles', ref: ref),
        ContenedorDeHorario2(horario: horario, day: 'jueves', ref: ref),
        ContenedorDeHorario2(horario: horario, day: 'viernes', ref: ref),
        ContenedorDeHorario2(horario: horario, day: 'sabado', ref: ref),
        ContenedorDeHorario2(horario: horario, day: 'domingo', ref: ref),
        //TO DO: Tengo que copiar lo de adentro el la función de guardar general.
        /*ElevatedButton(
        onPressed: () async {
          SharedPreferences prefs =
              await SharedPreferences.getInstance();
          ref
              .read(myBusinessStateProvider.notifier)
              .setHorarioParaEnviar(horas.toJson());
          Map enviar = ref
              .read(myBusinessStateProvider.notifier)
              .getHorarioParaEnviar();
          API.updateBusinessSchedule(
              prefs.getString('negocioActual')!, enviar);
        },
        child: Text('Guardar horario'))*/
      ]),
    );
  }
}
