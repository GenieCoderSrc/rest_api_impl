import 'package:cross_file/cross_file.dart';

abstract class IImageServiceRestApiDataSource {
  Future<String?> uploadFile({
    required XFile file,
    required String endPoint,
    Map<String, dynamic>? queryParams,
    String? fileName,
    String? accessToken,
    String imgFieldName = 'image',
    String urlFieldName = 'url',
  });

  Future<bool> deleteFile({required String endPoint, String? accessToken});
}
