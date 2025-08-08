class LstGroupManageResponse {
  int? totalCount;
  List<GroupItem>? items;

  LstGroupManageResponse({this.totalCount, this.items});

  LstGroupManageResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <GroupItem>[];
      json['items'].forEach((v) {
        items!.add(new GroupItem.fromJson(v));
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

class GroupItem {
  String? groupName;
  String? id;
  bool? selected;

  GroupItem({this.groupName, this.id, this.selected});

  GroupItem.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    id = json['id'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['id'] = this.id;
    data['selected'] = this.selected;
    return data;
  }

  GroupItem copyWith({String? groupName, String? id, bool? selected}) {
    return GroupItem(
      groupName: groupName ?? this.groupName,
      id: id ?? this.id,
      selected: selected ?? this.selected,
    );
  }
}
