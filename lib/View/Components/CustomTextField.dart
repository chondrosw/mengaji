import 'package:flutter/material.dart';
import 'package:mengaji/Shared/shared.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String title;
  String hint;
  String? error;
  bool isEmail;
  CustomTextField(
      {required this.controller,
      required this.title,
      required this.hint,
      required this.error,required this.isEmail});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: poppinsTitle4.copyWith(fontSize: 14),
        ),
        TextFormField(
          validator: (val){
            if(isEmail == true){
              final pattern = new RegExp(r'([\d\w]{1,}@[\w\d]{1,}\.[\w]{1,})');
              if (val != null)
                return pattern.hasMatch(val) ? null : 'email is invalid';
            }else{
              if(controller.text.isEmpty) return "Tidak boleh kosong";
            }
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        error == null || error!.isNotEmpty || error != ""
            ? Text(
                "Password harus sama",
                style: poppinsWhiteButton1.copyWith(color: Colors.red,fontSize: 12),
              )
            : SizedBox()
      ],
    );
  }
}
