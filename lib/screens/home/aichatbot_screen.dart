import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/utils/widgets/appbar_template_widget.dart';

@RoutePage()
class AichatbotScreen extends HookConsumerWidget {
  final String fileId;
  const AichatbotScreen(this.fileId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sample chat messages for UI demo
    final messages = useState<List<Map<String, String>>>([
      // {
      //   'role': 'bot',
      //   'text': 'Xin chào! Tôi có thể giúp gì cho bạn về file này?'
      // },
      // {'role': 'user', 'text': 'File này có nội dung gì?'},
      // {'role': 'bot', 'text': 'File này chứa thông tin về hợp đồng lao động.'},
    ]);
    final controller = useTextEditingController();

    void handleSend() {
      final text = controller.text.trim();
      if (text.isNotEmpty) {
        messages.value = [
          ...messages.value,
          {'role': 'user', 'text': text}
        ];
        controller.clear();
        // TODO: Add AI response logic here
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Container(
                // margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        '17:30',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: messages.value.length,
                itemBuilder: (context, index) {
                  final msg = messages.value[index];
                  final isUser = msg['role'] == 'user';
                  // Add a fake timestamp for demo; replace with real time if available
                  final now = DateTime.now();
                  final timestamp =
                      "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
                  return Align(
                    alignment:
                        isUser ? Alignment.centerRight : Alignment.centerLeft,
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
                            color: isUser ? Color(0xffef2e34) : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(isUser ? 18 : 4),
                              bottomRight: Radius.circular(isUser ? 4 : 18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            msg['text'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 4),
                          child: Text(
                            timestamp,
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
