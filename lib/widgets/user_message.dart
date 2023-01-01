
import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final String text;
  const UserMessage({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
           padding: const EdgeInsets.only(
                left: 3,
                top: 5,
                bottom: 5
              ),
            child: Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/user_avatar.png",
                  height: 30,
                  width: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 3,
                top: 20,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xffd1d5db),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}