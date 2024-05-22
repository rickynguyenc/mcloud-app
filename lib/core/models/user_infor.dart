import 'dart:convert';

class UserInfo {
  UserInfo({
    this.address,
    this.avatar,
    this.concurrencyStamp,
    this.departmentId,
    this.email,
    this.enterpriseIds,
    this.jobPosition,
    this.name,
    this.phoneNumber,
    this.roleIds,
    this.status,
    this.userName,
  });
  String? avatar;
  String? address;
  String? concurrencyStamp;
  String? departmentId;
  String? enterpriseIds;
  String? email;
  String? jobPosition;
  String? name;
  String? phoneNumber;
  String? roleIds;
  int? status;
  String? userName;

  UserInfo copyWith({
    String? avatar,
    String? address,
    String? concurrencyStamp,
    String? departmentId,
    String? enterpriseIds,
    String? email,
    String? jobPosition,
    String? name,
    String? phoneNumber,
    String? roleIds,
    int? status,
    String? userName,
  }) =>
      UserInfo(
        avatar: avatar ?? this.avatar,
        address: address ?? this.address,
        concurrencyStamp: concurrencyStamp ?? this.concurrencyStamp,
        departmentId: departmentId ?? this.departmentId,
        enterpriseIds: enterpriseIds ?? this.enterpriseIds,
        jobPosition: jobPosition ?? this.jobPosition,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        roleIds: roleIds ?? this.roleIds,
        status: status ?? this.status,
        userName: userName ?? this.userName,
      );

  factory UserInfo.fromRawJson(String str) => UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        address: json["address"],
        avatar: json["avatar"],
        concurrencyStamp: json["concurrencyStamp"],
        departmentId: json["departmentId"],
        enterpriseIds: json["enterpriseIds"],
        jobPosition: json["jobPosition"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        roleIds: json["roleIds"],
        status: json["status"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "avatar": avatar,
        "concurrencyStamp": concurrencyStamp,
        "departmentId": departmentId,
        "enterpriseIds": enterpriseIds,
        "jobPosition": jobPosition,
        "phoneNumber": phoneNumber,
        "roleIds": roleIds,
        "email": email,
        "name": name,
        "status": status,
        "userName": userName,
      };
}
