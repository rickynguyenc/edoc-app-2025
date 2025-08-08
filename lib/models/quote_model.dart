import 'package:edoc_tabcom/core/models/base_model.dart';

class BaseQuoteModel {
  String? text;
  String? tag;
  String? author;

  BaseQuoteModel({this.text, this.author, this.tag});

  factory BaseQuoteModel.fromJson(Map<String, dynamic> json) {
    return BaseQuoteModel(
      text: json['text'],
      tag: json['tag'],
      author: json['author'],
    );
  }
}

class QuoteModel extends BaseModel {
  List<BaseQuoteModel>? quotes;

  QuoteModel({this.quotes});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quotes: (json['quotes'] as List<dynamic>?)?.map((quote) => BaseQuoteModel.fromJson(quote)).toList(),
    );
  }
}
