/// buildphase : "GM"
/// configured : true
/// custom_login_title : "Apaipai"
/// date_format : "Y-m-d"
/// diskless : false
/// dsm_http_port : 5000
/// dsm_https_port : 5001
/// dsm_upgrade_all_done : true
/// enable_http_negotiate : false
/// enable_syno_token : "yes"
/// fullversion : "1684563002"
/// hostname : "ChallengerV"
/// isLogined : false
/// isMobileDevice : false
/// is_secure : false
/// lang : "enu"
/// login_background_color : "#FFFFFF"
/// login_background_enable : true
/// login_background_ext : ".jpg"
/// login_background_height : 1080
/// login_background_pos : "fill"
/// login_background_seq : 4
/// login_background_type : "fromDS"
/// login_background_width : 1920
/// login_enable_fp : 0
/// login_footer_enable_html : false
/// login_footer_msg : "电风扇地方"
/// login_logo_enable : true
/// login_logo_ext : ".png"
/// login_logo_pos : "center"
/// login_logo_seq : 1
/// login_only_bgcolor : false
/// login_style : "tpl1"
/// login_version_logo : false
/// login_welcome_msg : "第三个环节三个傻瓜"
/// login_welcome_title : "手动滑稽"
/// oidc_sso_enable : false
/// public_access : false
/// sso_appid : ""
/// sso_default_login : false
/// sso_server : ""
/// sso_support : false
/// time_format : "H:i"
/// version : "1684563002"

class SessionDataModel {
  SessionDataModel({
    this.buildphase,
    this.configured,
    this.customLoginTitle,
    this.dateFormat,
    this.diskless,
    this.dsmHttpPort,
    this.dsmHttpsPort,
    this.dsmUpgradeAllDone,
    this.enableHttpNegotiate,
    this.enableSynoToken,
    this.fullversion,
    this.hostname,
    this.isLogined,
    this.isMobileDevice,
    this.isSecure,
    this.lang,
    this.loginBackgroundColor,
    this.loginBackgroundEnable,
    this.loginBackgroundExt,
    this.loginBackgroundHeight,
    this.loginBackgroundPos,
    this.loginBackgroundSeq,
    this.loginBackgroundType,
    this.loginBackgroundWidth,
    this.loginEnableFp,
    this.loginFooterEnableHtml,
    this.loginFooterMsg,
    this.loginLogoEnable,
    this.loginLogoExt,
    this.loginLogoPos,
    this.loginLogoSeq,
    this.loginOnlyBgcolor,
    this.loginStyle,
    this.loginVersionLogo,
    this.loginWelcomeMsg,
    this.loginWelcomeTitle,
    this.oidcSsoEnable,
    this.publicAccess,
    this.ssoAppid,
    this.ssoDefaultLogin,
    this.ssoServer,
    this.ssoSupport,
    this.timeFormat,
    this.version,
  });

