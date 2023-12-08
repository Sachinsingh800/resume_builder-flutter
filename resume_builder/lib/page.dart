import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:resume_builder/models/ger_latest_resume.dart';

class YourPage extends StatefulWidget {
  @override
  _YourPageState createState() => _YourPageState();
}

class _YourPageState extends State<YourPage> {
  GetLatestResumeModel? latestResume; // Initialize as null

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
  try {
    final response = await http.get(
      Uri.parse('https://lizmyresume.onrender.com/user/getLatestResume'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        latestResume = GetLatestResumeModel.fromJson(jsonData['data']);
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Page'),
      ),
      body: latestResume == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${latestResume!.name}'), // Use ! to access non-null values
                  Text('Job Title: ${latestResume!.jobTitle}'), // Use ! to access non-null values
                  // Add more fields as needed
                ],
              ),
            ),
    );
  }
}
