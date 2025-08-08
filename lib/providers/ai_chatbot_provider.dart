import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ai_chatbot_model.dart';
import '../services/ai_chatbot_service.dart';

final askResponsesProvider = StateNotifierProvider<AskResponsesNotifier, List<AskResponse>>((ref) {
  return AskResponsesNotifier(ref);
});

// final askQuestionProvider = FutureProvider.family<AskResponse, Map<String, dynamic>>((ref, data) async {
//   final notifier = ref.watch(askResponsesProvider.notifier);
//   await notifier.askQuestion(data);
//   return notifier.state.last; // Return the last response after asking the question
// });

class AskResponsesNotifier extends StateNotifier<List<AskResponse>> {
  final Ref _ref;
  AskResponsesNotifier(this._ref) : super([]) ;
  late final AiChatbotService _aiChatbotService = _ref.read(aiChatbotServiceProvider);


  Future<void> askQuestion(Map<String, dynamic> data) async {
    try {
      final response = await _aiChatbotService.askQuestion(data);
      state = [...state, response];
    } catch (e) {
      // Handle error
      print('Error asking question: $e');
    }
  }

  Future<void> clearResponses() async {
    state = [];
  }
}