import 'dart:developer';

import 'package:citame/Widgets/bottom_bar.dart';
import 'package:citame/Widgets/bottom_bar_business.dart';
import 'package:citame/providers/event_provider.dart';
import 'package:citame/providers/services_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:citame/agenda/flutter_neat_and_clean_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAgendaPage extends ConsumerWidget {
  UserAgendaPage({super.key});
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NeatCleanCalendarEvent> eventList = ref.watch(eventsProvider);

    return Scaffold(
      body: SafeArea(
        child: Calendar(
          startOnMonday: true,
          weekDays: ['Lu', 'Ma', 'Mi', 'JU', 'Vi', 'Sa', 'Do'],
          eventsList: eventList,
          onEventSelected: (value) {
            API.verifyCita('Aprobada', value.description, ref);
            log('Puedo hacer que pasen cosas');
          },
          isExpandable: true,
          defaultDayColor: Colors.black,
          eventDoneColor: Colors.green,
          selectedColor: Colors.pink,
          selectedTodayColor: Colors.red,
          todayColor: Colors.amber,
          eventColor: null,
          locale: 'es_ES',
          todayButtonText: 'Hoy',
          allDayEventText: 'Inicio',
          multiDayEndText: 'Fin',
          isExpanded: true,
          expandableDateFormat: 'EEEE, dd. MMMM yyyy',
          datePickerType: DatePickerType.date,
          dayOfWeekStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
        ),
      ),
      bottomNavigationBar: BarraInferior(
          searchBarController: searchBarController, tip: 1, padre: context),
    );
  }
}
