import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;
import '../../core/utils/widgets/appbar_template_widget.dart';
import '../../models/ai_chatbot_model.dart';
import '../../providers/ai_chatbot_provider.dart';

@RoutePage()
class AichatbotScreen extends HookConsumerWidget {
  final String fileId;
  AichatbotScreen(this.fileId, {super.key});
  final now = DateTime.now();
  late final timestamp =
      "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sample chat messages for UI demo
    final messages = ref.watch(askResponsesProvider);
    final askResponsesNotifier = ref.read(askResponsesProvider.notifier);
    final controller = useTextEditingController();
    useEffect(() {
      return () {
        // Clear the controller when the widget is disposed
        // Add delay to avoid rebuild issues when disposing
        Future.delayed(Duration(seconds: 1), () {
          askResponsesNotifier.clearResponses();
        });
      };
    }, []);
    void handleSend() {
      final text = controller.text.trim();
      if (text.isNotEmpty) {
        // to simulate the AI response after sending the question.
        ref.read(askResponsesProvider.notifier).askQuestion(fileId, text);
        // Clear the input field
        controller.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
            maxWidth: 40,
            maxHeight: 40,
          ),
          onPressed: () {
            context.router.pop();
          },
          padding: const EdgeInsets.all(0),
        ),
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          minLeadingWidth: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.support_agent_outlined, color: Colors.white),
              SizedBox(width: 8),
              Text('AI Trợ lý',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          subtitle: Text('Algorithmic thinking',
              style: TextStyle(color: Colors.white70, fontSize: 14)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffef2e34),
      ),
      body: Container(
        color: Color(0xfff6f7fb),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isUser = msg.role == 'user';
                  // Add a fake timestamp for demo; replace with real time if available
                  return index == 0
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          // margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          // constraints: BoxConstraints(maxWidth: 320),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Chào bạn! Tôi đã sẵn sàng trả lời các câu hỏi về tài liệu "Algorithmic thinking". Hãy đặt câu hỏi của bạn.',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey[500],
                                  size: 12,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  timestamp,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        )
                      : Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: isUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                constraints: BoxConstraints(maxWidth: 320),
                                decoration: BoxDecoration(
                                  color:
                                      isUser ? Color(0xffef2e34) : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                    bottomLeft:
                                        Radius.circular(isUser ? 18 : 4),
                                    bottomRight:
                                        Radius.circular(isUser ? 4 : 18),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: msg.role == "waiting"
                                    ? LoadingDots(
                                        text: msg.response ?? '',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                        ),
                                      )
                                    : Text(
                                        msg.errorMessage != null
                                            ? msg.errorMessage
                                            : msg.response ?? '',
                                        style: TextStyle(
                                          color: isUser
                                              ? Colors.white
                                              : Colors.black87,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, top: 2, bottom: 4),
                                child: Text(
                                  msg.timestamp ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              hintText: 'Đặt câu hỏi về tài liệu...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                            ),
                            onSubmitted: (_) => handleSend(),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Color(0xffef2e34)),
                          onPressed: handleSend,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingDots extends HookWidget {
  final String? text;
  final TextStyle? style;
  const LoadingDots({this.text, this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final dotCount = useState(0);
    useEffect(() {
      final timer = Future.doWhile(() async {
        await Future.delayed(const Duration(milliseconds: 400));
        dotCount.value = (dotCount.value + 1) % 4;
        return true;
      });
      return () {};
    }, []);
    return Text(
      "$text${'.' * dotCount.value}",
      style: style,
    );
  }
}