  SessionDataModel.fromJson(dynamic json) {
    buildphase = json['buildphase'];
    configured = json['configured'];
    customLoginTitle = json['custom_login_title'];
    dateFormat = json['date_format'];
    diskless = json['diskless'];
    dsmHttpPort = json['dsm_http_port'];
    dsmHttpsPort = json['dsm_https_port'];
    dsmUpgradeAllDone = json['dsm_upgrade_all_done'];
    enableHttpNegotiate = json['enable_http_negotiate'];
    enableSynoToken = json['enable_syno_token'];
    fullversion = json['fullversion'];
    hostname = json['hostname'];
    isLogined = json['isLogined'];
    isMobileDevice = json['isMobileDevice'];
    isSecure = json['is_secure'];
    lang = json['lang'];
    loginBackgroundColor = json['login_background_color'];
    loginBackgroundEnable = json['login_background_enable'];
    loginBackgroundExt = json['login_background_ext'];
    loginBackgroundHeight = json['login_background_height'];
    loginBackgroundPos = json['login_background_pos'];
    loginBackgroundSeq = json['login_background_seq'];
    loginBackgroundType = json['login_background_type'];
    loginBackgroundWidth = json['login_background_width'];
    loginEnableFp = json['login_enable_fp'];
    loginFooterEnableHtml = json['login_footer_enable_html'];
    loginFooterMsg = json['login_footer_msg'];
    loginLogoEnable = json['login_logo_enable'];
    loginLogoExt = json['login_logo_ext'];
    loginLogoPos = json['login_logo_pos'];
    loginLogoSeq = json['login_logo_seq'];
    loginOnlyBgcolor = json['login_only_bgcolor'];
    loginStyle = json['login_style'];
    loginVersionLogo = json['login_version_logo'];
    loginWelcomeMsg = json['login_welcome_msg'];
    loginWelcomeTitle = json['login_welcome_title'];
    oidcSsoEnable = json['oidc_sso_enable'];
    publicAccess = json['public_access'];
    ssoAppid = json['sso_appid'];
    ssoDefaultLogin = json['sso_default_login'];
    ssoServer = json['sso_server'];
    ssoSupport = json['sso_support'];
    timeFormat = json['time_format'];
    version = json['version'];
  }
  String? buildphase;
  bool? configured;
  String? customLoginTitle;
  String? dateFormat;
  bool? diskless;
  num? dsmHttpPort;
  num? dsmHttpsPort;
  bool? dsmUpgradeAllDone;
  bool? enableHttpNegotiate;
  String? enableSynoToken;
  String? fullversion;
  String? hostname;
  bool? isLogined;
  bool? isMobileDevice;
  bool? isSecure;
  String? lang;
  String? loginBackgroundColor;
  bool? loginBackgroundEnable;
  String? loginBackgroundExt;
  num? loginBackgroundHeight;
  String? loginBackgroundPos;
  num? loginBackgroundSeq;
  String? loginBackgroundType;
  num? loginBackgroundWidth;
  num? loginEnableFp;
  bool? loginFooterEnableHtml;
  String? loginFooterMsg;
  bool? loginLogoEnable;
  String? loginLogoExt;
  String? loginLogoPos;
  num? loginLogoSeq;
  bool? loginOnlyBgcolor;
  String? loginStyle;
  bool? loginVersionLogo;
  String? loginWelcomeMsg;
  String? loginWelcomeTitle;
  bool? oidcSsoEnable;
  bool? publicAccess;
  String? ssoAppid;
  bool? ssoDefaultLogin;
  String? ssoServer;
  bool? ssoSupport;
  String? timeFormat;
  String? version;
  SessionDataModel copyWith({
    String? buildphase,
    bool? configured,
    String? customLoginTitle,
    String? dateFormat,
    bool? diskless,
    num? dsmHttpPort,
    num? dsmHttpsPort,
    bool? dsmUpgradeAllDone,
    bool? enableHttpNegotiate,
    String? enableSynoToken,
    String? fullversion,
    String? hostname,
    bool? isLogined,
    bool? isMobileDevice,
    bool? isSecure,
    String? lang,
    String? loginBackgroundColor,
    bool? loginBackgroundEnable,
    String? loginBackgroundExt,
    num? loginBackgroundHeight,
    String? loginBackgroundPos,
    num? loginBackgroundSeq,
    String? loginBackgroundType,
    num? loginBackgroundWidth,
    num? loginEnableFp,
    bool? loginFooterEnableHtml,
    String? loginFooterMsg,
    bool? loginLogoEnable,
    String? loginLogoExt,
    String? loginLogoPos,
    num? loginLogoSeq,
    bool? loginOnlyBgcolor,
    String? loginStyle,
    bool? loginVersionLogo,
    String? loginWelcomeMsg,
    String? loginWelcomeTitle,
    bool? oidcSsoEnable,
    bool? publicAccess,
    String? ssoAppid,
    bool? ssoDefaultLogin,
    String? ssoServer,
    bool? ssoSupport,
    String? timeFormat,
    String? version,
  }) =>
      SessionDataModel(
        buildphase: buildphase ?? this.buildphase,
        configured: configured ?? this.configured,
        customLoginTitle: customLoginTitle ?? this.customLoginTitle,
        dateFormat: dateFormat ?? this.dateFormat,
        diskless: diskless ?? this.diskless,
        dsmHttpPort: dsmHttpPort ?? this.dsmHttpPort,
        dsmHttpsPort: dsmHttpsPort ?? this.dsmHttpsPort,
        dsmUpgradeAllDone: dsmUpgradeAllDone ?? this.dsmUpgradeAllDone,
        enableHttpNegotiate: enableHttpNegotiate ?? this.enableHttpNegotiate,
        enableSynoToken: enableSynoToken ?? this.enableSynoToken,
        fullversion: fullversion ?? this.fullversion,
        hostname: hostname ?? this.hostname,
        isLogined: isLogined ?? this.isLogined,
        isMobileDevice: isMobileDevice ?? this.isMobileDevice,
        isSecure: isSecure ?? this.isSecure,
        lang: lang ?? this.lang,
        loginBackgroundColor: loginBackgroundColor ?? this.loginBackgroundColor,
        loginBackgroundEnable: loginBackgroundEnable ?? this.loginBackgroundEnable,
        loginBackgroundExt: loginBackgroundExt ?? this.loginBackgroundExt,
        loginBackgroundHeight: loginBackgroundHeight ?? this.loginBackgroundHeight,
        loginBackgroundPos: loginBackgroundPos ?? this.loginBackgroundPos,
        loginBackgroundSeq: loginBackgroundSeq ?? this.loginBackgroundSeq,
        loginBackgroundType: loginBackgroundType ?? this.loginBackgroundType,
        loginBackgroundWidth: loginBackgroundWidth ?? this.loginBackgroundWidth,
        loginEnableFp: loginEnableFp ?? this.loginEnableFp,
        loginFooterEnableHtml: loginFooterEnableHtml ?? this.loginFooterEnableHtml,
        loginFooterMsg: loginFooterMsg ?? this.loginFooterMsg,
        loginLogoEnable: loginLogoEnable ?? this.loginLogoEnable,
        loginLogoExt: loginLogoExt ?? this.loginLogoExt,
        loginLogoPos: loginLogoPos ?? this.loginLogoPos,
        loginLogoSeq: loginLogoSeq ?? this.loginLogoSeq,
        loginOnlyBgcolor: loginOnlyBgcolor ?? this.loginOnlyBgcolor,
        loginStyle: loginStyle ?? this.loginStyle,
        loginVersionLogo: loginVersionLogo ?? this.loginVersionLogo,
        loginWelcomeMsg: loginWelcomeMsg ?? this.loginWelcomeMsg,
        loginWelcomeTitle: loginWelcomeTitle ?? this.loginWelcomeTitle,
        oidcSsoEnable: oidcSsoEnable ?? this.oidcSsoEnable,
        publicAccess: publicAccess ?? this.publicAccess,
        ssoAppid: ssoAppid ?? this.ssoAppid,
        ssoDefaultLogin: ssoDefaultLogin ?? this.ssoDefaultLogin,
        ssoServer: ssoServer ?? this.ssoServer,
        ssoSupport: ssoSupport ?? this.ssoSupport,
        timeFormat: timeFormat ?? this.timeFormat,
        version: version ?? this.version,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['buildphase'] = buildphase;
    map['configured'] = configured;
    map['custom_login_title'] = customLoginTitle;
    map['date_format'] = dateFormat;
    map['diskless'] = diskless;
    map['dsm_http_port'] = dsmHttpPort;
    map['dsm_https_port'] = dsmHttpsPort;
    map['dsm_upgrade_all_done'] = dsmUpgradeAllDone;
    map['enable_http_negotiate'] = enableHttpNegotiate;
    map['enable_syno_token'] = enableSynoToken;
    map['fullversion'] = fullversion;
    map['hostname'] = hostname;
    map['isLogined'] = isLogined;
    map['isMobileDevice'] = isMobileDevice;
    map['is_secure'] = isSecure;
    map['lang'] = lang;
    map['login_background_color'] = loginBackgroundColor;
    map['login_background_enable'] = loginBackgroundEnable;
    map['login_background_ext'] = loginBackgroundExt;
    map['login_background_height'] = loginBackgroundHeight;
    map['login_background_pos'] = loginBackgroundPos;
    map['login_background_seq'] = loginBackgroundSeq;
    map['login_background_type'] = loginBackgroundType;
    map['login_background_width'] = loginBackgroundWidth;
    map['login_enable_fp'] = loginEnableFp;
    map['login_footer_enable_html'] = loginFooterEnableHtml;
    map['login_footer_msg'] = loginFooterMsg;
    map['login_logo_enable'] = loginLogoEnable;
    map['login_logo_ext'] = loginLogoExt;
    map['login_logo_pos'] = loginLogoPos;
    map['login_logo_seq'] = loginLogoSeq;
    map['login_only_bgcolor'] = loginOnlyBgcolor;
    map['login_style'] = loginStyle;
    map['login_version_logo'] = loginVersionLogo;
    map['login_welcome_msg'] = loginWelcomeMsg;
    map['login_welcome_title'] = loginWelcomeTitle;
    map['oidc_sso_enable'] = oidcSsoEnable;
    map['public_access'] = publicAccess;
    map['sso_appid'] = ssoAppid;
    map['sso_default_login'] = ssoDefaultLogin;
    map['sso_server'] = ssoServer;
    map['sso_support'] = ssoSupport;
    map['time_format'] = timeFormat;
    map['version'] = version;
    return map;
  }
}
