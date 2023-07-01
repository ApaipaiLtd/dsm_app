import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dsm_app/apis/api.dart';

/// command : "get_server_info"
/// env : {"control_host":"cnc.quickconnect.cn","relay_region":"cn3"}
/// errno : 0
/// server : {"ddns":"NULL","ds_state":"CONNECTED","external":{"ip":"113.120.111.99","ipv6":"::"},"fqdn":"NULL","gateway":"192.168.0.1","interface":[{"ip":"192.168.0.135","ipv6":[],"mask":"255.255.255.0","name":"eth0"}],"ipv6_tunnel":[],"pingpong_path":"/webman/pingpong.cgi?action=cors&quickconnect=true","redirect_prefix":"","serverID":"080506116","tcp_punch_port":0,"udp_punch_port":54347}
/// service : {"port":5001,"ext_port":0,"pingpong":"DISCONNECTED","pingpong_desc":[],"relay_ip":"103.78.228.13","relay_dn":"synr-cn3.YAOSHUWEI.direct.quickconnect.cn","relay_port":56839,"https_ip":"103.78.228.13","https_port":443}
/// smartdns : {"host":"YAOSHUWEI.direct.quickconnect.cn","lan":["192-168-0-135.YAOSHUWEI.direct.quickconnect.cn"],"hole_punch":"127-0-0-1.YAOSHUWEI.direct.quickconnect.cn"}
/// version : 1

class QcidModel {
  QcidModel({
    this.command,
    this.env,
    this.errno,
    this.errinfo,
    this.server,
    this.service,
    this.smartDns,
    this.version,
  });
  static Future<String?> pingpong(List<String> domains, bool ssl) async {
    final completer = Completer<String>();
    for (String domain in domains) {
      try {
        Api.dsm
            .get("${ssl ? 'https' : 'http'}://$domain/webman/pingpong.cgi",
                options: Options(
                  headers: {"referer": domain},
                ))
            .then((res) {
          res = jsonDecode(res);
          if (res != null && res['success']) {
            completer.complete(domain);
          }
        });
      } catch (e) {}
    }
    return completer.future;
  }

  static Future<List<String>> getRealHostByQcId(String qcId, {String domain = "global.quickconnect.cn"}) async {
    List<QcidModel> qcidModel = [];
    Set<String> qcAddressSet = {};
    List<Map<String, dynamic>> data = [
      {"version": 1, "command": "get_server_info", "stop_when_error": false, "stop_when_success": false, "id": "dsm_portal_https", "serverID": qcId, "is_gofile": false},
      {"version": 1, "command": "get_server_info", "stop_when_error": false, "stop_when_success": false, "id": "dsm_portal", "serverID": qcId, "is_gofile": false}
    ];
    var res = await Api.dsm.post("https://$domain/Serv.php", data: jsonEncode(data));
    try {
      List result = jsonDecode(res);
      for (var element in result) {
        qcidModel.add(QcidModel.fromJson(element));
      }
      for (var item in qcidModel) {
        if (item.errno == 0) {
          if (item.server?.fqdn != "NULL") {
            qcAddressSet.add("${item.server!.fqdn!}");
          }
          if (item.env?.relayRegion != null && item.env?.controlHost != null) {
            List<String> pieces = item.env!.controlHost!.split(".");
            pieces[0] = item.env!.relayRegion!;
            qcAddressSet.add("$qcId.${pieces.join(".")}");
          }
          if (item.server?.external?.ip != null) {
            qcAddressSet.add("${item.server!.external!.ip!}:${item.service!.extPort}");
          }
          if (item.service?.relayIp != null) {
            qcAddressSet.add("${item.service!.relayIp!}:${item.service!.relayPort}");
          }
          if (item.server!.ddns != "NULL") {
            qcAddressSet.add("${item.server!.ddns!}:${item.service!.extPort}");
          }
          if ((item.server?.interface?.length ?? 0) > 0) {
            for (var interface in item.server!.interface!) {
              qcAddressSet.add("${interface.ip}:${item.service!.port}");
              if ((interface.ipv6?.length ?? 0) > 0) {
                for (var v6 in interface.ipv6!) {
                  qcAddressSet.add("[${v6.address}]:${item.service!.port}");
                }
              }
            }
          }
          if (item.service?.relayIp == null) {
            // List<String> cnAddresses = await getRealHostByQcId(qcId, domain: res['env']['control_host']);
            // qcAddresses.addAll(cnAddresses);
          }
        } else if (item.errno == 4 && item.errinfo != null) {
          RegExp pattern = RegExp(r'get_server_info.go:(\d+)\[(.+)\]');
          Match? match = pattern.firstMatch(item.errinfo!);
          if (match != null) {
            String errorCode = match.group(1)!;
            String errorMessage = match.group(2)!;
            print("errorCode: $errorCode");
            print("Error message: $errorMessage");
            if (errorCode == '69') {
              throw FormatException("QuickConnect ID 不正确或不存在。请重试，或转到“控制面板”>“QuickConnect”>“常规”以检查您的 QuickConnect ID。");
            } else if (errorCode == '79') {
              throw FormatException("基于安全考量，已暂停您的 QuickConnect 服务。请前往 account.synology.cn 完成验证流程。");
            } else {
              throw FormatException("QuickConnect访问错误，代码：$errorCode，描述：$errorMessage");
            }
          } else {
            throw FormatException("通过QCID获取服务器地址失败");
          }
        } else {
          throw FormatException("无法连接到服务器，请检查QuickConnect ID是否正确");
        }
      }
    } on TypeError catch (e) {
      print(e.runtimeType);
      print(e.stackTrace);
    }

    return qcAddressSet.toList();
  }

