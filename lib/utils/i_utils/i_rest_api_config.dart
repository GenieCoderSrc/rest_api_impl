// Dependency Inversion Principle (DIP)
abstract class IRestApiConfig {
  String get apiKey;
  String get baseUrl;

  // Optional: Add setters to the interface
  set apiKey(String key);
  set baseUrl(String url);
}
