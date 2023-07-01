import 'package:dsm_app/apis/api.dart';

/// maxVersion : 6
/// minVersion : 1
/// path : "auth.cgi"

class ApiModel {
  ApiModel({
    this.maxVersion,
    this.minVersion,
    this.path,
  });
  static Map<String, ApiModel> apiInfo = {};
  static Future<Map<String, ApiModel>> info() async {
    Map<String, ApiModel> apis = {};
    Map res = await Api.dsm.post("/webapi/query.cgi", data: {
      "query": "all",
      "api": "SYNO.API.Info",
      "method": "query",
      "version": 1,
    });
    if (res['success']) {
      res['data'].forEach((key, value) {
        apis[key] = ApiModel.fromJson(value);
      });
    } else {}

    return apis;
  }

  ApiModel.fromJson(dynamic json) {
    maxVersion = json['maxVersion'];
    minVersion = json['minVersion'];
    path = json['path'];
  }
  num? maxVersion;
  num? minVersion;
  num get version => maxVersion ?? minVersion ?? 1;
  String? path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['maxVersion'] = maxVersion;
    map['minVersion'] = minVersion;
    map['path'] = path;
    return map;
  }
}
