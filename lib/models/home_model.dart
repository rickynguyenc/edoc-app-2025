// public list
class PublicListResonpse {
  int? totalCount;
  List<DocumentItem>? items;

  PublicListResonpse({this.totalCount, this.items});

  PublicListResonpse.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <DocumentItem>[];
      json['items'].forEach((v) {
        items!.add(new DocumentItem.fromJson(v));
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

class DocumentItem {
  String? fileName;
  String? avatarUrl;
  String? description;
  String? author;
  int? fileMode;
  dynamic categoryName;
  String? createDate;
  int? point;
  String? size;
  String? userId;
  bool? isLiked;
  int? downloads;
  int? shared;
  int? likes;
  int? view;
  String? id;

  DocumentItem(
      {this.fileName,
      this.avatarUrl,
      this.description,
      this.author,
      this.fileMode,
      this.categoryName,
      this.createDate,
      this.point,
      this.size,
      this.userId,
      this.isLiked,
      this.downloads,
      this.shared,
      this.likes,
      this.view,
      this.id});

  DocumentItem.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    avatarUrl = json['avatarUrl'];
    description = json['description'];
    author = json['author'];
    fileMode = json['fileMode'];
    categoryName = json['categoryName'];
    createDate = json['createDate'];
    point = json['point'];
    size = json['size'];
    userId = json['userId'];
    isLiked = json['isLiked'];
    downloads = json['downloads'];
    shared = json['shared'];
    likes = json['likes'];
    view = json['view'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['avatarUrl'] = this.avatarUrl;
    data['description'] = this.description;
    data['author'] = this.author;
    data['fileMode'] = this.fileMode;
    data['categoryName'] = this.categoryName;
    data['createDate'] = this.createDate;
    data['point'] = this.point;
    data['size'] = this.size;
    data['userId'] = this.userId;
    data['isLiked'] = this.isLiked;
    data['downloads'] = this.downloads;
    data['shared'] = this.shared;
    data['likes'] = this.likes;
    data['view'] = this.view;
    data['id'] = this.id;
    return data;
  }
}

class CategoryTreeResonpse {
  String? label;
  String? id;
  dynamic type;
  bool? checked;
  dynamic disabled;
  List<CategoryTreeResonpse?>? children;

  CategoryTreeResonpse({this.label, this.id, this.type, this.checked, this.disabled, this.children});

  CategoryTreeResonpse.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    id = json['id'];
    type = json['type'];
    checked = json['checked'];
    disabled = json['disabled'];
    if (json['children'] != null) {
      children = <Null>[];
      json['children'].forEach((v) {
        children!.add(new CategoryTreeResonpse.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['label'] = this.label;
  //   data['id'] = this.id;
  //   data['type'] = this.type;
  //   data['checked'] = this.checked;
  //   data['disabled'] = this.disabled;
  //   if (this.children != null) {
  //     data['children'] = this.children!.map((v) => CategoryTreeResonpse.toJson()).toList();
  //   }
  //   return data;
  // }

  @override
  String toString() {
    return label ?? '';
  }
}

// Organiztion Tree User Tree, User Group Tree
class DropdownTree {
  String? id;
  String? displayName;

  DropdownTree({this.id, this.displayName});

  DropdownTree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    return data;
  }

  @override
  String toString() {
    return displayName ?? '';
  }
}
