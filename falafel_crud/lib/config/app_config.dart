class AppConfig {
  // true  = echtes Backend (Spring Boot)
  // false = REST-Simulation / JSON
  static bool useBackend = false;

  static const String backendBaseUrl = 'http://localhost:8080';
}
