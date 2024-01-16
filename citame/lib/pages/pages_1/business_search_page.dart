import 'dart:developer';

import 'package:citame/Widgets/bottom_bar.dart';
import 'package:citame/Widgets/business_card.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/geolocator_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusinessSearchPage extends ConsumerWidget {
  final String categoria;

  BusinessSearchPage({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  final TextEditingController searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<BusinessCard> negocios = ref.watch(businessProvider);

    log(ref.read(myBusinessStateProvider.notifier).getPage().toString());

    ref.watch(geoProvider.notifier).obtener();

    BusinessListNotifier businessController =
        ref.read(businessProvider.notifier);
    print(businessController.cantidad());
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
          color: Colors.white,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Text(ref.read(geoProvider)[0].toString()),
                Text(ref.read(geoProvider)[1].toString()),*/
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Color(0xFFE5E7EB),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 12, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Color(0xFF606A85),
                          size: 24,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                            child: SizedBox(
                              child: TextField(
                                onChanged: (value) => {
                                  businessController.filtrar(value),
                                },
                                controller: searchBarController,
                                decoration: InputDecoration(
                                  labelStyle: API.estiloJ14gris,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                style: API.estiloJ14negro,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text(categoria, style: API.estiloJ24negro),
                SizedBox(height: 12),
                Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      children: (negocios.isEmpty)
                          ? [Center(child: CircularProgressIndicator())]
                          : negocios),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BarraInferior(
        searchBarController: searchBarController,
        tip: 1,
        padre: context,
      ),
    );
  }
}
