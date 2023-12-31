import 'package:citame/pages/pages_1/business_search_page.dart';
import 'package:citame/providers/business_provider.dart';
import 'package:citame/providers/categories_provider.dart';
import 'package:citame/providers/my_business_state_provider.dart';
import 'package:citame/providers/page_provider.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeRow extends ConsumerWidget {
  final String categoria;
  final String imagen;

  const HomeRow({
    Key? key,
    required this.categoria,
    required this.imagen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //List<Business> allBusiness;
    //List<BusinessCard> negocios;
    //List<HomeRow> categorias = ref.watch(categoriesProvider);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF1F4F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () /*async*/ {
          ref.read(businessProvider.notifier).inicializar();
          ref.read(categoriesProvider.notifier).inicializar();
          API.setCat(categoria);
          ref.read(businessProvider.notifier).limpiar();
          ref
              .read(pageProvider.notifier)
              .actualizar(BusinessSearchPage(categoria: categoria));
          /*/try {
            allBusiness = await API.getAllBusiness();
            negocios = allBusiness.map((e) {
              return (BusinessCard(
                nombre: e.businessName,
                categoria: e.category,
                latitud: double.parse(e.latitude),
                longitud: double.parse(e.longitude),
                rating: 5.0,
                imagen: e.imgPath,
              ));
            }).toList();*/
          //if (context.mounted) {
          ref.read(myBusinessStateProvider.notifier).setPage(BusinessSearchPage(
                categoria: categoria,
              ).runtimeType);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BusinessSearchPage(
                  categoria: categoria,
                ),
              ));
          ref.read(businessProvider.notifier).cargar(context);

          // }
          /*} catch (e) {
            print(e);
          }*/
        },
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image(
                    image: AssetImage(imagen),

                    // width: 70,
                    //height: 70,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Text(
                  categoria,
                  style: API.estiloJ16negro,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fade(duration: 2000.ms).slide(curve: Curves.easeIn);
  }
}
