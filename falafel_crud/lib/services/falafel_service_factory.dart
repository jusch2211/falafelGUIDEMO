import '../config/app_config.dart';
import 'falafel_repository.dart';
import 'http_falafel_service.dart';
import 'mock_falafel_service.dart';

class FalafelServiceFactory {
  static FalafelRepository create() {
    return AppConfig.useBackend ? HttpFalafelService() : MockFalafelService();
  }
}
