import 'dart:io';

import 'package:async/async.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

enum Exceptions { socketErr, serverErr, err, noData, authError }

class HttpReq {
  static final HttpReq _instance = HttpReq._internal();

  factory HttpReq() => _instance;

  HttpReq._internal();

  static const String _appJson = 'application/json';

  static String _fetchUrl(String endPoint) {
    return "http://mockup.aabasoft.info/SampleprojectAPI/$endPoint";
  }

  static Future<Result> postRequest(String endpoint, {Map? parameters}) async {
    try {
      var response = await http
          .post(
            Uri.parse(_fetchUrl(endpoint)),
            headers: {
              HttpHeaders.acceptHeader: _appJson,
              HttpHeaders.contentTypeHeader: _appJson,
            },
            body: parameters != null ? json.encode(parameters) : null,
          )
          .timeout(const Duration(seconds: 60));

      return _returnResponse(response);
    } on SocketException {
      return Result.error(Exceptions.socketErr);
    } on ServerSocket {
      return Result.error(Exceptions.serverErr);
    } on FormatException {
      return Result.error(Exceptions.err);
    } on HandshakeException {
      return Result.error(Exceptions.serverErr);
    } on Exception {
      return Result.error(Exceptions.serverErr);
    }
  }

  static Result _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dev.log(jsonDecode(response.body).toString(), name: 'Status: 200');
        return Result.value(jsonDecode(response.body));
      case 400:
        dev.log(jsonDecode(response.body).toString(), name: 'Status: 400');
        return Result.error(response.body);
      case 401:
        dev.log(jsonDecode(response.body).toString(), name: 'Status: 401');
        return Result.error(Exceptions.err);
      case 403:
        dev.log(jsonDecode(response.body).toString(), name: 'Status: 403');
        return Result.error(Exceptions.err);
      case 500:
        dev.log(jsonDecode(response.body).toString(), name: 'Status: 500');
        return Result.error(Exceptions.serverErr);
      default:
        dev.log(jsonDecode(response.body).toString(),
            name: 'Error: ${response.statusCode}');
        return Result.error(Exceptions.err);
    }
  }
}
