class LoginResponse {
  String? accessToken;
  String? tokenType;
  int? expiresIn;
  String? refreshToken;

  LoginResponse({this.accessToken, this.tokenType, this.expiresIn, this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    data['refresh_token'] = this.refreshToken;
    return data;
  }
}

class UserContext {
  String? lang;
  dynamic tz;
  int? uid;

  UserContext({this.lang, this.tz, this.uid});

  UserContext.fromJson(Map<String, dynamic> json) {
    lang = json['lang'];
    tz = json['tz'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = this.lang;
    data['tz'] = this.tz;
    data['uid'] = this.uid;
    return data;
  }
}

class GoogleRegisterResponse {
  String? email;
  String? tempPassword;

  GoogleRegisterResponse({this.email, this.tempPassword});

  GoogleRegisterResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    tempPassword = json['tempPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['tempPassword'] = this.tempPassword;
    return data;
  }
}
