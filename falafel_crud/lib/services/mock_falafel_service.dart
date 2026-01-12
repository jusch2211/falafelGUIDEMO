import 'dart:convert';
import 'package:flutter/services.dart';
import 'falafel_repository.dart';

class MockFalafelService implements FalafelRepository {
  @override
  Future<List<Map<String, dynamic>>> getFalafel() async {
    final jsonString = await rootBundle.loadString('lib/data/falafel.json');
    final List data = jsonDecode(jsonString);
    return data.cast<Map<String, dynamic>>();
  }

  @override
  Future<void> addFalafel(Map<String, dynamic> falafel) async {}

  @override
  Future<void> updateFalafel(int id, Map<String, dynamic> falafel) async {}

  @override
  Future<void> deleteFalafel(int id) async {}
}
