class Schedule {
  final Map horario;
  Schedule({
    required this.horario,
  });

  Map toJson() => {
        'horario': horario,
      };
}

class Worker {
  final String name;
  final String email;
  final List imgPath;
  final double salary;
  final String horario;
  final bool status;
  final String id;
  final String idWorker;

  Map toJson() => {
        'name': name,
        'email': email,
        'imgPath': imgPath,
        'salary': salary,
        'horario': horario,
        'status': status,
        'id': id,
        'idWorker': idWorker,
      };
  Worker({
    required this.name,
    required this.email,
    required this.imgPath,
    required this.salary,
    required this.horario,
    required this.status,
    required this.id,
    required this.idWorker,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      name: json['name'],
      email: json['email'],
      imgPath: json['imgPath'],
      salary: json['salary'].toDouble(),
      horario: json['horario'],
      status: json['status'],
      id: json['id'],
      idWorker: json['_id'],
    );
  }
}
