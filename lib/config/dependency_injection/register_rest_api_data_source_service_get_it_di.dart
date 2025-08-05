import 'package:dio/dio.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_impl/data/data_sources/i_data_sources/i_rest_api_crud_service.dart';
import 'package:rest_api_impl/data/data_sources/i_data_sources/i_rest_api_data_sender.dart';
import 'package:rest_api_impl/data/data_sources/rest_api_crud_service_rest_api_data_sender_impl.dart';
import 'package:rest_api_impl/data/data_sources/rest_api_data_sender_dio_impl.dart';
import 'package:rest_api_impl/data/data_sources/rest_api_data_sender_http_impl.dart';
import 'package:rest_api_impl/enums/rest_api_client_type.dart';
import 'package:rest_api_impl/utils/default_rest_api_config.dart';
import 'package:rest_api_impl/utils/header_provider_impl.dart';
import 'package:rest_api_impl/utils/i_utils/i_header_provider.dart';
import 'package:rest_api_impl/utils/i_utils/i_response_handler.dart';
import 'package:rest_api_impl/utils/i_utils/i_rest_api_config.dart';
import 'package:rest_api_impl/utils/i_utils/i_url_generator.dart';
import 'package:rest_api_impl/utils/response_handler_dio_impl.dart';
import 'package:rest_api_impl/utils/response_handler_http_impl.dart';
import 'package:rest_api_impl/utils/url_generator_rest_api_impl.dart';

void registerRestApiDataSourceServiceGetItDI({
  String? baseUrl,
  String? apiKey,
  RestApiClientType clientType = RestApiClientType.http,
  IRestApiConfig? config,
}) {
  // ───────────────────────────────────────────────
  // 🧾 Shared Utilities (DRY - common to both Dio and Http)
  // ───────────────────────────────────────────────

  // Register config first
  sl.registerLazySingleton<IRestApiConfig>(
    () => config ?? DefaultRestApiConfig(baseUrl: baseUrl, apiKey: apiKey),
  );

  sl.registerLazySingleton<IHeaderProvider>(() => HeaderProviderBearerImpl());
  sl.registerLazySingleton<IUrlGenerator>(() => UrlGeneratorRestApiImpl());

  // ───────────────────────────────────────────────
  // 🔁 Conditional Implementation: HTTP or DIO
  // ───────────────────────────────────────────────

  if (clientType == RestApiClientType.dio) {
    // 🚀 Dio client and services
    sl.registerLazySingleton<Dio>(() => Dio());

    sl.registerLazySingleton<IResponseHandler<Response>>(
      () => ResponseHandlerDioImpl(),
    );

    sl.registerLazySingleton<IRestApiDataSender>(
      () => RestApiDataSenderDioImpl(
        dio: sl<Dio>(),
        iResponseHandler: sl<IResponseHandler<Response>>(),
        iRestApiConfig: sl(),
        iRestApiHeaderProvider: sl(),
        iApiPathUrlGenerator: sl(),
      ),
    );
  } else {
    // 🌐 Http client and services
    sl.registerLazySingleton<http.Client>(() => http.Client());

    sl.registerLazySingleton<IResponseHandler<http.Response>>(
      () => ResponseHandlerHttpImpl(),
    );

    sl.registerLazySingleton<IRestApiDataSender>(
      () => RestApiDataSenderHttpImpl(
        client: sl<http.Client>(),
        iResponseHandler: sl<IResponseHandler<http.Response>>(),
        iRestApiConfig: sl(),
        iRestApiHeaderProvider: sl(),
        iApiPathUrlGenerator: sl(),
      ),
    );
  }

  // ───────────────────────────────────────────────
  // 📦 Shared: REST API CRUD Service
  // ───────────────────────────────────────────────

  sl.registerLazySingleton<IRestApiCrudService>(
    () => RestApiCrudServiceRestApiDataSenderImpl(
      iRestApiDataSender: sl<IRestApiDataSender>(),
    ),
  );
}
