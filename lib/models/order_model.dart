class AllOrderResponse {
  num? count;
  dynamic prev;
  num? current;
  dynamic next;
  num? totalPages;
  List<OrderItem>? result;

  AllOrderResponse({this.count, this.prev, this.current, this.next, this.totalPages, this.result});

  AllOrderResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    prev = json['prev'];
    current = json['current'];
    next = json['next'];
    totalPages = json['total_pages'];
    if (json['result'] != null) {
      result = <OrderItem>[];
      json['result'].forEach((v) {
        result!.add(new OrderItem.fromJson(v));
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

class OrderItem {
  num? id;
  dynamic name;
  dynamic state;
  PartnerId? partnerId;
  List<OrderLineOrder>? orderLine;
  num? amountTotal;
  dynamic status;

  OrderItem({this.id, this.name, this.state, this.partnerId, this.orderLine, this.amountTotal, this.status});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    partnerId = json['partner_id'] != null ? new PartnerId.fromJson(json['partner_id']) : null;
    if (json['order_line'] != null) {
      orderLine = <OrderLineOrder>[];
      json['order_line'].forEach((v) {
        orderLine!.add(new OrderLineOrder.fromJson(v));
      });
    }
    amountTotal = json['amount_total'];
    status = json['status'];
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
    data['status'] = this.status;
    return data;
  }
}

class PartnerId {
  num? id;
  dynamic name;

  PartnerId({this.id, this.name});

  PartnerId.fromJson(Map<String, dynamic> json) {
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

class OrderLineOrder {
  num? id;
  PartnerId? productId;
  num? productUomQty;
  num? priceUnit;
  num? priceSubtotal;
  dynamic productKey;

  OrderLineOrder({this.id, this.productId, this.productUomQty, this.priceUnit, this.priceSubtotal, this.productKey});

  OrderLineOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'] != null ? new PartnerId.fromJson(json['product_id']) : null;
    productUomQty = json['product_uom_qty'];
    priceUnit = json['price_unit'];
    priceSubtotal = json['price_subtotal'];
    productKey = json['product_key'];
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
    data['product_key'] = this.productKey;
    return data;
  }
}

// Detail Order
class DetailOrderResponse {
  num? code;
  num? status;
  DetailOrder? result;

  DetailOrderResponse({this.code, this.status, this.result});

  DetailOrderResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    result = json['result'] != null ? new DetailOrder.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class DetailOrder {
  List<Order>? order;
  List<Transaction>? transaction;

  DetailOrder({this.order, this.transaction});

  DetailOrder.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
    if (json['transaction'] != null) {
      transaction = <Transaction>[];
      final result = json['transaction'];
      if (result is Map && json['transaction']?['state'] == 'unpaid') {
        transaction!.add(new Transaction.fromJson(json['transaction']));
      } else {
        json['transaction'].forEach((v) {
          transaction!.add(new Transaction.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    if (this.transaction != null) {
      data['transaction'] = this.transaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  num? id;
  dynamic name;
  dynamic state;
  dynamic status;
  PartnerId? partnerId;
  List<OrderLineOrder>? orderLine;
  num? amountTotal;

  Order({this.id, this.name, this.state, this.status, this.partnerId, this.orderLine, this.amountTotal});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    status = json['status'];
    partnerId = json['partner_id'] != null ? new PartnerId.fromJson(json['partner_id']) : null;
    if (json['order_line'] != null) {
      orderLine = <OrderLineOrder>[];
      json['order_line'].forEach((v) {
        orderLine!.add(new OrderLineOrder.fromJson(v));
      });
    }
    amountTotal = json['amount_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['state'] = this.state;
    data['status'] = this.status;
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

class Transaction {
  num? id;
  dynamic state;
  dynamic vpcOrderInfo;
  dynamic vpcAmount;
  dynamic vpcMessage;

  Transaction({this.id, this.state, this.vpcOrderInfo, this.vpcAmount, this.vpcMessage});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    state = json['state'] ?? '';
    vpcOrderInfo = json['vpc_OrderInfo'] ?? '';
    vpcAmount = json['vpc_Amount'] ?? '';
    vpcMessage = json['vpc_Message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    data['vpc_OrderInfo'] = this.vpcOrderInfo;
    data['vpc_Amount'] = this.vpcAmount;
    data['vpc_Message'] = this.vpcMessage;
    return data;
  }
}

// Add Order DTO
class AddOrderDto {
  dynamic againLink;
  List<OrderLineDto>? orderLine;

  AddOrderDto({this.againLink, this.orderLine});

  AddOrderDto.fromJson(Map<String, dynamic> json) {
    againLink = json['AgainLink'];
    if (json['order_line'] != null) {
      orderLine = <OrderLineDto>[];
      json['order_line'].forEach((v) {
        orderLine!.add(new OrderLineDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AgainLink'] = this.againLink;
    if (this.orderLine != null) {
      data['order_line'] = this.orderLine!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLineDto {
  num? productTemplateId;
  List<dynamic>? productTemplateAttributeValueIds;
  num? productUomQty;
  num? priceUnit;

  OrderLineDto({this.productTemplateId, this.productTemplateAttributeValueIds, this.productUomQty, this.priceUnit});

  OrderLineDto.fromJson(Map<String, dynamic> json) {
    productTemplateId = json['product_template_id'];
    if (json['product_template_attribute_value_ids'] != null) {
      productTemplateAttributeValueIds = <dynamic>[];
      json['product_template_attribute_value_ids'].forEach((v) {
        productTemplateAttributeValueIds!.add(v);
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

// Add order response
class AddOrderResponse {
  dynamic jsonrpc;
  dynamic id;
  ResultAddOrder? result;

  AddOrderResponse({this.jsonrpc, this.id, this.result});

  AddOrderResponse.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result = json['result'] != null ? new ResultAddOrder.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class ResultAddOrder {
  num? code;
  num? status;
  dynamic message;
  List<SaleOrder>? saleOrder;
  dynamic urlPayment;

  ResultAddOrder({this.code, this.status, this.message, this.saleOrder, this.urlPayment});

  ResultAddOrder.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    if (json['sale_order'] != null) {
      saleOrder = <SaleOrder>[];
      json['sale_order'].forEach((v) {
        saleOrder!.add(new SaleOrder.fromJson(v));
      });
    }
    urlPayment = json['url_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.saleOrder != null) {
      data['sale_order'] = this.saleOrder!.map((v) => v.toJson()).toList();
    }
    data['url_payment'] = this.urlPayment;
    return data;
  }
}

class SaleOrder {
  num? id;
  dynamic name;
  dynamic state;
  PartnerId? partnerId;
  List<OrderLineOrder>? orderLine;
  num? amountTotal;

  SaleOrder({this.id, this.name, this.state, this.partnerId, this.orderLine, this.amountTotal});

  SaleOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    state = json['state'];
    partnerId = json['partner_id'] != null ? new PartnerId.fromJson(json['partner_id']) : null;
    if (json['order_line'] != null) {
      orderLine = <OrderLineOrder>[];
      json['order_line'].forEach((v) {
        orderLine!.add(new OrderLineOrder.fromJson(v));
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
