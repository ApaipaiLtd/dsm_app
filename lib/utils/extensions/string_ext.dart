import 'dart:convert';

extension NumExt on String {
  String subStr(int start, [int end = 0]) {
    return substring(start < 0 ? length + start : start, end < 0 ? length + end : end);
  }

  /*
  * Base64加密
  */
  String get encodeBase64 {
    var digest = base64Encode(utf8.encode(this));
    return digest;
  }

  /*
  * Base64解密
  */
  String get decodeBase64 {
    return String.fromCharCodes(base64Decode(this));
  }
}
