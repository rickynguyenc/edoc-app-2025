class AskResponse {
  String? response;
  String? interactionId;
  int? tokensUsed;
  int? processingTimeMs;
  String? modelUsed;
  double? cost;
  dynamic references;
  bool? isSuccessful;
  dynamic errorMessage;

  AskResponse(
      {this.response,
      this.interactionId,
      this.tokensUsed,
      this.processingTimeMs,
      this.modelUsed,
      this.cost,
      this.references,
      this.isSuccessful,
      this.errorMessage});

  AskResponse.fromJson(Map<String, dynamic> json) {
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