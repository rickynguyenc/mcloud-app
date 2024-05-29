import 'home_model.dart';

class ProductDetailResponse {
  num? code;
  num? status;
  List<ProductDetail>? result;

  ProductDetailResponse({this.code, this.status, this.result});

  ProductDetailResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['result'] != null) {
      result = <ProductDetail>[];
      json['result'].forEach((v) {
        result!.add(new ProductDetail.fromJson(v));
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

class ProductDetail {
  num? id;
  String? name;
  String? avatarUrl;
  List<AttributeLineIds>? attributeLineIds;
  List<dynamic>? productTemplateImageIds;
  AttributeId? categId;
  num? listPrice;
  dynamic description;

  ProductDetail({this.id, this.name, this.avatarUrl, this.attributeLineIds, this.productTemplateImageIds, this.categId, this.listPrice, this.description});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    if (json['attribute_line_ids'] != null) {
      attributeLineIds = <AttributeLineIds>[];
      json['attribute_line_ids'].forEach((v) {
        attributeLineIds!.add(new AttributeLineIds.fromJson(v));
      });
    }
    if (json['product_template_image_ids'] != null) {
      productTemplateImageIds = <dynamic>[];
      json['product_template_image_ids'].forEach((v) {
        productTemplateImageIds!.add(v);
      });
    }
    categId = json['categ_id'] != null ? new AttributeId.fromJson(json['categ_id']) : null;
    listPrice = json['list_price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    if (this.attributeLineIds != null) {
      data['attribute_line_ids'] = this.attributeLineIds!.map((v) => v.toJson()).toList();
    }
    if (this.productTemplateImageIds != null) {
      data['product_template_image_ids'] = this.productTemplateImageIds!.map((v) => v.toJson()).toList();
    }
    if (this.categId != null) {
      data['categ_id'] = this.categId!.toJson();
    }
    data['list_price'] = this.listPrice;
    data['description'] = this.description;
    return data;
  }
}

class AttributeLineIds {
  num? id;
  AttributeId? attributeId;
  List<ValueIds>? valueIds;

  AttributeLineIds({this.id, this.attributeId, this.valueIds});

  AttributeLineIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeId = json['attribute_id'] != null ? new AttributeId.fromJson(json['attribute_id']) : null;
    if (json['value_ids'] != null) {
      valueIds = <ValueIds>[];
      json['value_ids'].forEach((v) {
        valueIds!.add(new ValueIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributeId != null) {
      data['attribute_id'] = this.attributeId!.toJson();
    }
    if (this.valueIds != null) {
      data['value_ids'] = this.valueIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
