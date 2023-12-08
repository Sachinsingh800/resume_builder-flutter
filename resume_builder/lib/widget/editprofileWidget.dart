import 'package:flutter/material.dart';

class EditProfileWidget extends StatelessWidget {
  final String url;
  final String title;
  const EditProfileWidget({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(28, 0, 21, 0),
            child: Image.asset(url)
          ),
          Text(
            '$title',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
