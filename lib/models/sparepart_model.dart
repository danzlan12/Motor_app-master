import 'package:flutter/cupertino.dart';

class MotorModel {
  final String img;
  final String name;
  final String company;
  final double price;
  bool isselected;
  final Color color;

  MotorModel(
      {required this.img,
      required this.name,
      required this.company,
      required this.price,
      required this.isselected,
      required this.color});
}

