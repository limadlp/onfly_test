import 'dart:io';
import 'package:onfly_api/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

void main() async {
  // Set up middleware and routing
  final handler = Pipeline()
      .addMiddleware(logRequests()) // Logs all incoming requests
      .addHandler(setupRoutes().call); // Handles routing

  // Start the server
  final server = await io.serve(handler, InternetAddress.anyIPv4, 5000);
  print('✅ Server is running at http://${server.address.host}:${server.port}');
}
