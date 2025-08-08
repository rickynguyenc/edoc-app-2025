// Tất cả sản phẩm trong cart
class AllProductionInCartResponse {
  num? code;
  List<ProductInCart>? result;

  AllProductionInCartResponse({this.code, this.result});

  AllProductionInCartResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['result'] != null) {
      result = <ProductInCart>[];
      json['result'].forEach((v) {
        result!.add(new ProductInCart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductInCart {
  num? id;
  String? name;
  String? state;
  PartnerIdCart? partnerId;
  List<OrderLine>? orderLine;
  num? amountTotal;

  ProductInCart({this.id, this.name, this.state, this.partnerId, this.orderLine, this.amountTotal});

  ProductInCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    partnerId = json['partner_id'] != null ? new PartnerIdCart.fromJson(json['partner_id']) : null;
    if (json['order_line'] != null) {
      orderLine = <OrderLine>[];
      json['order_line'].forEach((v) {
        orderLine!.add(new OrderLine.fromJson(v));
      });
    }
    amountTotal = json['amount_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    if (this.partnerId != null) {
      data['partner_id'] = this.partnerId!.toJson();
    }
    if (this.orderLine != null) {
      data['order_line'] = this.orderLine!.map((v) => v.toJson()).toList();
    }
    data['amount_total'] = this.amountTotal;
    return data;
  }
}

class PartnerIdCart {
  num? id;
  String? name;

  PartnerIdCart({this.id, this.name});

  PartnerIdCart.fromJson(Map<String, dynamic> json) {
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

class OrderLine {
  num? id;
  ProductIdCart? productId;
  num? productUomQty;
  num? priceUnit;
  num? priceSubtotal;
  bool? isChoose;

  OrderLine({this.id, this.productId, this.productUomQty, this.priceUnit, this.priceSubtotal, this.isChoose});

  OrderLine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'] != null ? new ProductIdCart.fromJson(json['product_id']) : null;
    productUomQty = json['product_uom_qty'];
    priceUnit = json['price_unit'];
    priceSubtotal = json['price_subtotal'];
    isChoose = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productId != null) {
      data['product_id'] = this.productId!.toJson();
    }
    data['product_uom_qty'] = this.productUomQty;
    data['price_unit'] = this.priceUnit;
    data['price_subtotal'] = this.priceSubtotal;
    return data;
  }
}

class ProductIdCart {
  num? id;
  String? name;
  String? avatarUrl;
  List<ProductTemplateAttributeValueIds>? productTemplateAttributeValueIds;

  ProductIdCart({this.id, this.name, this.avatarUrl, this.productTemplateAttributeValueIds});

  ProductIdCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatarUrl = json['avatar_url'];
    if (json['product_template_attribute_value_ids'] != null) {
      productTemplateAttributeValueIds = <ProductTemplateAttributeValueIds>[];
      json['product_template_attribute_value_ids'].forEach((v) {
        productTemplateAttributeValueIds!.add(new ProductTemplateAttributeValueIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['avatar_url'] = this.avatarUrl;
    if (this.productTemplateAttributeValueIds != null) {
      data['product_template_attribute_value_ids'] = this.productTemplateAttributeValueIds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductTemplateAttributeValueIds {
  num? id;
  String? name;
  PartnerIdCart? attributeId;
  PartnerIdCart? productAttributeValueId;

  ProductTemplateAttributeValueIds({this.id, this.name, this.attributeId, this.productAttributeValueId});

  ProductTemplateAttributeValueIds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attributeId = json['attribute_id'] != null ? new PartnerIdCart.fromJson(json['attribute_id']) : null;
    productAttributeValueId = json['product_attribute_value_id'] != null ? new PartnerIdCart.fromJson(json['product_attribute_value_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.attributeId != null) {
      data['attribute_id'] = this.attributeId!.toJson();
    }
    if (this.productAttributeValueId != null) {
      data['product_attribute_value_id'] = this.productAttributeValueId!.toJson();
    }
    return data;
  }
}

// Add cart dto
class CartInputDto {
  List<OrderLineDto>? orderLine;

  CartInputDto({this.orderLine});

  CartInputDto.fromJson(Map<String, dynamic> json) {
    if (json['order_line'] != null) {
      orderLine = <OrderLineDto>[];
      json['order_line'].forEach((v) {
        orderLine!.add(new OrderLineDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderLine != null) {
      data['order_line'] = this.orderLine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLineDto {
  num? productTemplateId;
  List<ProductTemplateAttributeValueIdsDto>? productTemplateAttributeValueIds;
  num? productUomQty;
  num? priceUnit;

  OrderLineDto({this.productTemplateId, this.productTemplateAttributeValueIds, this.productUomQty, this.priceUnit});

  OrderLineDto.fromJson(Map<String, dynamic> json) {
    productTemplateId = json['product_template_id'];
    if (json['product_template_attribute_value_ids'] != null) {
      productTemplateAttributeValueIds = <ProductTemplateAttributeValueIdsDto>[];
      json['product_template_attribute_value_ids'].forEach((v) {
        productTemplateAttributeValueIds!.add(new ProductTemplateAttributeValueIdsDto.fromJson(v));
      });
    }
    productUomQty = json['product_uom_qty'];
    priceUnit = json['price_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_template_id'] = this.productTemplateId;
    if (this.productTemplateAttributeValueIds != null) {
      data['product_template_attribute_value_ids'] = this.productTemplateAttributeValueIds!.map((v) => v.toJson()).toList();
    }
    data['product_uom_qty'] = this.productUomQty;
    data['price_unit'] = this.priceUnit;
    return data;
  }
}

class ProductTemplateAttributeValueIdsDto {
  num? attributeId;
  num? productAttributeValueId;

  ProductTemplateAttributeValueIdsDto({this.attributeId, this.productAttributeValueId});

  ProductTemplateAttributeValueIdsDto.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    productAttributeValueId = json['product_attribute_value_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attributeId;
    data['product_attribute_value_id'] = this.productAttributeValueId;
    return data;
  }
}
