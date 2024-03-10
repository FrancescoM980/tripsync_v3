import 'package:flutter/material.dart';

class CommonForm extends StatelessWidget {
  String titleText;
  IconData icon;
  double paddingHorizontal;
  bool isHidden;
  IconData? iconTrailing;
  final TextEditingController? controller;
  bool onlyRead;
  TextInputType inputType;
  void Function()? onTapTrailing;
  void Function()? onEditingComplete;
  void Function(String)? onChanged;
  void Function()? onTap;
  int? maxLines;
  String? Function(String?)? validator;
  CommonForm({
    super.key,
    required this.titleText,
    required this.icon,
    required this.paddingHorizontal,
    this.iconTrailing,
    this.onTapTrailing,
    this.onEditingComplete,
    this.isHidden = false,
    this.controller,
    this.onlyRead = false,
    this.onTap,
    this.validator,
    this.onChanged,
    this.maxLines,
    this.inputType = TextInputType.text
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(width: 3, color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(15)
        ),
        child: TextFormField(
          validator: validator,
          readOnly: onlyRead,
          onTap: onTap,
          controller: controller,
          maxLines: maxLines,
          keyboardType: inputType,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          obscureText: isHidden,
          decoration: InputDecoration(
            labelText: titleText,
            suffixIcon: iconTrailing != null
              ? IconButton(
                  onPressed: onTapTrailing,
                  icon: Icon(iconTrailing),
                )
              : null,
            filled: false,
            hintText: titleText,
            icon: Icon(icon),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0)
            ),
          ),
        )
      ),
    );
  }
}