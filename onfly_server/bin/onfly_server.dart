import 'dart:io';
import 'package:onfly_api/presentation/handlers.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router =
      Router()
        ..post('/login', loginHandler)
        ..get('/expenses', getExpensesHandler)
        ..post('/expenses', addExpenseHandler);

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 5000);
  print('Server running on http://${server.address.host}:${server.port}');
}
