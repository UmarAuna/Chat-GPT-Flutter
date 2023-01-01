import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:open_ai_chat_gpt/model/chatmodel.dart';
import 'package:open_ai_chat_gpt/model/util.dart';
import 'package:provider/provider.dart';

class UserInput extends StatefulWidget {
  final TextEditingController chatController;
  final ScrollController scrollController;
  const UserInput({
    Key? key,
    required this.chatController,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 5,
          right: 5,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff444654),
          border: Border(
            top: BorderSide(
              color: Color(0xffd1d5db),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                "images/user_avatar.png",
                width: 40,
                height: 40,
              ),
            ),
            Expanded(
              flex: 5,
              child: TextFormField(
                onFieldSubmitted: (e) {
                  context.read<ChatModel>().sendChat(e);
                  widget.chatController.clear();
                },
                controller: widget.chatController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  focusColor: Colors.white,
                  filled: true,
                  fillColor: Color(0xff343541),
                  /* suffixIcon: Icon(
                    Icons.send,
                    color: Color(0xffacacbe),
                  ), */
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                  if (widget.chatController.text.isEmpty) {
                    _showAlertDialog('Text Field is empty', 'Text Field cannot be empty');
                  } else if (await internetConnectivity()) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      widget.scrollController.animateTo(
                          widget.scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.fastOutSlowIn);
                    });

                    context
                        .read<ChatModel>()
                        .sendChat(widget.chatController.text);
                    widget.chatController.clear();
                  } else {
                    _showAlertDialog('No Internet Connection', 'Please connect to the internet');
                  }
                },
                child: const Icon(
                  Icons.send,
                  color: Color(0xffacacbe),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAlertDialog(String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Center(child: Text(description)),
              ],
            ),
          ),
          actions: <Widget>[
            /* TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ), */
            TextButton(
              child: const Center(child: Text('Ok')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
