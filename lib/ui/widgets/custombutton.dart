import 'package:ecommerce_daxno/core/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final hinttext;
  // final text;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
  AutovalidateMode? autoValidateMode;
  final sufFixIcon;
  final textInputAction;
  final keyBoardType;
  final maxLine;
  InputDecoration? inputDecoration;
  final prefixIcon;
  bool obscureText;
  List<TextInputFormatter>? inputFormatter;

  CustomTextField({
    this.hinttext,
    this.onChanged,
    this.prefixIcon,
    // this.text,
    this.obscureText = false,
    this.autoValidateMode,
    this.validator,
    this.controller,
    this.sufFixIcon,
    this.keyBoardType,
    this.textInputAction,
    this.maxLine,
    this.inputDecoration,
    this.inputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),

          // margin: EdgeInsets.only(left: 20, right: 20),
          child: TextFormField(
            inputFormatters: inputFormatter,
            cursorColor: primaryColor,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            textInputAction: textInputAction,
            keyboardType: keyBoardType,
            controller: controller,
            autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
            decoration: inputDecoration ??
                InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  filled: true,
                  prefixIcon: prefixIcon ?? SizedBox(),
                  suffixIcon: sufFixIcon ?? SizedBox(),
                  // Icon(
                  //   Icons.alternate_email_outlined,
                  //   color: Color(0xFF666666),
                  // ),
                  fillColor: Color(0xFFF2F3F5),
                  hintStyle: TextStyle(
                    color: Color(0xFF666666),
                  ),
                  hintText: hinttext ?? "",
                ),
          ),
        ),
      ],
    );
  }
}
