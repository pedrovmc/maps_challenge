import 'package:dio/dio.dart';
import 'package:maps_challenge/app/core/consts.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['auth_required'] == true) {
      options.queryParameters.addAll({"key": apiKey});
    }
    handler.next(options);
  }
}
