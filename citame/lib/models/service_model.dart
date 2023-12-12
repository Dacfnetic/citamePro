class Service {
  final String nombreServicio;
  final List<List<int>> imgPath;
  final double precio;
  final String descripcion;

  Map toJson() => {
        'nombreServicio': nombreServicio,
        'imgPath': imgPath,
        'precio': precio,
        'descripcion': descripcion,
      };
  Service({
    required this.nombreServicio,
    required this.imgPath,
    required this.precio,
    required this.descripcion,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      nombreServicio: json['nombreServicio'],
      imgPath: json['imgPath'],
      precio: json['precio'],
      descripcion: json['descripcion'],
    );
  }
}
