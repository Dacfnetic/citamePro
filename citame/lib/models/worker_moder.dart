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
  final List<int> imgPath;
  final double salary;
  final String horario;
  final bool status;

  Map toJson() => {
        'name': name,
        'email': email,
        'imgPath': imgPath,
        'salary': salary,
        'horario': horario,
        'status': status,
      };
  Worker({
    required this.name,
    required this.email,
    required this.imgPath,
    required this.salary,
    required this.horario,
    required this.status,
  });

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
      name: json['name'],
      email: json['email'],
      imgPath: json['imgPath'],
      salary: json['salary'],
      horario: json['horario'],
      status: json['status'],
    );
  }
}
