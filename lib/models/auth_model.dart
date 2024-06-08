class LoginResponse {
  int? uid;
  UserContext? userContext;
  int? companyId;
  List<int>? companyIds;
  int? partnerId;
  String? accessToken;
  bool? companyName;
  String? currency;
  bool? country;
  String? contactAddress;
  int? customerRank;

  LoginResponse({this.uid, this.userContext, this.companyId, this.companyIds, this.partnerId, this.accessToken, this.companyName, this.currency, this.country, this.contactAddress, this.customerRank});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userContext = json['user_context'] != null ? new UserContext.fromJson(json['user_context']) : null;
    companyId = json['company_id'];
    companyIds = json['company_ids'].cast<int>();
    partnerId = json['partner_id'];
    accessToken = json['access_token'];
    companyName = json['company_name'];
    currency = json['currency'];
    country = json['country'];
    contactAddress = json['contact_address'];
    customerRank = json['customer_rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    if (this.userContext != null) {
      data['user_context'] = this.userContext!.toJson();
    }
    data['company_id'] = this.companyId;
    data['company_ids'] = this.companyIds;
    data['partner_id'] = this.partnerId;
    data['access_token'] = this.accessToken;
    data['company_name'] = this.companyName;
    data['currency'] = this.currency;
    data['country'] = this.country;
    data['contact_address'] = this.contactAddress;
    data['customer_rank'] = this.customerRank;
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
