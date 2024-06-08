// Danh sách sản phẩm
class ListProductResponse {
  num? count;
  dynamic prev;
  num? current;
  dynamic next;
  num? totalPages;
  List<Product>? result;

  ListProductResponse({this.count, this.prev, this.current, this.next, this.totalPages, this.result});

  ListProductResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    prev = json['prev'];
    current = json['current'];
    next = json['next'];
    totalPages = json['total_pages'];
    if (json['result'] != null) {
      result = <Product>[];
      json['result'].forEach((v) {
        result!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['prev'] = this.prev;
    data['current'] = this.current;
    data['next'] = this.next;
    data['total_pages'] = this.totalPages;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  num? id;
  String? name;
  String? avatarUrl;
  List<AttributeLineIds>? attributeLineIds;
  List<dynamic>? productTemplateImageIds;
  AttributeId? categId;
  num? listPrice;

  Product({this.id, this.name, this.avatarUrl, this.attributeLineIds, this.productTemplateImageIds, this.categId, this.listPrice});

  Product.fromJson(Map<String, dynamic> json) {
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

class AttributeId {
  num? id;
  String? name;

  AttributeId({this.id, this.name});

  AttributeId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ValueIds {
  num? id;
  String? name;

  ValueIds({this.id, this.name});

  ValueIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

// Danh mục sản phẩm
class CategoryProductResponse {
  num? count;
  dynamic prev;
  num? current;
  dynamic next;
  num? totalPages;
  List<Category>? result;

  CategoryProductResponse({this.count, this.prev, this.current, this.next, this.totalPages, this.result});

  CategoryProductResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    prev = json['prev'];
    current = json['current'];
    next = json['next'];
    totalPages = json['total_pages'];
    if (json['result'] != null) {
      result = <Category>[];
      json['result'].forEach((v) {
        result!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['prev'] = this.prev;
    data['current'] = this.current;
    data['next'] = this.next;
    data['total_pages'] = this.totalPages;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  num? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
