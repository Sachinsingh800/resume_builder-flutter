// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:resume_builder/screen/Register.dart';
import 'package:resume_builder/screen/forgot_password_screen.dart';
import 'package:resume_builder/screen/homepage.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  // FocusNode focusNode = FocusNode();
  // String? email;
  // String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LoginDesign(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginDesign extends StatefulWidget {
  const LoginDesign({super.key});

  @override
  State<LoginDesign> createState() => _LoginDesignState();
}

class _LoginDesignState extends State<LoginDesign>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create an animation controller with a duration
    _controller = AnimationController(
      vsync: this, // Use the widget's TickerProvider
      duration: Duration(milliseconds: 800), // Adjust the duration as needed
    );

    // Create an animation with a curve
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInCirc);

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void login(email, password) async {
    final requestBody = {
      'email': email,
      'password': password,
    };
    final String requestBodyJson = jsonEncode(requestBody);
    setState(() {
      _isLoading = true;
    });
    try {
      Response response = await post(
        Uri.parse('https://lizmyresume.onrender.com/user/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('Login Successfully');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['data']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login successfully"),
          ),
        );
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage(), maintainState: false,));
      } else {
        setState(() {
          _isLoading = false;
        });
        print('Failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.statusCode}${response.body}"),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${e.toString()}"),
        ),
      );
    }
  }

  void _submitForm() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter Email"),
        ),
      );
    } else if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter Password"),
        ),
      );
    } else {
      login(_emailController.text.toString(),
          _passwordController.text.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Expanded(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                "Welcome to Resume Builder",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MontserratBold",
                ),
              ),
              Text(
                "Sign in to continue!!!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 60,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontFamily: "MontserratRegular",
                  ),
                  decoration: InputDecoration(
                    hintText: "Email ID",
                    labelText: "Email ID",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontFamily: "MontserratRegular",
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontFamily: "MontserratRegular",
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  )),
              SizedBox(
                height: 16,
              ),
              TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontFamily: "MontserratRegular",
                  ),
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontFamily: "MontserratRegular",
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontFamily: "MontserratRegular",
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ForgotPasswordScreen()));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 42,
                    width: 120,
                    child: Center(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF02AABD),
                          fontWeight: FontWeight.bold,
                          fontFamily: "MontserratBold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _submitForm,
                child: Container(
                  width: double.infinity, // Set the desired width
                  height: 49.0, // Set the desired height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFF02AABD),
                        Color(0xFF00CDAC)
                      ], // Replace with your desired colors
                    ),
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          )
                        : Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: "MontserratBold",
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Register()));
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MontserratBold",
                          ),
                        ),
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF02AABD),
                            fontWeight: FontWeight.bold,
                            fontFamily: "MontserratBold",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 49.0, // Set the desired height
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF02AABD),
                          Color(0xFF00CDAC)
                        ], // Replace with your desired colors
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "MontserratBold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
