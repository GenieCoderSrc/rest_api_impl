import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api_impl/rest_api_impl.dart';

void restApiServiceGetItRegister() {
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

  sl.registerLazySingleton(() => http.Client());
}
