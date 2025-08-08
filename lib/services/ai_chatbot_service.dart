
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../core/app_dio.dart';
import '../models/ai_chatbot_model.dart';
part 'ai_chatbot_service.g.dart';
final aiChatbotServiceProvider = Provider<AiChatbotService>((ref) {
  return AiChatbotService(ref);
});
@RestApi()
abstract class AiChatbotService {
  factory AiChatbotService(Ref ref) => _AiChatbotService(ref.read(dioProvider));
  @POST('/api/app/a-iAgent/ask-document')
  Future<AskResponse> askQuestion(@Body() Map<String, dynamic> data);//{"fileId":"3a0f02ea-324f-825e-05f2-fff5e2413cf4","question":"Xin chao gioi thieu cho toi tai lieu nay","language":"vi","includeReferences":true}
  @POST('/api/app/a-iAgent/generate-document')
  Future<dynamic> genarateDocument(@Body() Map<String, dynamic> data);
  @POST('/api/app/a-iAgent/improve-text')
  Future<dynamic> improveText(@Body() Map<String, dynamic> data);
}