  QcidModel.fromJson(dynamic json) {
    command = json['command'];
    env = json['env'] != null ? Env.fromJson(json['env']) : null;
    errno = json['errno'];
    server = json['server'] != null ? Server.fromJson(json['server']) : null;
    service = json['service'] != null ? Service.fromJson(json['service']) : null;
    smartDns = json['smartdns'] != null ? SmartDns.fromJson(json['smartdns']) : null;
    version = json['version'];
  }
  String? command;
  Env? env;
  num? errno;
  String? errinfo;
  Server? server;
  Service? service;
  SmartDns? smartDns;
  num? version;
  List<String> qcAddresses = [];
  QcidModel copyWith({
    String? command,
    Env? env,
    num? errno,
    Server? server,
    Service? service,
    SmartDns? smartDns,
    num? version,
  }) =>
      QcidModel(
        command: command ?? this.command,
        env: env ?? this.env,
        errno: errno ?? this.errno,
        errinfo: errinfo ?? this.errinfo,
        server: server ?? this.server,
        service: service ?? this.service,
        smartDns: smartDns ?? this.smartDns,
        version: version ?? this.version,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['command'] = command;
    if (env != null) {
      map['env'] = env?.toJson();
    }
    map['errno'] = errno;
    if (server != null) {
      map['server'] = server?.toJson();
    }
    if (service != null) {
      map['service'] = service?.toJson();
    }
    if (smartDns != null) {
      map['smartdns'] = smartDns?.toJson();
    }
    map['version'] = version;
    return map;
  }
}

class Ipv6 {
  Ipv6({
    this.address,
  });

  Ipv6.fromJson(dynamic json) {
    address = json['address'];
  }
  String? address;
  Ipv6 copyWith({
    String? address,
  }) =>
      Ipv6(
        address: address ?? this.address,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['host'] = address;
    return map;
  }
}

/// host : "YAOSHUWEI.direct.quickconnect.cn"
/// lan : ["192-168-0-135.YAOSHUWEI.direct.quickconnect.cn"]
/// hole_punch : "127-0-0-1.YAOSHUWEI.direct.quickconnect.cn"

class SmartDns {
  SmartDns({
    this.host,
    this.lan,
    this.holePunch,
  });

  SmartDns.fromJson(dynamic json) {
    host = json['host'];
    lan = json['lan'] != null ? json['lan'].cast<String>() : [];
    holePunch = json['hole_punch'];
  }
  String? host;
  List<String>? lan;
  String? holePunch;
  SmartDns copyWith({
    String? host,
    List<String>? lan,
    String? holePunch,
  }) =>
      SmartDns(
        host: host ?? this.host,
        lan: lan ?? this.lan,
        holePunch: holePunch ?? this.holePunch,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['host'] = host;
    map['lan'] = lan;
    map['hole_punch'] = holePunch;
    return map;
  }
}

