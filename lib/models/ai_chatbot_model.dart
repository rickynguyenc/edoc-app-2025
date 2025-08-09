class AskResponse {
  String? response;
  String? interactionId;
  num? tokensUsed;
  num? processingTimeMs;
  String? modelUsed;
  num? cost;
  dynamic references;
  bool? isSuccessful;
  dynamic errorMessage;
  String? role;
  String? timestamp;

  AskResponse(
      {this.response,
      this.interactionId,
      this.tokensUsed,
      this.processingTimeMs,
      this.modelUsed,
      this.cost,
      this.references,
      this.isSuccessful,
      this.errorMessage,
      this.role = 'user',
      this.timestamp});

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
    role = 'ai';
    final now = DateTime.now();
    timestamp =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
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
    data['role'] = this.role;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
