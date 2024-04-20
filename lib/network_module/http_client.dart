import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:network_library_provider/network_module/app_exceptions.dart';
import 'package:network_library_provider/network_module/environment_config.dart';

class HttpClient {
  static final HttpClient _singleton = HttpClient();
  static const int TIME_OUT_DURATION = 45;
  static String baseUrl = Environment().config!.baseUrl;

  static HttpClient get instance => _singleton;

  // Future<dynamic> fetchData(String url, {required Map<String, String> params})async{
  //   var responseJson;

  //   var uri =
  // }

  Future<dynamic> get(String api) async {
    // ignore: non_constant_identifier_names

    // String accessKey = Environment().config!.accessKey;
    // String accessKeyProperty = Environment().config!.accessKeyProperty;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // accessKeyProperty: accessKey,

      // "Authorization": "Bearer $_token",
    };
    var url = Uri.parse(baseUrl + api);
    try {
      var response = await http.get(url, headers: requestHeaders).timeout(
            const Duration(seconds: TIME_OUT_DURATION),
          );
      // print(jsonDecode(response.body));
      // print(response.statusCode);
      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  Future<dynamic> getWithBearer(String api) async {
    // print(baseUrl);
    // Timer? timer;
    var token = GetStorage().read('token');

    // String accessKey = Environment().config!.accessKey;
    // String accessKeyProperty = Environment().config!.accessKeyProperty;

    // ignore: non_constant_identifier_names
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      // accessKeyProperty: accessKey,
    };

    // print(token);
    // print(accessKey);
    // print(accessKeyProperty);

    // print(requestHeaders);
    var url = Uri.parse(baseUrl + api);
    // print(url);
    try {
      var response = await http.get(url, headers: requestHeaders).timeout(
            const Duration(seconds: TIME_OUT_DURATION),
          );
      // print(response.body);
      // print(response.statusCode);
      return _processResponse(response);
    } on TimeoutException {
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on UnAuthorizedException {
      // if (getx.Get.isDialogOpen! == false) {
      //   DialogHelper.showErrorDialog(
      //       desc: 'UnAuthorized',
      //       press: () {
      //         // timer?.cancel();
      //         GetStorage()
      //             .erase()
      //             .whenComplete(() => getx.Get.offAll(SignInScreen()));
      //         // if (message.toString().contains('Unauthorized')) {
      //         //   // LogOut().logout();
      //         //   print(timer!.isBlank);

      //         // } else {
      //         //   if (Get.isDialogOpen!) Get.back();
      //         // }
      //         // Get.offAll(SignInScreen());
      //       });
      // }
    }
  }

  // Post SignUP
  Future<dynamic> postSignUp(String api, dynamic payloadObj) async {
    var url = Uri.parse(baseUrl + api);

    // String accessKey = Environment().config!.accessKey;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // accessKeyProperty: accessKey,
    };

    var payload = json.encode(payloadObj);

    // print('coming from here $url');
    // print(payload);

    try {
      var response =
          await http.post(url, headers: requestHeaders, body: payload).timeout(
                const Duration(seconds: TIME_OUT_DURATION),
              );
      // print(response.statusCode);
      // print(response.body);
      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  // PostOthers
  Future<dynamic> post(String api, dynamic payloadObj) async {
    // var _token = GetStorage().read('token');
    // String accessKey = Environment().config!.accessKey;

    var url = Uri.parse(baseUrl + api);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // "Authorization": "Bearer $_token",
      // accessKeyProperty: accessKey,
    };

    var payload = json.encode(payloadObj);
    try {
      var response =
          await http.post(url, headers: requestHeaders, body: payload).timeout(
                const Duration(seconds: TIME_OUT_DURATION),
              );
      // print(response.statusCode);
      // print(response.body);

      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  // PostOthers
  Future<dynamic> postWithBearer(String api, dynamic payloadObj) async {
    var token = GetStorage().read('token');
    // String accessKey = Environment().config!.accessKey;

    var url = Uri.parse(baseUrl + api);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      // accessKeyProperty: accessKey,
    };

    // print(payloadObj);
    var payload = json.encode(payloadObj);
    // print("track payload $payload");
    // print(_token);
    try {
      var response =
          await http.post(url, headers: requestHeaders, body: payload).timeout(
                const Duration(seconds: TIME_OUT_DURATION),
              );
      // print(response.statusCode);
      // print(response.body);

      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // print(response);
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  // Delete

  // Others
  Future<dynamic> putRequest(String api, dynamic payloadObj) async {
    var url = Uri.parse(baseUrl + api);
    // String accessKey = Environment().config!.accessKey;

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // accessKeyProperty: accessKey,
    };

    var payload = json.encode(payloadObj);

    // print(url);
    // print(payload);

    try {
      var response =
          await http.put(url, headers: requestHeaders, body: payload).timeout(
                const Duration(seconds: TIME_OUT_DURATION),
              );
      // print(response.statusCode);
      // print(response.body);
      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  Future<dynamic> putWithBearer(String api, dynamic payloadObj) async {
    var url = Uri.parse(baseUrl + api);
    // String accessKey = Environment().config!.accessKey;

    var token = GetStorage().read('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      // accessKeyProperty: accessKey,
    };

    var payload = json.encode(payloadObj);

    // print(url);
    // print(payload);

    try {
      var response =
          await http.put(url, headers: requestHeaders, body: payload).timeout(
                const Duration(seconds: TIME_OUT_DURATION),
              );
      // print(response.statusCode);
      // print(response.body);
      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  Future<dynamic> deleteWithBearer(String api, {dynamic payloadObj}) async {
    // String accessKey = Environment().config!.accessKey;
    // var token = GetStorage().read('token');

    // var url = Uri.parse(baseUrl + api);
    // Map<String, String> requestHeaders = {
    //   'Content-type': 'application/json',
    //   'Accept': 'application/json',
    //   "Authorization": "Bearer $token",
    // accessKeyProperty: accessKey,
    // };

    // // print(url);
    // print(baseUrl);

    var token = GetStorage().read('token');

    // String accessKey = Environment().config!.accessKey;
    // String accessKeyProperty = Environment().config!.accessKeyProperty;

    // ignore: non_constant_identifier_names
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      // accessKeyProperty: accessKey,
    };

    // print(requestHeaders);
    var url = Uri.parse(baseUrl + api);
    // print(url);

    var payload = payloadObj != null ? json.encode(payloadObj) : null;

    try {
      var response = await http
          .delete(url, headers: requestHeaders, body: payload)
          .timeout(
            const Duration(seconds: TIME_OUT_DURATION),
          );
      // print(response.statusCode);
      // print(response.body);
      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  Future<dynamic> putWithBearerNoPayload(String api) async {
    // String accessKey = Environment().config!.accessKey;
    var token = GetStorage().read('token');

    var url = Uri.parse(baseUrl + api);
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      // accessKeyProperty: accessKey,
    };

    // print(_token);

    try {
      var response = await http
          .put(
            url,
            headers: requestHeaders,
          )
          .timeout(
            const Duration(seconds: TIME_OUT_DURATION),
          );
      // print('response: ${utf8.decode(response.bodyBytes)}');
      // print(response.body);
      return _processResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', url.toString());
      // if (getx.Get.isDialogOpen!) {
      //   getx.Get.back();
      // }
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    }
  }

  //Upload images
  Future uploadImages(String api, List<File?> files) async {
    // String accessKey = Environment().config!.accessKey;
    var token = GetStorage().read('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      // accessKeyProperty: accessKey,
    };
    // showLoading();

    String link = baseUrl + api;

    var formData = FormData();

    try {
      for (var file in files) {
        formData.files.addAll([
          MapEntry("attachments", await MultipartFile.fromFile(file!.path)),
        ]);
      }
      // print(formData);
      var response = await Dio()
          .post(link,
              options: Options(
                  headers: requestHeaders, responseType: ResponseType.bytes),
              data: formData)
          .timeout(
            const Duration(seconds: TIME_OUT_DURATION),
          );
      // print(response.statusCode);
      // print(response.data);
      // print(response);
      return _processDioResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', link.toString());
    } on SocketException {
      throw FetchDataException('No Internet Connection', link.toString());
    }
  }

  Future uploadSingleImage(String api, File? file) async {
    // String accessKey = Environment().config!.accessKey;
    var token = GetStorage().read('token');

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token",
      // accessKeyProperty: accessKey,
    };
    // showLoading();

    String link = baseUrl + api;

    var formData = FormData();

    try {
      formData.files.add(
          MapEntry("attachments", await MultipartFile.fromFile(file!.path)));
      //   for (var file in files) {
      //     formData.files.addAll([
      //       MapEntry("attachments", await MultipartFile.fromFile(file!.path)),
      //     ]);
      //   }
      // print(formData);
      var response = await Dio()
          .post(link,
              options: Options(
                  headers: requestHeaders, responseType: ResponseType.bytes),
              data: formData)
          .timeout(
            const Duration(seconds: TIME_OUT_DURATION),
          );
      // print(response.statusCode);
      // print(response.data);
      // print(response);
      return _processDioResponse(response);
    } on TimeoutException {
      ApiNotRespondingException('Session Timeout', link.toString());
    } on SocketException {
      throw FetchDataException('No Internet Connection', link.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        // print(responseJson);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        // print(responseJson);

        return responseJson;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 401:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 402:
        throw UnprocessableEntity(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 404:
        throw PageNotFoundException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 422:
        throw UnprocessableEntity(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 503:
        throw ServerException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 500:
        throw ServerException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      default:
        throw Exception(
          'Error: ${response.statusCode} \n Server Error',
          // 'Error occured with code: ${response.statusCode} ${utf8.decode(response.bodyBytes)}',
        );
    }
  }

  dynamic _processDioResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = (response.statusMessage);
        // print(responseJson);
        return responseJson;
      case 201:
        var responseJson = utf8.decode(response.data);

        return responseJson;
      case 400:
        throw BadRequestException(
            (response.statusMessage), response.realUri.path);
      case 401:
        throw UnprocessableEntity(
            (response.statusMessage), response.realUri.path);
      case 402:
        throw UnprocessableEntity(
            (response.statusMessage), response.realUri.path);
      case 403:
        throw UnAuthorizedException(
            (response.statusMessage), response.realUri.path);
      case 404:
        throw PageNotFoundException(
            (response.statusMessage), response.realUri.path);
      case 422:
        throw UnprocessableEntity(
            (response.statusMessage), response.realUri.path);
      case 503:
        throw ServerException((response.statusMessage), response.realUri.path);
      case 500:
      default:
        throw UnAuthorizedException(
            'Error: ${response.statusCode} \n Server Error',
            // 'Error occured with code: ${response.statusCode} ${utf8.decode(response.bodyBytes)}',
            response.realUri.path);
    }
  }
}
