import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_ai_chat_gpt/repository/openai_repository.dart';
import 'package:open_ai_chat_gpt/widgets/ai_message.dart';
import 'package:open_ai_chat_gpt/widgets/loading.dart';
import 'package:open_ai_chat_gpt/widgets/user_message.dart';

class ChatModel extends ChangeNotifier {
  List<Widget> messages = [];

  List<Widget> get getMessages => messages;

  Future<void> sendChat(String txt) async {
    addUserMessage(txt);

    Map<String, dynamic> response =
        await OpenAiRepository.sendMessage(prompt: txt);
    String text = response['choices'][0]['text'];
    //remove the last item
    messages.removeLast();
    messages.add(AiMessage(text: text));

    notifyListeners();
    debugPrint(response.toString());
  }

  void addUserMessage(txt) {
    messages.add(UserMessage(text: txt));
    messages.add(const Loading(text: "......"));
    notifyListeners();
  }
}
