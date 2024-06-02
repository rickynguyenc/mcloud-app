import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubmitButton extends HookConsumerWidget {
  final Function() onPressed;
  final String text;
  final Color? color;
  const SubmitButton(this.text, {Key? key, required this.onPressed, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Color(0xFF055FA7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(56),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
