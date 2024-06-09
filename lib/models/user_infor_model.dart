class UserInforResponse {
  int? code;
  int? status;
  List<UserInfor>? result;

  UserInforResponse({this.code, this.status, this.result});

  UserInforResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['result'] != null) {
      result = <UserInfor>[];
      json['result'].forEach((v) {
        result!.add(new UserInfor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfor {
  int? id;
  dynamic name;
  dynamic avatarUrl;
  PartnerIdUser? partnerId;

  UserInfor({this.id, this.name, this.avatarUrl, this.partnerId});

  UserInfor.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    avatarUrl = json['avatar_url'] ?? '';
    partnerId = json['partner_id'] != null ? new PartnerIdUser.fromJson(json['partner_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    if (this.partnerId != null) {
      data['partner_id'] = this.partnerId!.toJson();
    }
    return data;
  }
}

class PartnerIdUser {
  int? id;
  dynamic name;
  dynamic street;
  dynamic street2;
  dynamic city;
  bool? zip;
  dynamic function;
  dynamic phone;
  bool? mobile;
  dynamic email;
  dynamic website;
  dynamic lang;
  List<dynamic>? categoryId;

  PartnerIdUser({this.id, this.name, this.street, this.street2, this.city, this.zip, this.function, this.phone, this.mobile, this.email, this.website, this.lang, this.categoryId});

  PartnerIdUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    street = json['street'] ?? '';
    street2 = json['street2'] ?? '';
    city = json['city'] ?? '';
    zip = json['zip'] ?? '';
    function = json['function'] ?? '';
    phone = json['phone'] ?? '';
    mobile = json['mobile'] ?? '';
    email = json['email'] ?? '';
    website = json['website'] ?? '';
    lang = json['lang'] ?? '';
    if (json['category_id'] != null) {
      categoryId = <dynamic>[];
      json['category_id'].forEach((v) {
        categoryId!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['street'] = this.street;
    data['street2'] = this.street2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['function'] = this.function;
    data['phone'] = this.phone;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['website'] = this.website;
    data['lang'] = this.lang;
    if (this.categoryId != null) {
      data['category_id'] = this.categoryId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
