import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart';
import 'package:project_flutter/utils/base_components.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/shared_preference_util.dart';
import 'package:project_flutter/utils/url_util.dart';


class Method {
  static const get = 'get';
  static const post = 'post';
  static const put = 'put';
  static const delete = 'delete';
}

enum InternetStatus {
  connected,
  notconnected,
}

Map<String, String> _requestHeaders = {
  "Accept": "application/json",
  "Content-Type": "application/json"
};


class BaseProvider extends BaseComponents{
  static const  TIME_OUT = 15;

  Future<BaseModelApi?> fetchApiUtil({
    String method = Method.post,
    required String nameApi,
    Map<String, dynamic>? body
  }) async {
    try {
      if (![Method.get, Method.post, Method.put, Method.delete]
          .any((element) => method == element)) throw ('method is not valid');
      var response;
      try {
        var uri = Uri.parse('${UrlUtil.domain}/$nameApi');

         var request = await Request(
          method,
          uri,
        );
        request.headers.addAll(_requestHeaders);
        String? token = await SharedPreferenceUtil().getStringSharePreference(key:
        SharedPreferenceUtil.accessToken);

        if (token != null)
          print(token);
          request.headers.addAll({'Authorization': 'Bearer $token'});
          // request.headers.addAll({'Authorization': '$token'});
        if (body != null) {
          request.body = jsonEncode(body);
        }
         response = await request.send().timeout(const Duration(seconds: TIME_OUT));
    } on TimeoutException catch (_) {
        // A timeout occurred.
        print('timeout request');
        // Navigator.pop(context);

        return new BaseModelApi(statusCode: UrlUtil.statusTimeOut, body: UrlUtil.timeOut);
    } on SocketException catch (_) {
    // Other exception
    }

      if (response.statusCode == UrlUtil.tokenExpired) {
        /// handle token expired
      }
      BaseModelApi model = new BaseModelApi(statusCode: response.statusCode, body: await response.stream.bytesToString());

      return model;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<BaseModelApi?> fetchApiAddressUtil({
    String method = Method.get,
    required String url,
    Map<String, dynamic>? body
  }) async {
    try {
      if (![Method.get, Method.post, Method.put, Method.delete]
          .any((element) => method == element)) throw ('method is not valid');
      var response;
      try {
        var uri = Uri.parse('${UrlUtil.domainAddressApi}/$url');

        var request = await Request(
          method,
          uri,
        );
        request.headers.addAll(_requestHeaders);
        // if (token != null)
        //   request.headers.addAll({'Authorization': 'Bearer $token'});
        if (body != null) {
          request.body = jsonEncode(body);
        }
        response = await request.send().timeout(const Duration(seconds: TIME_OUT));
      } on TimeoutException catch (_) {
        // A timeout occurred.
        print('timeout request');
        // Navigator.pop(context);

        return new BaseModelApi(statusCode: UrlUtil.statusTimeOut, body: UrlUtil.timeOut);
      } on SocketException catch (_) {
        // Other exception
      }

      if (response.statusCode == UrlUtil.tokenExpired) {
        /// handle token expired
      }
      BaseModelApi model = new BaseModelApi(statusCode: response.statusCode, body: await response.stream.bytesToString());

      return model;
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<BaseModelApi?> fetchApiWithParam(
      {String method = Method.get,
        required String nameApi,
        Map<String, String>? params}) async {
    Map<String, String> _requestHeaders = {
      "Accept": "application/json",
    };
    if (![Method.get, Method.post, Method.put, Method.delete]
        .any((element) => method == element)) throw ('method is not valid');
    var response;
    try {
      // final uri = Uri.https(UrlUtil.domainWithParam, '/${UrlUtil.paramBe}/$nameApi', params);
      final uri =
      Uri.http(UrlUtil.domainWthParam, '/$nameApi', params);

      var request = await new MultipartRequest(method, uri);
      request.headers.addAll(_requestHeaders);

      String? token = await SharedPreferenceUtil()
          .getStringSharePreference(key: SharedPreferenceUtil.accessToken);
      if (token != null)
        request.headers.addAll({'Authorization': 'Bearer $token'});

      response =
      await request.send().timeout(const Duration(seconds: TIME_OUT));
      BaseModelApi model = new BaseModelApi(
          statusCode: response.statusCode,
          body: await response.stream.bytesToString());
      return model;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      print('timeout request');
      // Navigator.pop(context);

      return new BaseModelApi(
          statusCode: UrlUtil.statusTimeOut, body: UrlUtil.timeOut);
    } on SocketException catch (_) {
      // Other exception
    }

    if (response.statusCode == UrlUtil.tokenExpired) {
      /// handle token expired
    }
    BaseModelApi model = new BaseModelApi(
        statusCode: response.statusCode,
        body: await response.stream.bytesToString());

    return model;
  }

  Future<BaseModelApi?> fetchApiWithId(
      {String method = Method.get,
        required String nameApi,
        required int id}) async {
    Map<String, String> _requestHeaders = {
      "Accept": "application/json",
    };
    if (![Method.get, Method.post, Method.put, Method.delete]
        .any((element) => method == element)) throw ('method is not valid');
    var response;
    try {
      // final uri = Uri.https(UrlUtil.domainWithParam, '/${UrlUtil.paramBe}/$nameApi/$id');
      final uri = Uri.http(UrlUtil.domainWthParam, '/api/$nameApi/$id');

      var request = await new MultipartRequest(method, uri);
      request.headers.addAll(_requestHeaders);

      String? token = await SharedPreferenceUtil()
          .getStringSharePreference(key: SharedPreferenceUtil.accessToken);
      if (token != null)
        request.headers.addAll({'Authorization': 'Bearer $token'});

      response =
      await request.send().timeout(const Duration(seconds: TIME_OUT));
      BaseModelApi model = new BaseModelApi(
          statusCode: response.statusCode,
          body: await response.stream.bytesToString());
      return model;
    } on TimeoutException catch (_) {
      // A timeout occurred.
      print('timeout request');
      // Navigator.pop(context);

      return new BaseModelApi(
          statusCode: UrlUtil.statusTimeOut, body: UrlUtil.timeOut);
    } on SocketException catch (_) {
      // Other exception
    }

    if (response.statusCode == UrlUtil.tokenExpired) {
      /// handle token expired
    }
    BaseModelApi model = new BaseModelApi(
        statusCode: response.statusCode,
        body: await response.stream.bytesToString());

    return model;
  }

}


