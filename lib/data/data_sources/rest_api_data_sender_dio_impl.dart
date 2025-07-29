import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rest_api_impl/data/data_sources/i_data_sources/i_rest_api_data_sender.dart';
import 'package:rest_api_impl/data/enums/method.dart';
import 'package:rest_api_impl/exceptions/exception_handler/rest_api_exception_handler.dart';
import 'package:rest_api_impl/utils/i_utils/i_header_provider.dart';
import 'package:rest_api_impl/utils/i_utils/i_response_handler.dart';
import 'package:rest_api_impl/utils/i_utils/i_rest_api_config.dart';
import 'package:rest_api_impl/utils/i_utils/i_url_generator.dart';

class RestApiDataSenderDioImpl extends IRestApiDataSender {
  final Dio dio;
  final IResponseHandler<Response> iResponseHandler;
  final IHeaderProvider iRestApiHeaderProvider;
  final IUrlGenerator iApiPathUrlGenerator;
  final IRestApiConfig iRestApiConfig;

  RestApiDataSenderDioImpl({
    required this.dio,
    required this.iRestApiConfig,
    required this.iResponseHandler,
    required this.iRestApiHeaderProvider,
    required this.iApiPathUrlGenerator,
  });

  @override
  Future<Map<String, dynamic>?> sendRequest({
    required String endPoint,
    required Method method,
    String? accessToken,
    Map<String, dynamic>? data,
  }) async {
    try {
      final String url = iApiPathUrlGenerator
          .generatePathUrl(endPoint: endPoint, config: iRestApiConfig)
          .toString();

      final Map<String, String> headers =
          iRestApiHeaderProvider.getHeaders(accessToken);

      late Response response;

      switch (method) {
        case Method.GET:
          response = await dio.get(
            url,
            queryParameters: data,
            options: Options(headers: headers),
          );
          break;
        case Method.POST:
          response = await dio.post(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case Method.PATCH:
          response = await dio.patch(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case Method.PUT:
          response = await dio.put(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case Method.DELETE:
          response = await dio.delete(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
      }

      log('RestApiDataSenderDioImpl | response body: ${response.data.toString()}');

      return iResponseHandler.handleResponse(response);
    } catch (e) {
      throw RestApiExceptionHandler.handleException(e);
    }
  }
}
