import 'package:citame/Widgets/business_card.dart';
import 'package:citame/Widgets/search_bar_citame.dart';
import 'package:citame/providers/my_favorites_provider.dart';
import 'package:citame/providers/re_render_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyFavoritesPage extends ConsumerWidget {
  MyFavoritesPage({
    super.key,
  });
  final TextEditingController searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<BusinessCard> negocios = ref.watch(myFavoritesProvider);
    ref.watch(reRenderProvider);
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
                SearchBarCitame(searchBarController: searchBarController),
                SizedBox(height: 12),
                Expanded(
                  child: ListView(
                      children: (negocios.isEmpty)
                          ? [Center(child: CircularProgressIndicator())]
                          : negocios),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
