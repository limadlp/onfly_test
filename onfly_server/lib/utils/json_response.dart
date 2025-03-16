import 'dart:convert';
import 'package:shelf/shelf.dart';

Response jsonResponse(
  Map<String, dynamic> data, {
  int statusCode = 200,
  Map<String, String>? headers,
}) {
  return Response(
    statusCode,
    body: jsonEncode(data),
    headers: {'Content-Type': 'application/json', ...?headers},
  );
}
