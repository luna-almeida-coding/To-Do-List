abstract class LocalStorage {
  Future<dynamic> read({
    required String key,
  });

  Future<bool> write({
    required String key,
    dynamic data,
  });

  Future<bool> remove({required String key});
}
