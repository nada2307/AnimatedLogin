import 'package:flutter/material.dart';

import '../../core/resources/color_manager.dart';

class DefaultTextFormField extends StatefulWidget {
  DefaultTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    this.isPassword = false,
    this.isObscure = false,
    this.onTab,
    required this.validation,
    this.onChanged,
    required this.icon,
    this.focusNode,
  }) : super(key: key);
  final TextEditingController controller;
  final String label;
  final TextInputType keyboardType;
  Function? onTab;
  Function(String)? onChanged;
  bool? isPassword;
  bool? isObscure;
  final IconData icon;
  String? Function(String?)? validation;
  FocusNode? focusNode;

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: ColorManager.mainColor,
        ),
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        suffixIcon: widget.isPassword!
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure!;
                  });
                },
                icon: Icon(
                  widget.isObscure! ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      onTap: () {
        if (widget.onTab != null) {
          widget.onTab!();
        }
      },
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      keyboardType: widget.keyboardType,
      obscureText: widget.isObscure!,
      controller: widget.controller,
      validator: widget.validation,
    );
  }
}
