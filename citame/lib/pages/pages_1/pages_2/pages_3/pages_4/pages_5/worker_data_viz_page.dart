import 'package:citame/Widgets/bottom_bar_business.dart';
import 'package:flutter/material.dart';
import 'package:citame/agenda/flutter_neat_and_clean_calendar.dart';

class WorkerDataVizPage extends StatelessWidget {
  const WorkerDataVizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NeatCleanCalendarEvent> _eventList = [
      NeatCleanCalendarEvent(
        'Corte de pelo',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 17, 0),
        color: Colors.green,
        description: 'Cortarle el pelo al prro',
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Calendar(
          startOnMonday: true,
          weekDays: ['Lu', 'Ma', 'Mi', 'JU', 'Vi', 'Sa', 'Do'],
          eventsList: _eventList,
          isExpandable: true,
          eventDoneColor: Colors.green,
          selectedColor: Colors.pink,
          selectedTodayColor: Colors.red,
          todayColor: Colors.blue,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BarraInferiorBusiness(),
    );
  }
}
