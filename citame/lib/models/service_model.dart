class Service {
  final String nombreServicio;
  final List<List<int>> imgPath;
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
    return Service(
        nombreServicio: json['nombreServicio'],
        imgPath: json['imgPath'],
        precio: json['precio'],
        duracion: json['duracion'],
        descripcion: json['descripcion'],
        businessCreatedBy: json['businessCreatedBy']);
  }
}
