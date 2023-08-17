import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.name,
    this.regex,
    required this.controller,
    required this.keyboard,
    required this.onChanged,
  });
  final String name;
  final RegExp? regex;
  final TextEditingController controller;
  final TextInputType keyboard;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboard,
        inputFormatters: regex == null
            ? null
            : [
                FilteringTextInputFormatter.allow(
                  regex!,
                ),
              ],
        decoration: InputDecoration(
          labelText: name,
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.lightBlue, width: 1.5),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
