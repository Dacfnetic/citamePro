class Service {
  final String nombreServicio;
  final List imgPath;
  final double precio;
  final String descripcion;
  final String businessCreatedBy;
  final String duracion;
  Map toJson() => {
        'nombreServicio': nombreServicio,
        'imgPath': imgPath,
        'precio': precio,
        'duracion': duracion,
        'descripcion': descripcion,
        'businessCreatedBy': businessCreatedBy
      };
  Service(
      {required this.nombreServicio,
      required this.imgPath,
      required this.precio,
      required this.descripcion,
      required this.duracion,
      required this.businessCreatedBy});

  factory Service.fromJson(Map<String, dynamic> json) {
    double aEnviar = 0.00;
    if (json['precio'].runtimeType == int) {
      aEnviar = json['precio'].toDouble();
    } else {
      aEnviar = json['precio'];
    }
    return Service(
        nombreServicio: json['nombreServicio'],
        imgPath: json['imgPath'],
        precio: aEnviar,
        duracion: json['duracion'],
        descripcion: json['descripcion'],
        businessCreatedBy: json['businessCreatedBy']);
  }
}
