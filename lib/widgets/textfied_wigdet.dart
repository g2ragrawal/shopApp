import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {

  final String text;
  final bool isObscuredText;
  final IconData icon;
  final Function onChanged;
  final IconData preIcon;
  final Function onTapIcon;
  final Function validator;
  final Function onSaved;
  final controller;

  TextFieldWidget({this.text,this.icon,this.isObscuredText,this.onChanged,this.preIcon,this.onTapIcon,this.validator,this.onSaved,this.controller});



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: 18.0,
      ),
      cursorColor: Colors.redAccent,
      obscureText: isObscuredText,
      onChanged: onChanged,
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      decoration: InputDecoration(
        labelText: text,

        prefixIcon: Icon(
          icon,
          size: 20,
          color: Colors.redAccent,
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent,),
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: GestureDetector(
          onTap: onTapIcon,
          child: Icon(
            preIcon,
            size: 20,
            color: Colors.redAccent,
          ),
        ),
        labelStyle: TextStyle(color: Colors.redAccent,),
      ),
    );
  }
}
