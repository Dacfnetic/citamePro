import 'package:citame/models/user_model.dart';
import 'package:citame/pages/pages_1/profile_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/categories_provider.dart';
import 'package:citame/providers/navbar_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BarraInferior extends ConsumerWidget {
  const BarraInferior({
    super.key,
    required this.searchBarController,
    required this.tip,
  });

  final TextEditingController searchBarController;
  final int tip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: Colors.white,
        selectedIndex: 0,
        onDestinationSelected: (value) async {
          Usuario currentUser = await API.getUser();
          ref.read(navbarProvider.notifier).changeState(value);
          if (value == 2) {
            if (context.mounted) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: currentUser),
                  ));
            }
            ref.read(businessProvider.notifier).inicializar();
            ref.read(categoriesProvider.notifier).inicializar();
            searchBarController.text = "";
          }
          if (value == 1) {
            ref.read(businessProvider.notifier).inicializar();
            ref.read(categoriesProvider.notifier).inicializar();
            searchBarController.text = "";
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
            selectedIcon: Icon(Icons.person_2),
            icon: Icon(Icons.person_2_outlined),
            label: '',
          ),
        ]);
  }
}
