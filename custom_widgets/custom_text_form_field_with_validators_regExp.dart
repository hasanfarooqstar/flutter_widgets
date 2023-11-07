import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ground_booking_admin/constants/color_constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String? labelText;

  final TextInputType textInputType;
  // ignore: prefer_typing_uninitialized_variables
  final isOnlyDigits;
  final bool isRequired;
  final bool isPassword;
  final bool isDense;
  final Function(String?)? onSaved;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final int? minLines;
  final Widget? suffixIcon;
  final bool enabled;

  const CustomTextFormField({
    Key? key,
    this.isOnlyDigits = false,
    this.labelText,
    this.textInputType = TextInputType.text,
    this.isRequired = false,
    this.isPassword = false,
    this.controller,
    this.onSaved,
    this.validator,
    this.onChange,
    this.hintText,
    this.maxLines = 1,
    this.minLines=1,
    this.isDense = false,
    this.suffixIcon,
    this.enabled = true,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      enabled: widget.enabled,
      controller: widget.controller,
      inputFormatters: widget.isOnlyDigits
          ? [FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)$'))]
          : null,
      //initialValue: value ?? '',
      autofocus: false,
      obscureText: (widget.isPassword)
          ? _isPasswordVisible
              ? false
              : true
          : false,
      style: const TextStyle(
        fontSize: 16,
      ),
      cursorColor: ColorConstants.buttonPrimaryColor,
      keyboardType: widget.textInputType,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.digitsOnly
      // ],
      validator: !widget.isRequired ? null : widget.validator,
      onSaved: widget.onSaved,
      decoration: _decoration(context),
      onChanged: widget.onChange,
    );
  }

  InputDecoration _decoration(context) {
    return InputDecoration(
      hintText: widget.labelText ?? '',
      errorStyle: const TextStyle(height: 0),
      contentPadding: const EdgeInsets.all(10),
      isDense: widget.isDense,
      suffixIcon: widget.isPassword
          ? IconButton(
              splashRadius: 25,
              padding: const EdgeInsets.all(2),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility),
            )
          : widget.suffixIcon,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      disabledBorder:  OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      labelText: widget.labelText,
    );
  }
}