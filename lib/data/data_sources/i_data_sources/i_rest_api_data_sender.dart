import 'package:rest_api_impl/data/enums/method.dart';

abstract class IRestApiDataSender {
  // send data to server
  Future<Map<String, dynamic>?> sendRequest({
    Map<String, dynamic>? data,
    required String endPoint,
    required Method method,
    String? accessToken,
  });
}
