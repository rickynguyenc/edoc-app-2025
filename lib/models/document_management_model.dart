class LstDocumentManageResponse {
  int? totalCount;
  List<DocumentManage>? items;

  LstDocumentManageResponse({this.totalCount, this.items});

  LstDocumentManageResponse.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      items = <DocumentManage>[];
      json['items'].forEach((v) {
        items!.add(new DocumentManage.fromJson(v));
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

class DocumentManage {
  String? fileName;
  dynamic avatarUrl;
  String? description;
  String? author;
  int? fileMode;
  String? uploaderName;
  String? organizationName;
  String? categoryName;
  int? point;
  String? id;
  bool? selected;

  DocumentManage({this.fileName, this.avatarUrl, this.description, this.author, this.fileMode, this.uploaderName, this.organizationName, this.categoryName, this.point, this.id, this.selected});

  DocumentManage.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    avatarUrl = json['avatarUrl'];
    description = json['description'];
    author = json['author'];
    fileMode = json['fileMode'];
    uploaderName = json['uploaderName'];
    organizationName = json['organizationName'];
    categoryName = json['categoryName'];
    point = json['point'];
    id = json['id'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['avatarUrl'] = this.avatarUrl;
    data['description'] = this.description;
    data['author'] = this.author;
    data['fileMode'] = this.fileMode;
    data['uploaderName'] = this.uploaderName;
    data['organizationName'] = this.organizationName;
    data['categoryName'] = this.categoryName;
    data['point'] = this.point;
    data['id'] = this.id;
    data['selected'] = this.selected;
    return data;
  }

  DocumentManage copyWith(
      {String? fileName,
      dynamic avatarUrl,
      String? description,
      String? author,
      int? fileMode,
      String? uploaderName,
      String? organizationName,
      String? categoryName,
      int? point,
      String? id,
      bool? selected}) {
    return DocumentManage(
      fileName: fileName ?? this.fileName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      description: description ?? this.description,
      author: author ?? this.author,
      fileMode: fileMode ?? this.fileMode,
      uploaderName: uploaderName ?? this.uploaderName,
      organizationName: organizationName ?? this.organizationName,
      categoryName: categoryName ?? this.categoryName,
      point: point ?? this.point,
      id: id ?? this.id,
      selected: selected ?? this.selected,
    );
  }
}
