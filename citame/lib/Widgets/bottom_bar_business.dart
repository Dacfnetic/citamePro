import 'package:citame/pages/Perfil/Configuraci%C3%B3n%20de%20negocio/menu_page.dart';
import 'package:citame/pages/Agendas/worker_data_viz_page.dart';
import 'package:citame/providers/navbar_provider.dart';
import 'package:citame/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarraInferiorBusiness extends ConsumerWidget {
  const BarraInferiorBusiness({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.white,
        selectedIndex: 0,
        onDestinationSelected: (value) async {
          ref.read(navbarProvider.notifier).changeState(value);
          if (value == 2) {
            ref.read(pageProvider.notifier).actualizar(MenuPage());
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuPage(),
                ));
          }
          if (value == 1) {
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WorkerDataVizPage(),
                  ));
            }
          }
        },
        elevation: 0,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.sticky_note_2),
            icon: Icon(Icons.sticky_note_2_outlined),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: '',
          ),
        ]);
  }
}
