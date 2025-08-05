import 'package:rest_api_impl/utils/i_utils/i_rest_api_config.dart';

class DefaultRestApiConfig extends IRestApiConfig {
  String? _baseUrl;
  String? _apiKey;

  DefaultRestApiConfig({String? baseUrl, String? apiKey})
    : _baseUrl = baseUrl,
      _apiKey = apiKey;

  @override
  String get apiKey => _apiKey ?? '';

  @override
  set apiKey(String key) => _apiKey = key;

  @override
  String get baseUrl => _baseUrl ?? '';

  @override
  set baseUrl(String url) => _baseUrl = url;
}