/// port : 5001
/// ext_port : 0
/// pingpong : "DISCONNECTED"
/// pingpong_desc : []
/// relay_ip : "103.78.228.13"
/// relay_dn : "synr-cn3.YAOSHUWEI.direct.quickconnect.cn"
/// relay_port : 56839
/// https_ip : "103.78.228.13"
/// https_port : 443

class Service {
  Service({
    this.port,
    this.extPort,
    this.pingpong,
    this.pingpongDesc,
    this.relayIp,
    this.relayDn,
    this.relayPort,
    this.httpsIp,
    this.httpsPort,
  });

  Service.fromJson(dynamic json) {
    port = json['port'];
    extPort = json['ext_port'];
    pingpong = json['pingpong'];
    if (json['pingpong_desc'] != null) {
      pingpongDesc = json['pingpong_desc'].cast<String>();
    }
    relayIp = json['relay_ip'];
    relayDn = json['relay_dn'];
    relayPort = json['relay_port'];
    httpsIp = json['https_ip'];
    httpsPort = json['https_port'];
  }
  num? port;
  num? extPort;
  String? pingpong;
  List<String>? pingpongDesc;
  String? relayIp;
  String? relayDn;
  num? relayPort;
  String? httpsIp;
  num? httpsPort;
  Service copyWith({
    num? port,
    num? extPort,
    String? pingpong,
    List<String>? pingpongDesc,
    String? relayIp,
    String? relayDn,
    num? relayPort,
    String? httpsIp,
    num? httpsPort,
  }) =>
      Service(
        port: port ?? this.port,
        extPort: extPort ?? this.extPort,
        pingpong: pingpong ?? this.pingpong,
        pingpongDesc: pingpongDesc ?? this.pingpongDesc,
        relayIp: relayIp ?? this.relayIp,
        relayDn: relayDn ?? this.relayDn,
        relayPort: relayPort ?? this.relayPort,
        httpsIp: httpsIp ?? this.httpsIp,
        httpsPort: httpsPort ?? this.httpsPort,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['port'] = port;
    map['ext_port'] = extPort;
    map['pingpong'] = pingpong;
    map['pingpong_desc'] = pingpongDesc;
    map['relay_ip'] = relayIp;
    map['relay_dn'] = relayDn;
    map['relay_port'] = relayPort;
    map['https_ip'] = httpsIp;
    map['https_port'] = httpsPort;
    return map;
  }
}

/// ddns : "NULL"
/// ds_state : "CONNECTED"
/// external : {"ip":"113.120.111.99","ipv6":"::"}
/// fqdn : "NULL"
/// gateway : "192.168.0.1"
/// interface : [{"ip":"192.168.0.135","ipv6":[],"mask":"255.255.255.0","name":"eth0"}]
/// ipv6_tunnel : []
/// pingpong_path : "/webman/pingpong.cgi?action=cors&quickconnect=true"
/// redirect_prefix : ""
/// serverID : "080506116"
/// tcp_punch_port : 0
/// udp_punch_port : 54347

class Server {
  Server({
    this.ddns,
    this.dsState,
    this.external,
    this.fqdn,
    this.gateway,
    this.interface,
    this.ipv6Tunnel,
    this.pingpongPath,
    this.redirectPrefix,
    this.serverID,
    this.tcpPunchPort,
    this.udpPunchPort,
  });

