import 'package:flutter/material.dart';

class Response {
  // This class is concerned with app level backend response handling
  final bool success;
  final String error;
  final Map<dynamic, dynamic> data;

  Response({
    @required this.success,
    @required this.error,
    @required this.data,
  });
}
