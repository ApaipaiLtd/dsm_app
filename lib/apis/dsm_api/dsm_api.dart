import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsm_app/apis/dsm_api/dsm_resopnse.dart';
import 'package:dsm_app/models/api_model.dart';
import 'package:dsm_app/utils/http_util.dart';
import 'package:dsm_app/utils/util.dart';

class DsmApi extends HttpUtil {
  DsmApi({String baseUrl = ""}) {
    super.init(baseUrl);
  }

  Future<DsmResponse> entry<T>(
    String api,
    String method, {
    bool post = false,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    required T Function(dynamic) parser,
  }) async {
    late Response response;
    data = data ?? {};
    data['version'] = ApiModel.apiInfo['SYNO.API.Auth']?.version;
    data['api'] = api;
    data['method'] = method;
    if (post) {
      response = await dio!.post("/webapi/entry.cgi", data: data, queryParameters: parameters, options: options);
    } else {
      response = await dio!.get("/webapi/entry.cgi", queryParameters: parameters, options: options);
    }

    DsmResponse res = DsmResponse.fromJson(response.data, parser);
    return res;
  }
}
