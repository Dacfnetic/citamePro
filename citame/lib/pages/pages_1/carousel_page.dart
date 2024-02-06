import 'package:citame/pages/pages_1/pages_2/business_registration_page.dart';
import 'package:citame/pages/pages_1/pages_2/pages_3/pages_4/pages_5/subscriptions.dart';
import 'package:citame/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselPage extends StatefulWidget {
  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registrar negocio',
          style: API.estiloJ16negro,
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/one.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(3),
                      child: RichText(
                        text: TextSpan(
                          text: 'Comienza a administrar tu negocio ',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                          children: [
                            TextSpan(
                              text: 'en la mejor app en Guatemala',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 25),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                'Simplifica la gestión de horarios y citas para ahorrar tiempo y evitar errores.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                'Facil administracion de tu agenda con tus clientes.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                'Como propietario tendras acceso a tu agenda general y a la agenda de tus trabajadores.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/two.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(3),
                      child: RichText(
                        text: TextSpan(
                          text: 'Registra tu negocio ahora ',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                          children: [
                            TextSpan(
                              text: 'por tan solo \$6.99 el primer mes.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 25),
                  Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                              size: 40,
                            ),
                            Expanded(
                              child: Text(
                                'Registro gratis de 5 trabajadores en tu negocio.',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                              size: 40,
                            ),
                            Expanded(
                              child: Text(
                                'Registro gratis de 2 negocios con tu misma cuenta de propietario.',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_pageController.page != null && _pageController.page! < 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BusinessRegisterPage(),
              ),
            );
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
