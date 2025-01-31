import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final TextEditingController controller;
    final  String label;
  final String hint;
      final bool? numType;
  const CommonTextField({super.key, required this.controller, required this.label, required this.hint, this.numType});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          TextField(
            keyboardType: widget.numType==true?TextInputType.number:TextInputType.name,
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: widget.hint,
            ),
          ),
        ],
      ),
    );
  }
}
