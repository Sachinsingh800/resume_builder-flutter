import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile {

  Future<String> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = prefs.getString('token') ?? "";
    return savedToken;
  }

  Future<String> updateWithImage(File imageFile, String name, String number, String role) async {

    try {
      var stream = new http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();

      String? authToken = await loadToken();

      var uri = Uri.parse('https://lizmyresume.onrender.com/user/auth/updateProfile');
      var request = new http.MultipartRequest('PUT', uri);

      request.headers['x-auth-token'] = '$authToken';
      request.headers['Content-Type'] = 'application/json';

      request.fields['number'] = number;
      request.fields['role'] = role;
      request.fields['name'] = name;

      var multiport = new http.MultipartFile('url', stream, length);
      request.files.add(multiport);

      var reponse = await request.send();
      if (reponse.statusCode == 200) {
        return "Profile Updated${reponse.statusCode}";
      } else {
        return "${reponse.statusCode}-Failed";
      }
    } catch (error) {
      // Handle the error here
      return "An error occurred: $error";
    }
  }

  Future<String> updateProfile(String name, String number, String role) async {

    if(name.isNotEmpty && number.isNotEmpty && role.isNotEmpty){
      try {
        String? authToken = await loadToken();
        final apiUrl = Uri.parse('https://lizmyresume.onrender.com/user/auth/updateProfile');

        final headers = {
          'Content-Type': 'application/json',
          'x-auth-token': '$authToken',
        };

        final data = {
          'number': number,
          'role': role,
          'name': name,
        };
        final response = await http.put(
          apiUrl,
          headers: headers,
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          return "${response.body}"; // Data posted successfully
        } else {
          print('HTTP Error: ${response.statusCode} ${response.body}');
          return "HTTP Error:${response.statusCode} ${response.body}"; // Data posting failed
        }
      } catch (error) {
        print('Error: $error');
        return "Error Occurred-$error"; // Data posting failed
      }
    }else{
      return 'Enter All fields';
    }

  }

}