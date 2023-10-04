import 'dart:convert';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;
import 'package:socialrecipe/src/group_model.dart';

class ApiClient{
  final int timeoutInSeconds = 30;
  List<GroupModel>? officeBearers;

  Future<Response> getData(String uri) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri');
      }
      Http.Response _response = await Http.get(
          Uri.parse(uri),
      ).timeout(Duration(seconds: timeoutInSeconds));
      print(_response.body);
      return handleResponse(_response, uri);
    } catch (e) {
      print('------------${e.toString()}');
      return Response(statusCode: 1, statusText: "Connection to server failed");
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        // ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
          statusCode: _response.statusCode,
          body: _response.body,
        );
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: "No Internet");
    }
    if (Foundation.kDebugMode) {
      print(
          '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    }
    return _response;
  }

  Future<List<GroupModel>> getOfficeBearersList() async {
    // _isLoading = false;
    // _transactionList = [];
    Response response = await getData("http://ahar.ezii.live/api/get-office-bearer");
    if (response.statusCode == 200) {

      final Iterable refactorProductList = response.body!["data"] ?? [];
      officeBearers = refactorProductList.map((item) {
        return GroupModel.fromJson(item);
      }).toList();

      print(officeBearers);
      // _isLoading = true;

    } else {
      // ApiChecker.checkApi(response);
    }
    // update();
    return officeBearers!;
  }

  Future<List<GroupModel>> getZoneList() async {
    // _isLoading = false;
    // _transactionList = [];
    Response response = await getData("http://ahar.ezii.live/api/get-members");
    if (response.statusCode == 200) {

      final Iterable refactorProductList = response.body!["data"] ?? [];
      officeBearers = refactorProductList.map((item) {
        return GroupModel.fromJson(item);
      }).toList();

      print(officeBearers);
      // _isLoading = true;

    } else {
      // ApiChecker.checkApi(response);
    }
    // update();
    return officeBearers!;
  }

  Future<List<GroupModel>> getSubCommiteList() async {
    // _isLoading = false;
    // _transactionList = [];
    Response response = await getData("http://ahar.ezii.live/api/get-committe-members");
    if (response.statusCode == 200) {

      final Iterable refactorProductList = response.body!["data"] ?? [];
      officeBearers = refactorProductList.map((item) {
        return GroupModel.fromJson(item);
      }).toList();

      print(officeBearers);
      // _isLoading = true;

    } else {
      // ApiChecker.checkApi(response);
    }
    // update();
    return officeBearers!;
  }



}