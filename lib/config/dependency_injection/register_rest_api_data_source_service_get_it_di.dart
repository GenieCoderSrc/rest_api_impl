import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:register/dependency_injection/register_local_hive_data_source_service_get_it_di.dart';
import 'package:rest_api_impl/data/data_sources/i_data_sources/i_rest_api_crud_service.dart';
import 'package:rest_api_impl/data/data_sources/i_data_sources/i_rest_api_data_sender.dart';
import 'package:rest_api_impl/data/data_sources/rest_api_crud_service_rest_api_data_sender_impl.dart';
import 'package:rest_api_impl/data/data_sources/rest_api_data_sender_http_impl.dart';
import 'package:rest_api_impl/utils/header_provider_impl.dart';
import 'package:rest_api_impl/utils/i_utils/i_header_provider.dart';
import 'package:rest_api_impl/utils/i_utils/i_response_handler.dart';
import 'package:rest_api_impl/utils/i_utils/i_rest_api_config.dart';
import 'package:rest_api_impl/utils/i_utils/i_url_generator.dart';
import 'package:rest_api_impl/utils/response_handler_http_impl.dart';
import 'package:rest_api_impl/utils/rest_api_config_app_dev_mode_impl.dart';
import 'package:rest_api_impl/utils/url_generator_rest_api_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void registerRestApiDataSourceServiceGetItDI() {
//! External

  sl.registerLazySingleton(() => http.Client());

  registerLocalHiveDataSourceServiceGetItDI();

  /// ----------------- Rest API Data Service--------------
  ///  Service
  sl.registerLazySingleton<IResponseHandler<http.Response>>(
      () => ResponseHandlerHttpImpl());

  sl.registerLazySingleton<IRestApiConfig>(() => RestApiConfigAppDevModeImpl());
  sl.registerLazySingleton<IHeaderProvider>(() => HeaderProviderBearerImpl());
  sl.registerLazySingleton<IUrlGenerator>(() => UrlGeneratorRestApiImpl());
  // sl.registerLazySingleton<IParseHttpResponseData>(
  //     () => ParseHttpResponseData());

  // sl.registerLazySingleton<IRestApiDataService>(() =>
  //     RestApiDataServiceDioImpl(dio: sl(), iApiResponseHandlerService: sl()));

  sl.registerLazySingleton<IRestApiDataSender>(() => RestApiDataSenderHttpImpl(
        client: sl(),
        iResponseHandler: sl(),
        iRestApiConfig: sl(),
        iRestApiHeaderProvider: sl(),
        iApiPathUrlGenerator: sl(),
      ));

  sl.registerLazySingleton<IRestApiCrudService>(
      () => RestApiCrudServiceRestApiDataSenderImpl(iRestApiDataSender: sl()));
}
