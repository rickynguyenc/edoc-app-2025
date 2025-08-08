class NotificationListResonpse {
  int? totalCount;
  List<NotificationItem>? items;

  NotificationListResonpse({this.totalCount, this.items});

  NotificationListResonpse.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <NotificationItem>[];
      json['items'].forEach((v) {
        items!.add(new NotificationItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationItem {
  String? content;
  int? status;
  String? creationTime;
  String? id;

  NotificationItem({this.content, this.status, this.creationTime, this.id});

  NotificationItem.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    status = json['status'];
    creationTime = json['creationTime'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['status'] = this.status;
    data['creationTime'] = this.creationTime;
    data['id'] = this.id;
    return data;
  }
}
