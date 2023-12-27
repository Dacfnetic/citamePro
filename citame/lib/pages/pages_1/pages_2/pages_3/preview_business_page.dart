import 'package:citame/Widgets/bottom_bar_business.dart';
import 'package:citame/providers/my_actual_business_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewBusinessPage extends ConsumerWidget {
  const PreviewBusinessPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Text('Página en construcción'),
            ElevatedButton(
                onPressed: () async {
                  if (context.mounted) {
                    API.estasSeguro(
                      context,
                      ref
                          .read(myBusinessStateProvider.notifier)
                          .getActualBusiness(),
                    );
                  }
                },
                child: Text('Borrar negocio'))
          ],
        ),
      ),
      bottomNavigationBar: BarraInferiorBusiness(),
    );
  }
}
