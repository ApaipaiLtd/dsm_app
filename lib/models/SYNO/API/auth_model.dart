/// account : "yaoshuwei"
/// device_id : "gM4De7c5C3-rtaJ0X-JRr-mBgsefCqHkvoIw4-NLI5m-3wVTfrZMeLLw783JOiR6OPUVaIchg9uRy5M0aDzmPA"
/// ik_message : ""
/// is_portal_port : false
/// sid : "jGm0RS1X0YxlzxFbu5Gm6LWSrULiNjL7ZPbfYzvJshEHwZQN2PvTpH5wjc1YRnEvGj9df3-Vh4D2WN1eAQ5s4A"
/// synotoken : "--------"

class AuthModel {
  AuthModel({
    this.account,
    this.deviceId,
    this.ikMessage,
    this.isPortalPort,
    this.sid,
    this.synotoken,
  });

  AuthModel.fromJson(dynamic json) {
    account = json['account'];
    deviceId = json['device_id'];
    ikMessage = json['ik_message'];
    isPortalPort = json['is_portal_port'];
    sid = json['sid'];
    synotoken = json['synotoken'];
  }
  String? account;
  String? deviceId;
  String? ikMessage;
  bool? isPortalPort;
  String? sid;
  String? synotoken;
  AuthModel copyWith({
    String? account,
    String? deviceId,
    String? ikMessage,
    bool? isPortalPort,
    String? sid,
    String? synotoken,
  }) =>
      AuthModel(
        account: account ?? this.account,
        deviceId: deviceId ?? this.deviceId,
        ikMessage: ikMessage ?? this.ikMessage,
        isPortalPort: isPortalPort ?? this.isPortalPort,
        sid: sid ?? this.sid,
        synotoken: synotoken ?? this.synotoken,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = account;
    map['device_id'] = deviceId;
    map['ik_message'] = ikMessage;
    map['is_portal_port'] = isPortalPort;
    map['sid'] = sid;
    map['synotoken'] = synotoken;
    return map;
  }
}
