import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget {
  final String text;
  final bool isDone;

  ToDoWidget({required this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: const EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
                color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone ? null : Border.all(
                    color: const Color(0xFF86829D),
                    width: 1.5
                )
            ),
            child: const Image(
              image: AssetImage('assets/images/check_icon.png'),
            ),
          ),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                color: isDone ? const Color(0xFF86829D)  : const Color(0xFF211551),
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}