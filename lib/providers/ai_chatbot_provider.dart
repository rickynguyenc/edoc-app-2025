import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/ai_chatbot_model.dart';
import '../services/ai_chatbot_service.dart';

final askResponsesProvider =
    StateNotifierProvider<AskResponsesNotifier, List<AskResponse>>((ref) {
  return AskResponsesNotifier(ref);
});

// final askQuestionProvider = FutureProvider.family<AskResponse, Map<String, dynamic>>((ref, data) async {
//   final notifier = ref.watch(askResponsesProvider.notifier);
//   await notifier.askQuestion(data);
//   return notifier.state.last; // Return the last response after asking the question
// });

class AskResponsesNotifier extends StateNotifier<List<AskResponse>> {
  final Ref _ref;
  AskResponsesNotifier(this._ref)
      : super([
          AskResponse(
            response: 'Welcome to AI Chatbot',
          )
        ]);
  late final AiChatbotService _aiChatbotService =
      _ref.read(aiChatbotServiceProvider);

  Future<void> askQuestion(String fileId, String question) async {
    try {
      final now = DateTime.now();
      final timestamp =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      state = [
        ...state,
        AskResponse(
          response: question,
          interactionId: "temp-id",
          tokensUsed: 0,
          processingTimeMs: 0,
          modelUsed: "AI Model",
          cost: 0.0,
          references: null,
          isSuccessful: true,
          errorMessage: null,
          role: 'user',
          timestamp: timestamp, // Format as HH:mm
        ),
        AskResponse(
          response: "Đang phân tích tài liệu và tạo phản hồi",
          interactionId: "temp-id",
          tokensUsed: 0,
          processingTimeMs: 0,
          modelUsed: "AI Model",
          cost: 0.0,
          references: null,
          isSuccessful: true,
          errorMessage: null,
          role: 'waiting',
          timestamp: timestamp,
        ),
      ];
      final inputBody = {
        "fileId": fileId,
        "question": question,
        "language": "vi",
        "includeReferences": true
      };
      final response = await _aiChatbotService.askQuestion(inputBody);
      removeLastResponse();
      state = [...state, response];
    } catch (e) {
      // Handle error
      print('Error asking question: $e');
    }
  }

  // add one response to the list
  addResponse(AskResponse response) {
    state = [...state, response];
  }

  // remove one response from the list
  removeResponse(AskResponse response) {
    state = state.where((item) => item != response).toList();
  }

  //remove last response from the list
  removeLastResponse() {
    if (state.isNotEmpty) {
      state = state.sublist(0, state.length - 1);
    }
  }

  void clearResponses() {
    state = [
      AskResponse(
        response: 'Welcome to AI Chatbot',
      )
    ];
  }
}
