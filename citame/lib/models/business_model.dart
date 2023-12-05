class Business {
  final String businessName;
  final String category;
  final String email;
  //final String createdBy;
  final List<dynamic> workers;
  final String contactNumber;
  final String direction;
  final String latitude;
  final String longitude;
  final String description;
  final List<int> imgPath;

  Business({
    required this.businessName,
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
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessName: json['businessName'],
      category: json['category'],
      email: json['email'],
      //createdBy: json['createdBy'],
      workers: json['workers'],
      contactNumber: json['contactNumber'],
      direction: json['direction'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      imgPath: json['imgPath'].cast<int>(),
    );
  }
}
