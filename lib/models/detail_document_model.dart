class DocumentDetail {
  String? fileName;
  String? avatarUrl;
  String? fileOriginName;
  String? createDate;
  String? description;
  String? author;
  bool? isLike;
  bool? isHaveDownloadPremission;
  dynamic categoryName;
  String? okmUuid;
  dynamic lastestTimeUpdate;
  String? lastestUserUpdate;
  String? id;

  DocumentDetail(
      {this.fileName,
      this.avatarUrl,
      this.fileOriginName,
      this.createDate,
      this.description,
      this.author,
      this.isLike,
      this.isHaveDownloadPremission,
      this.categoryName,
      this.okmUuid,
      this.lastestTimeUpdate,
      this.lastestUserUpdate,
      this.id});

  DocumentDetail.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'];
    avatarUrl = json['avatarUrl'];
    fileOriginName = json['fileOriginName'];
    createDate = json['createDate'];
    description = json['description'];
    author = json['author'];
    isLike = json['isLike'];
    isHaveDownloadPremission = json['isHaveDownloadPremission'];
    categoryName = json['categoryName'];
    okmUuid = json['okmUuid'];
    lastestTimeUpdate = json['lastestTimeUpdate'];
    lastestUserUpdate = json['lastestUserUpdate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileName'] = this.fileName;
    data['avatarUrl'] = this.avatarUrl;
    data['fileOriginName'] = this.fileOriginName;
    data['createDate'] = this.createDate;
    data['description'] = this.description;
    data['author'] = this.author;
    data['isLike'] = this.isLike;
    data['isHaveDownloadPremission'] = this.isHaveDownloadPremission;
    data['categoryName'] = this.categoryName;
    data['okmUuid'] = this.okmUuid;
    data['lastestTimeUpdate'] = this.lastestTimeUpdate;
    data['lastestUserUpdate'] = this.lastestUserUpdate;
    data['id'] = this.id;
    return data;
  }

  // copyWith
  DocumentDetail copyWith({
    String? fileName,
    String? avatarUrl,
    String? fileOriginName,
    String? createDate,
    String? description,
    String? author,
    bool? isLike,
    bool? isHaveDownloadPremission,
    dynamic categoryName,
    String? okmUuid,
    dynamic lastestTimeUpdate,
    String? lastestUserUpdate,
    String? id,
  }) {
    return DocumentDetail(
      fileName: fileName ?? this.fileName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      fileOriginName: fileOriginName ?? this.fileOriginName,
      createDate: createDate ?? this.createDate,
      description: description ?? this.description,
      author: author ?? this.author,
      isLike: isLike ?? this.isLike,
      isHaveDownloadPremission: isHaveDownloadPremission ?? this.isHaveDownloadPremission,
      categoryName: categoryName ?? this.categoryName,
      okmUuid: okmUuid ?? this.okmUuid,
      lastestTimeUpdate: lastestTimeUpdate ?? this.lastestTimeUpdate,
      lastestUserUpdate: lastestUserUpdate ?? this.lastestUserUpdate,
      id: id ?? this.id,
    );
  }
}

// Comment model
class CommentModel {
  String? fileId;
  String? studentId;
  String? studentName;
  String? avatar;
  String? content;
  bool? collapse;
  dynamic parentId;
  dynamic studentIdMention;
  int? level;
  int? totalCommentRemain;
  List<CommentModel>? children;
  bool? isEdit;
  bool? isDelete;
  dynamic lastModificationTime;
  dynamic lastModifierId;
  String? creationTime;
  String? creatorId;
  String? id;

  CommentModel(
      {this.fileId,
      this.studentId,
      this.studentName,
      this.avatar,
      this.content,
      this.collapse,
      this.parentId,
      this.studentIdMention,
      this.level,
      this.totalCommentRemain,
      this.children,
      this.isEdit,
      this.isDelete,
      this.lastModificationTime,
      this.lastModifierId,
      this.creationTime,
      this.creatorId,
      this.id});

  CommentModel.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    studentId = json['studentId'];
    studentName = json['studentName'];
    avatar = json['avatar'];
    content = json['content'];
    collapse = json['collapse'];
    parentId = json['parentId'];
    studentIdMention = json['studentIdMention'];
    level = json['level'];
    totalCommentRemain = json['totalCommentRemain'];
    if (json['children'] != null && json['children'].length > 0) {
      children = <CommentModel>[];
      json['children'].forEach((v) {
        children!.add(new CommentModel.fromJson(v));
      });
    }
    isEdit = json['isEdit'];
    isDelete = json['isDelete'];
    lastModificationTime = json['lastModificationTime'];
    lastModifierId = json['lastModifierId'];
    creationTime = json['creationTime'];
    creatorId = json['creatorId'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['studentId'] = this.studentId;
    data['studentName'] = this.studentName;
    data['avatar'] = this.avatar;
    data['content'] = this.content;
    data['collapse'] = this.collapse;
    data['parentId'] = this.parentId;
    data['studentIdMention'] = this.studentIdMention;
    data['level'] = this.level;
    data['totalCommentRemain'] = this.totalCommentRemain;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    data['isEdit'] = this.isEdit;
    data['isDelete'] = this.isDelete;
    data['lastModificationTime'] = this.lastModificationTime;
    data['lastModifierId'] = this.lastModifierId;
    data['creationTime'] = this.creationTime;
    data['creatorId'] = this.creatorId;
    data['id'] = this.id;
    return data;
  }

  // copyWith
  CommentModel copyWith({
    String? fileId,
    String? studentId,
    String? studentName,
    String? avatar,
    String? content,
    bool? collapse,
    dynamic parentId,
    dynamic studentIdMention,
    int? level,
    int? totalCommentRemain,
    List<CommentModel>? children,
    bool? isEdit,
    bool? isDelete,
    dynamic lastModificationTime,
    dynamic lastModifierId,
    String? creationTime,
    String? creatorId,
    String? id,
  }) {
    return CommentModel(
      fileId: fileId ?? this.fileId,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      avatar: avatar ?? this.avatar,
      content: content ?? this.content,
      collapse: collapse ?? this.collapse,
      parentId: parentId ?? this.parentId,
      studentIdMention: studentIdMention ?? this.studentIdMention,
      level: level ?? this.level,
      totalCommentRemain: totalCommentRemain ?? this.totalCommentRemain,
      children: children ?? this.children,
      isEdit: isEdit ?? this.isEdit,
      isDelete: isDelete ?? this.isDelete,
      lastModificationTime: lastModificationTime ?? this.lastModificationTime,
      lastModifierId: lastModifierId ?? this.lastModifierId,
      creationTime: creationTime ?? this.creationTime,
      creatorId: creatorId ?? this.creatorId,
      id: id ?? this.id,
    );
  }
}

// Comment dto
class CommentDto {
  String? fileId;
  String? content;
  dynamic parentId;
  dynamic studentId;
  dynamic studentIdMention;
  int? level;

  CommentDto({this.fileId, this.content, this.parentId, this.studentId, this.studentIdMention, this.level});

  CommentDto.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    content = json['content'];
    parentId = json['parentId'];
    studentId = json['studentId'];
    studentIdMention = json['studentIdMention'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['content'] = this.content;
    data['parentId'] = this.parentId;
    data['studentId'] = this.studentId;
    data['studentIdMention'] = this.studentIdMention;
    data['level'] = this.level;
    return data;
  }
}
