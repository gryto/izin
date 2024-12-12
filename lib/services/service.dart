

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../utils/constants/constantVar.dart';

class Request {
  static Future<http.Response?> req(
      {required String path,
      Map<String, dynamic>? params,
      Map? body,
      String? token,
      required String method}) async {
    final url = Uri.https(Url.base, path, params);
    try {
      switch (method) {
        case 'post':
          var response = await http.post(url,
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${token ?? ''}'
              },
              body: jsonEncode(body ?? ''));
          return response;
        case 'get':
          var response = await http.get(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${token ?? ''}'
            },
          );
          return response;
        default:
      }
    } on Exception catch (e) {
      if (e is ClientException) {
        Map body = {"message": e.message};
        return Response(jsonEncode(body), 400);
      } else if (e is SocketException) {
        Map body = {"message": e.message};
        return Response(jsonEncode(body), 400);
      } else {
        Map body = {"message": e};
        return Response(jsonEncode(body), 400);
      }
    }
    return null;
  }

  
}
