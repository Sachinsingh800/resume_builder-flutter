import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CustomTextField({
    required this.title,
    required this.controller,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "$title",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          // height: 25,
          width: 150,
          child: SingleChildScrollView(
                      //  scrollDirection: Axis.horizontal,
            child: TextFormField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              validator: validator,
              onSaved: onSaved,
            ),
          ),
        ),
      ],
    );
  }
}