  Server.fromJson(dynamic json) {
    ddns = json['ddns'];
    dsState = json['ds_state'];
    external = json['external'] != null ? External.fromJson(json['external']) : null;
    fqdn = json['fqdn'];
    gateway = json['gateway'];
    if (json['interface'] != null) {
      interface = [];
      json['interface'].forEach((v) {
        interface?.add(Interface.fromJson(v));
      });
    }
    ipv6Tunnel = json['ipv6_tunnel'].cast<String>();
    pingpongPath = json['pingpong_path'];
    redirectPrefix = json['redirect_prefix'];
    serverID = json['serverID'];
    tcpPunchPort = json['tcp_punch_port'];
    udpPunchPort = json['udp_punch_port'];
  }
  String? ddns;
  String? dsState;
  External? external;
  String? fqdn;
  String? gateway;
  List<Interface>? interface;
  List<String>? ipv6Tunnel;
  String? pingpongPath;
  String? redirectPrefix;
  String? serverID;
  num? tcpPunchPort;
  num? udpPunchPort;
  Server copyWith({
    String? ddns,
    String? dsState,
    External? external,
    String? fqdn,
    String? gateway,
    List<Interface>? interface,
    List<String>? ipv6Tunnel,
    String? pingpongPath,
    String? redirectPrefix,
    String? serverID,
    num? tcpPunchPort,
    num? udpPunchPort,
  }) =>
      Server(
        ddns: ddns ?? this.ddns,
        dsState: dsState ?? this.dsState,
        external: external ?? this.external,
        fqdn: fqdn ?? this.fqdn,
        gateway: gateway ?? this.gateway,
        interface: interface ?? this.interface,
        ipv6Tunnel: ipv6Tunnel ?? this.ipv6Tunnel,
        pingpongPath: pingpongPath ?? this.pingpongPath,
        redirectPrefix: redirectPrefix ?? this.redirectPrefix,
        serverID: serverID ?? this.serverID,
        tcpPunchPort: tcpPunchPort ?? this.tcpPunchPort,
        udpPunchPort: udpPunchPort ?? this.udpPunchPort,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ddns'] = ddns;
    map['ds_state'] = dsState;
    if (external != null) {
      map['external'] = external?.toJson();
    }
    map['fqdn'] = fqdn;
    map['gateway'] = gateway;
    if (interface != null) {
      map['interface'] = interface?.map((v) => v.toJson()).toList();
    }
    map['ipv6_tunnel'] = ipv6Tunnel;
    map['pingpong_path'] = pingpongPath;
    map['redirect_prefix'] = redirectPrefix;
    map['serverID'] = serverID;
    map['tcp_punch_port'] = tcpPunchPort;
    map['udp_punch_port'] = udpPunchPort;
    return map;
  }
}

/// ip : "192.168.0.135"
/// ipv6 : []
/// mask : "255.255.255.0"
/// name : "eth0"

class Interface {
  Interface({
    this.ip,
    this.ipv6,
    this.mask,
    this.name,
  });

  Interface.fromJson(dynamic json) {
    ip = json['ip'];
    if (json['ipv6'] != null) {
      ipv6 = [];
      json['ipv6'].forEach((v) {
        ipv6?.add(Ipv6.fromJson(v));
      });
    }
    mask = json['mask'];
    name = json['name'];
  }
  String? ip;
  List<Ipv6>? ipv6;
  String? mask;
  String? name;
  Interface copyWith({
    String? ip,
    List<Ipv6>? ipv6,
    String? mask,
    String? name,
  }) =>
      Interface(
        ip: ip ?? this.ip,
        ipv6: ipv6 ?? this.ipv6,
        mask: mask ?? this.mask,
        name: name ?? this.name,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ip'] = ip;
    if (ipv6 != null) {
      map['ipv6'] = ipv6?.map((v) => v.toJson()).toList();
    }
    map['mask'] = mask;
    map['name'] = name;
    return map;
  }
}

/// ip : "113.120.111.99"
/// ipv6 : "::"

class External {
  External({
    this.ip,
    this.ipv6,
  });

  External.fromJson(dynamic json) {
    ip = json['ip'];
    ipv6 = json['ipv6'];
  }
  String? ip;
  String? ipv6;
  External copyWith({
    String? ip,
    String? ipv6,
  }) =>
      External(
        ip: ip ?? this.ip,
        ipv6: ipv6 ?? this.ipv6,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ip'] = ip;
    map['ipv6'] = ipv6;
    return map;
  }
}

/// control_host : "cnc.quickconnect.cn"
/// relay_region : "cn3"

class Env {
  Env({
    this.controlHost,
    this.relayRegion,
  });

  Env.fromJson(dynamic json) {
    controlHost = json['control_host'];
    relayRegion = json['relay_region'];
  }
  String? controlHost;
  String? relayRegion;
  Env copyWith({
    String? controlHost,
    String? relayRegion,
  }) =>
      Env(
        controlHost: controlHost ?? this.controlHost,
        relayRegion: relayRegion ?? this.relayRegion,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['control_host'] = controlHost;
    map['relay_region'] = relayRegion;
    return map;
  }
}
