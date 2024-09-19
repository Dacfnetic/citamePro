import 'dart:io';

import 'package:flutter/material.dart';

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
  final String imgPath;
  final double salary;
  final Map horario;
  final bool status;
  var imagen;
  final String id;
  final String idWorker;
  final String puesto;
  final Map horarioDisponible;
  final int celular;

  Map toJson() => {
        'name': name,
        'email': email,
        'imgPath': imgPath,
        'salary': salary,
        'horario': horario.toString(),
        'status': status,
        'id': id,
        'idWorker': idWorker,
        'imagen': imagen,
        'puesto': puesto,
        'celular': celular,
      };
  Worker(
      {required this.name,
      required this.email,
      required this.imgPath,
      required this.salary,
      required this.horario,
      required this.status,
      required this.id,
      required this.idWorker,
      required this.imagen,
      required this.puesto,
      required this.horarioDisponible,
      required this.celular});

  factory Worker.fromJson(Map<String, dynamic> json) {
    return Worker(
        name: json['name'],
        email: json['email'],
        imgPath: json['imgPath'],
        salary: json['salary'].toDouble(),
        horario: {},
        status: json['status'],
        id: json['idDeUsuario'],
        imagen: json['imagen'],
        idWorker: json['_id'],
        puesto: json['puesto'],
        horarioDisponible: json['horarioDisponible'],
        celular: json['celular']);
  }
}
