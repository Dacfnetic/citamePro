import 'dart:convert';

class Business {
  final String businessName;
  final String idMongo;
  final String category;
  final String email;
  //final String createdBy;
  final List<dynamic> workers;
  final String contactNumber;
  final String direction;
  final String latitude;
  final String longitude;
  final String description;
  final List imgPath;
  final Map horario;
  Map toJson() => {
        'businessName': businessName,
        'idMongo': idMongo,
        'category': category,
        'email': email,
        'workers': workers,
        'contactNumber': contactNumber,
        'direction': direction,
        'latitude': latitude,
        'longitude': longitude,
        'description': description,
        'imgPath': imgPath,
        'horario': horario,
      };
  Business({
    required this.businessName,
    required this.idMongo,
    required this.category,
    required this.email,
    //required this.createdBy,
    required this.workers,
    required this.contactNumber,
    required this.direction,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.imgPath,
    required this.horario,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessName: json['businessName'],
      idMongo: json['_id'],
      category: json['category'],
      email: json['email'],
      //createdBy: json['createdBy'],
      workers: json['workers'],
      contactNumber: json['contactNumber'],
      direction: json['direction'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      imgPath: json['imgPath'],
      horario: jsonDecode(json['horario']),
    );
  }
  factory Business.fromJson2(Map<String, dynamic> json) {
    return Business(
      businessName: json['businessName'],
      idMongo: json['idMongo'],
      category: json['category'],
      email: json['email'],
      //createdBy: json['createdBy'],
      workers: json['workers'],
      contactNumber: json['contactNumber'],
      direction: json['direction'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      imgPath: json['imgPath'],
      horario: jsonDecode(json['horario']),
    );
  }
}
