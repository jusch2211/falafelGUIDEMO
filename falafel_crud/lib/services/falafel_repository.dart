abstract class FalafelRepository {
  Future<List<Map<String, dynamic>>> getFalafel();
  Future<void> addFalafel(Map<String, dynamic> falafel);
  Future<void> updateFalafel(int id, Map<String, dynamic> falafel);
  Future<void> deleteFalafel(int id);
}
