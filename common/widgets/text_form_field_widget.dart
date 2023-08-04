import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidgets extends StatelessWidget {
  const TextFormFieldWidgets(
      {super.key,
      required this.controller,
      required this.hintText,
      this.labelText,
      this.horizontal,
      this.keyboardType,
      this.suffixIcon,
      this.enabled,
      this.maxlines,
      this.vertical,
      this.maxlength,
      this.obsecureText,
      this.onTap});
  final TextEditingController controller;

  final String? labelText;
  final String? hintText;
  final double? horizontal;
  final double? vertical;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool? obsecureText;
  final int? maxlines;
  final int? maxlength;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal ?? 15.0, vertical: vertical ?? 8),
      child: TextFormField(
        // autovalidateMode: AutovalidateMode.,
        onTap: onTap,
        enabled: enabled, maxLines: maxlines ?? 1,
        maxLength: maxlength,
        textInputAction: TextInputAction.newline,
        obscureText: obsecureText ?? false,
        decoration: InputDecoration(
            isDense: true,
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 24, 97, 156),
                ),
                borderRadius: BorderRadius.circular(5)),
            //contentPadding:const EdgeInsets.only(left: 10.0,top: 5,bottom:5),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(6)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 24, 97, 156),
                ),
                borderRadius: BorderRadius.circular(5)),
            labelText: labelText,
            labelStyle: CommonStyles(context).hintStyle(color: Colors.grey),
            hintText: hintText,
            hintStyle: CommonStyles(context).hintStyle(color: Colors.black),
            suffixIcon: suffixIcon),
        style: CommonStyles(context).textFormFieldStyle(),
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            return null;
          }
          return "cannot empty";
        },
      ),
    );
  }
}
