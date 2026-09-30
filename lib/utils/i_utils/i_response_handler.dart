abstract class IResponseHandler<TResponse> {
  Map<String, dynamic>? handleResponse(dynamic response);
}
