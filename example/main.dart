import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_impl/rest_api_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  registerRestApiDataSourceServiceGetItDI(
    baseUrl: RestApiConfigConst.BASE_URL,
    apiKey: RestApiConfigConst.API_KEY,
    clientType: RestApiClientType.dio,
  );

  final restApiService = sl<IRestApiCrudService>();
  final imageService = sl<IImageServiceRestApiDataSource>();

  final response = await restApiService.addData(
    endPoint: 'user/create',
    data: {'name': 'Alice', 'email': 'alice@example.com'},
  );
  debugPrint('Create User Response: $response');

  final userData = await restApiService.getData(endPoint: 'user/1');
  print('User Data: $userData');

  final file = File('path/to/image.png');
  final xFile = XFile(file.path);
  final uploadResponse = await imageService.uploadFile(
    file: xFile,
    endPoint: 'upload/image',
  );
  print('Upload Response: $uploadResponse');
}

class RestApiConfigConst {
  static const BASE_URL = 'https://api.example.com/';
  static const API_KEY = 'xyz-123-token';
}
