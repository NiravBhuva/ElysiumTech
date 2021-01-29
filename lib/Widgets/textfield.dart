import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key key,
    @required this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.contentPadding,
    this.maxLines,
    this.squareInput = true,
    this.readOnly = false,
    this.controller,
    this.obscureText = false,
    this.fillColor,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
    this.onSubmitted,
    this.validator,
    this.onTap
  });

  final Function onChanged;
  final Function onSubmitted;
  final Function validator;
  final bool squareInput;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final int maxLength;
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final EdgeInsets contentPadding;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Color fillColor;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      onTap: this.onTap,
      readOnly: this.readOnly,
      maxLines: this.maxLines ?? 1,
      obscureText: this.obscureText,
      onChanged: this.onChanged,
      keyboardType: this.keyboardType,
      maxLength: this.maxLength,
      textInputAction: this.textInputAction ?? TextInputAction.next,
      onFieldSubmitted:
          this.onSubmitted ?? (_) => FocusScope.of(context).nextFocus(),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(251, 176, 59, 1)),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: this.fillColor ?? Colors.transparent,
        hintText: this.placeholder,
        hintStyle: TextStyle(color: Color.fromRGBO(166, 166, 166, 1)),
        contentPadding: this.contentPadding != null
            ? this.contentPadding
            : EdgeInsets.all(12),
        suffixIcon: this.suffixIcon,
        prefixIcon: this.prefixIcon,
      ),
    );
  }
}
