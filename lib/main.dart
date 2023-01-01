import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_ai_chat_gpt/model/chatmodel.dart';
import 'package:open_ai_chat_gpt/widgets/user_input.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Open AI Chat",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  _scrollToBottom() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    /* final bottomOffset = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    ); */
  }

  @override
  void initState() {
    super.initState();
    /* _scrollController = ScrollController();
      Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        _scrollToBottom();
      } else {
        timer.cancel();
      }
    }); */
  }

  @override
  void dispose() {
    super.dispose();
    /* _scrollController.dispose(); */
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    TextEditingController chatController = TextEditingController();

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: const Color(0xff343541),
        appBar: AppBar(
          backgroundColor: const Color(0xff343541),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.home_outlined,
              color: Color(0xffd1d5db),
            ),
          ),
          elevation: 0,
          title: const Text("New Chat"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: SvgPicture.asset(
                    "images/ai_avatar.svg",
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                  applicationName: 'Chat GPT App',
                  applicationVersion: '0.0.1',
                  applicationLegalese: '©2022 umarauna.xyz',
                  children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text('Chat GPT demo app built with Flutter'))
                  ],
                );
              },
              icon: const Icon(
                Icons.info_outline,
                color: Color(0xffd1d5db),
              ),
            ),
          ],
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ChatModel()),
          ],
          child: Consumer<ChatModel>(builder: (context, model, child) {
            List<Widget> messages = model.getMessages;
            return Stack(
              children: [
                //chat

                Container(
                  margin: const EdgeInsets.only(bottom: 80),
                  child: ListView(
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: [
                      const Divider(
                        color: Color(0xffd1d5db),
                      ),
                      for (int i = 0; i < messages.length; i++) messages[i]
                    ],
                  ),
                ),

                UserInput(
                  chatController: chatController,
                  scrollController: _scrollController,
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
