class GenarateDocDto {
  String? documentType;
  String? title;
  String? requirements;
  String? tone;
  String? length;
  String? language;
  bool? includeVisuals;

  GenarateDocDto(
      {this.documentType,
      this.title,
      this.requirements,
      this.tone,
      this.length,
      this.language,
      this.includeVisuals});

  GenarateDocDto.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    title = json['title'];
    requirements = json['requirements'];
    tone = json['tone'];
    length = json['length'];
    language = json['language'];
    includeVisuals = json['includeVisuals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentType'] = this.documentType;
    data['title'] = this.title;
    data['requirements'] = this.requirements;
    data['tone'] = this.tone;
    data['length'] = this.length;
    data['language'] = this.language;
    data['includeVisuals'] = this.includeVisuals;
    return data;
  }
}

// Response genarate document
class GenarateDocResponse {
  String? response;
  String? interactionId;
  num? tokensUsed;
  num? processingTimeMs;
  String? modelUsed;
  num? cost;
  dynamic references;
  bool? isSuccessful;
  dynamic errorMessage;

  GenarateDocResponse(
      {this.response,
      this.interactionId,
      this.tokensUsed,
      this.processingTimeMs,
      this.modelUsed,
      this.cost,
      this.references,
      this.isSuccessful,
      this.errorMessage});

  GenarateDocResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    interactionId = json['interactionId'];
    tokensUsed = json['tokensUsed'];
    processingTimeMs = json['processingTimeMs'];
    modelUsed = json['modelUsed'];
    cost = json['cost'];
    references = json['references'];
    isSuccessful = json['isSuccessful'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['interactionId'] = this.interactionId;
    data['tokensUsed'] = this.tokensUsed;
    data['processingTimeMs'] = this.processingTimeMs;
    data['modelUsed'] = this.modelUsed;
    data['cost'] = this.cost;
    data['references'] = this.references;
    data['isSuccessful'] = this.isSuccessful;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

// Refactor text request
class ImproveTextDto {
  String? text;
  String? improvementType;
  String? tone;
  String? targetAudience;
  String? language;
  bool? showChanges;
  bool? provideExplanation;

  ImproveTextDto(
      {this.text,
      this.improvementType,
      this.tone,
      this.targetAudience,
      this.language,
      this.showChanges,
      this.provideExplanation});

  ImproveTextDto.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    improvementType = json['improvementType'];
    tone = json['tone'];
    targetAudience = json['targetAudience'];
    language = json['language'];
    showChanges = json['showChanges'];
    provideExplanation = json['provideExplanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['improvementType'] = this.improvementType;
    data['tone'] = this.tone;
    data['targetAudience'] = this.targetAudience;
    data['language'] = this.language;
    data['showChanges'] = this.showChanges;
    data['provideExplanation'] = this.provideExplanation;
    return data;
  }
}

class ImproveTextResponse {
  String? response;
  String? interactionId;
  num? tokensUsed;
  num? processingTimeMs;
  String? modelUsed;
  num? cost;
  dynamic references;
  bool? isSuccessful;
  dynamic errorMessage;

  ImproveTextResponse(
      {this.response,
      this.interactionId,
      this.tokensUsed,
      this.processingTimeMs,
      this.modelUsed,
      this.cost,
      this.references,
      this.isSuccessful,
      this.errorMessage});

  ImproveTextResponse.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    interactionId = json['interactionId'];
    tokensUsed = json['tokensUsed'];
    processingTimeMs = json['processingTimeMs'];
    modelUsed = json['modelUsed'];
    cost = json['cost'];
    references = json['references'];
    isSuccessful = json['isSuccessful'];
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['interactionId'] = this.interactionId;
    data['tokensUsed'] = this.tokensUsed;
    data['processingTimeMs'] = this.processingTimeMs;
    data['modelUsed'] = this.modelUsed;
    data['cost'] = this.cost;
    data['references'] = this.references;
    data['isSuccessful'] = this.isSuccessful;
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}