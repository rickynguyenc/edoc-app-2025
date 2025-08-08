class UserInfor {
  String? phoneNumber;
  int? sizeUpload;
  String? name;
  dynamic password;
  String? email;
  String? fullName;
  dynamic appleId;
  String? avatar;
  dynamic facebookId;
  String? organizationId;
  int? accountType;
  int? point;
  String? address;
  String? jobPosition;
  int? status;
  dynamic roleNames;
  dynamic roleIds;

  UserInfor(
      {this.phoneNumber,
      this.sizeUpload,
      this.name,
      this.password,
      this.email,
      this.fullName,
      this.appleId,
      this.avatar,
      this.facebookId,
      this.organizationId,
      this.accountType,
      this.point,
      this.address,
      this.jobPosition,
      this.status,
      this.roleNames,
      this.roleIds});

  UserInfor.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    sizeUpload = json['sizeUpload'];
    name = json['name'];
    password = json['password'];
    email = json['email'];
    fullName = json['fullName'];
    appleId = json['appleId'];
    avatar = json['avatar'];
    facebookId = json['facebookId'];
    organizationId = json['organizationId'];
    accountType = json['accountType'];
    point = json['point'];
    address = json['address'];
    jobPosition = json['jobPosition'];
    status = json['status'];
    roleNames = json['roleNames'];
    roleIds = json['roleIds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phoneNumber'] = this.phoneNumber;
    data['sizeUpload'] = this.sizeUpload;
    data['name'] = this.name;
    data['password'] = this.password;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['appleId'] = this.appleId;
    data['avatar'] = this.avatar;
    data['facebookId'] = this.facebookId;
    data['organizationId'] = this.organizationId;
    data['accountType'] = this.accountType;
    data['point'] = this.point;
    data['address'] = this.address;
    data['jobPosition'] = this.jobPosition;
    data['status'] = this.status;
    data['roleNames'] = this.roleNames;
    data['roleIds'] = this.roleIds;
    return data;
  }
}

// Update user information
class UserInforDTO {
  String? avatar;
  String? email;
  String? fullName;
  String? address;
  String? jobPosition;
  String? phoneNumber;
  String? name;
  int? status;
  int? accountType;
  dynamic roleIds;
  dynamic roleNames;
  String? organizationId;

  UserInforDTO({this.avatar, this.email, this.fullName, this.address, this.jobPosition, this.phoneNumber, this.name, this.status, this.accountType, this.roleIds, this.roleNames, this.organizationId});

  UserInforDTO.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    email = json['email'];
    fullName = json['fullName'];
    address = json['address'];
    jobPosition = json['jobPosition'];
    phoneNumber = json['phoneNumber'];
    name = json['name'];
    status = json['status'];
    accountType = json['accountType'];
    roleIds = json['roleIds'];
    roleNames = json['roleNames'];
    organizationId = json['organizationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['address'] = this.address;
    data['jobPosition'] = this.jobPosition;
    data['phoneNumber'] = this.phoneNumber;
    data['name'] = this.name;
    data['status'] = this.status;
    data['accountType'] = this.accountType;
    data['roleIds'] = this.roleIds;
    data['roleNames'] = this.roleNames;
    data['organizationId'] = this.organizationId;
    return data;
  }
}
