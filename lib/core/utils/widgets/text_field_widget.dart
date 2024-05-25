import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? Function(String?)? validateFunc;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String hintText;
  final GlobalKey<FormState> formKey;
  const TextFieldWidget({super.key, required this.validateFunc, required this.controller, required this.hintText, required this.formKey, required this.onChanged});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          fillColor: Color(0xFFF4F6F9),
          filled: true,
          hintStyle: TextStyle(color: Color.fromRGBO(165, 165, 171, 1)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(width: 1, color: Color(0xFF055FA7)),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              style: BorderStyle.none,
            ),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(234, 84, 85, 1),
              )),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(
              width: 1,
              color: Color.fromRGBO(234, 84, 85, 1),
            ),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validateFunc,
      ),
    );
  }
}
