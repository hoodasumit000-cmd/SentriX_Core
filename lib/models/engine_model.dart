import 'package:flutter/material.dart';

class EngineModel {
  final int id;
  final String name;
  final IconData icon;
  bool isActive;
  double speed;

  EngineModel({
    required this.id,
    required this.name,
    required this.icon,
    this.isActive = true,
    required this.speed,
  });
}
