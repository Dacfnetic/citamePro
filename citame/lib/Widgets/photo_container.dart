import 'package:flutter/material.dart';

class EspacioParaSubirFotoDeNegocio extends StatelessWidget {
  const EspacioParaSubirFotoDeNegocio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.amber,
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.amberAccent,
              /*image: DecorationImage(
                  image: AssetImage('lib/assets/SplashScreen.jpg'),
                  fit: BoxFit.fill,
                ),*/
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Subir imagen'),
          )
        ],
      ),
    );
  }
}
