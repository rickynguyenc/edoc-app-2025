import 'package:edoc_tabcom/models/ai_agent_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/ai_chatbot_service.dart';

final textRefactorTypeIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final improveLoading = StateProvider<bool>((ref) {
  return false;
});

final aiImproveTextsProvider = StateNotifierProvider<ImproveTextsNotifier, ImproveTextResponse>(
  (ref) => ImproveTextsNotifier(ref),
);
class ImproveTextsNotifier extends StateNotifier<ImproveTextResponse> {
  final Ref ref;
  ImproveTextsNotifier(this.ref) : super(ImproveTextResponse());
  late final aiService = ref.read(aiChatbotServiceProvider);
  late final genarateDocLoadingNotifier = ref.read(improveLoading.notifier);
  Future<void> improveTexts(ImproveTextDto body) async {
    try {
      genarateDocLoadingNotifier.state = true;
      final response = await aiService.improveText(body.toJson());
      genarateDocLoadingNotifier.state = false;
      state = response;
    } catch (e) {
      state = ImproveTextResponse(
        isSuccessful: false,
        errorMessage: e.toString(),
      );
    }
  }
}