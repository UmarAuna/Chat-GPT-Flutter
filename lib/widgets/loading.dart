
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Loading extends StatelessWidget {
  final String text;
  const Loading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff444654),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 3,
                top: 10,
                bottom: 5
              ),
            child: Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: const Color(0xff0fa37f),
                  padding: const EdgeInsets.all(3),
                  child: SvgPicture.asset(
                    "images/ai_avatar.svg",
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
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
                bottom: 5
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