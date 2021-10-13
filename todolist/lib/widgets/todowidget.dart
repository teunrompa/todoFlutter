import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget {
  final String text;
  final bool isDone;
  const ToDoWidget({Key? key ,required this.text, required this.isDone}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isDone ? const Color(0xFF86829D) : const Color(0xFF211551),
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
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