import 'package:citame/Widgets/bottom_bar.dart';
import 'package:citame/Widgets/bottom_bar_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviewBusinessPage extends ConsumerWidget {
  const PreviewBusinessPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Text('Página en construcción'),
      ),
      bottomNavigationBar: BarraInferiorBusiness(),
    );
  }
}
