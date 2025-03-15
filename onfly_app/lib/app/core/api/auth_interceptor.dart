// class AuthInterceptor extends Interceptor {
//   @override
//   Future onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final prefs = await SharedPrefsRepository.instance;
//     String token = prefs.accessToken;

//     if (token.isNotEmpty) {
//       options.headers['Authorization'] = token;
//     }

//     if (Constants.isDevelopment) {
//       // ignore: avoid_print
//       print('Requisição feita');
//     }

//     return handler.next(options);
//   }

//   @override
//   Future<void> onResponse(
//       Response response, ResponseInterceptorHandler handler) async {
//     return handler.next(response);
//   }

//   @override
//   Future onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     var statusCode = err.response?.statusCode;

//     if (statusCode == 401 ||
//         // statusCode == 403 ||
//         err.message == 'Network Error') {
//       await SharedPrefsRepository.clearAll();
//       Modular.to.navigate("/auth/");
//       //AsukaSnackbar.alert('Não autorizado!').show();
//     }

//     // ignore: avoid_print
//     print('error: ${err.response} ');
//     //return throw(err);
//     return handler.next(err);
//   }
// }
