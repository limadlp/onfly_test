import 'dart:io';
import 'package:onfly_api/routes.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

void main() async {
  // Set up middleware and routing
  final handler = const Pipeline()
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests()) // Logs all incoming requests
      .addHandler(setupRoutes().call); // Handles routing

  // Start the server
  final server = await io.serve(handler, InternetAddress.anyIPv4, 5000);
  print('✅ Server is running at http://${server.address.host}:${server.port}');
}
