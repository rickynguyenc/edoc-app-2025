import 'dart:ffi';

import 'package:edoc_tabcom/services/ai_chatbot_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ai_agent_model.dart';

final docTypeIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final genarateDocLoading = StateProvider<bool>((ref) {
  return false;
});

final aiDocumentGeneratorProvider = StateNotifierProvider<AiDocumentGeneratorNotifier, GenarateDocResponse>(
  (ref) => AiDocumentGeneratorNotifier(ref),
);
class AiDocumentGeneratorNotifier extends StateNotifier<GenarateDocResponse> {
  final Ref ref;
  AiDocumentGeneratorNotifier(this.ref) : super(GenarateDocResponse());
  late final aiService = ref.read(aiChatbotServiceProvider);
  late final genarateDocLoadingNotifier = ref.read(genarateDocLoading.notifier);
  Future<void> generateDocument(GenarateDocDto body) async {
    try {
      genarateDocLoadingNotifier.state = true;
      final response = await aiService.genarateDocument(body.toJson());
      genarateDocLoadingNotifier.state = false;
      state = response;
    } catch (e) {
      state = GenarateDocResponse(
        isSuccessful: false,
        errorMessage: e.toString(),
      );
    }
  }
}