import 'package:flutter/material.dart';
class Bunny {
  static final defaultColor = Colors.black;

  Bunny({required this.type, Color? color}) : color = color ?? defaultColor;

  final String type;
  final Color color;

  factory Bunny.fromJson(Map<String, dynamic> json) {
    print(json);
    return Bunny(
      type: json['type'] ?? 'Unknown',
      color: json['color'] != null ? Color(json['color'] as int) : defaultColor,
    );
  }
}
