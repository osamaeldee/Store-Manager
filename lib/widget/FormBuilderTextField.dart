import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFormBuilderTextField extends StatefulWidget {
  final String name;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final int fontSize;
  final Color color;
  final int borderRadius;
  final TextInputType? keyboardType;
  const CustomFormBuilderTextField({
    Key? key,
    required this.name,
    required this.labelText,
    this.validator,
    required this.fontSize,
    required this.color,
    required this.borderRadius,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<CustomFormBuilderTextField> createState() =>
      _CustomFormBuilderTextFieldState();
}

class _CustomFormBuilderTextFieldState
    extends State<CustomFormBuilderTextField> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      keyboardType: widget.keyboardType,
      name: widget.name,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: widget.fontSize.toDouble(),
          color: const Color.fromARGB(255, 0, 0, 0), // Set text color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color),
          borderRadius: BorderRadius.circular(widget.borderRadius.toDouble()),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.color),
          borderRadius: BorderRadius.circular(widget.borderRadius.toDouble()),
        ),
      ),
      validator: widget.validator,
    );
  }
}
