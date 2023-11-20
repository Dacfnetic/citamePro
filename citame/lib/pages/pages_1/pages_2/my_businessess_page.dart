import 'package:citame/Widgets/business_card.dart';
import 'package:citame/Widgets/search_bar_citame.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyBusinessesPage extends ConsumerWidget {
  MyBusinessesPage({
    Key? key,
    required this.negocios,
  }) : super(key: key);
  final TextEditingController searchBarController = TextEditingController();
  final List<BusinessCard> negocios;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SearchBarCitame(
                    businessFunctions: ref.read(businessProvider.notifier),
                    searchBarController: searchBarController),
                SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: negocios,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
