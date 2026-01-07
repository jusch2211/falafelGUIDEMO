import 'dart:convert';
import 'package:flutter/services.dart';

class FalafelApi {
  Future<List<Map<String, dynamic>>> getFalafel() async {
    final jsonString = await rootBundle.loadString('lib/data/falafel.json');
    final List data = jsonDecode(jsonString);
    return data.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> addFalafel(
      List<Map<String, dynamic>> current,
      Map<String, dynamic> newFalafel) async {
    return [...current, newFalafel];
  }

  Future<List<Map<String, dynamic>>> deleteFalafel(
      List<Map<String, dynamic>> current, int id) async {
    return current.where((f) => f['id'] != id).toList();
  }
}
