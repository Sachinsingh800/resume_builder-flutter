import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:resume_builder/screen/Login.dart';
import 'package:resume_builder/screen/verify_forgot_password_screen.dart';
import 'package:resume_builder/verify_email_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  TextEditingController _emailController = TextEditingController();

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
    _controller.dispose();
    super.dispose();
  }

  Future<String> sendOTP(
    String email,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final apiUrl =
          Uri.parse('https://lizmyresume.onrender.com/user/auth/forgetPass');
      final headers = {
        'Content-Type': 'application/json',
      };

      final userData = {
        'email': email,
      };

      final response = await http.post(
        apiUrl,
        headers: headers,
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerifyForgotPasswordEmailScreen(email: email)));

        return "Verified successfully ${response.statusCode}${response.body}"; // Data posted successfully
      } else {
        setState(() {
          _isLoading = false;
        });
        print('HTTP Error: ${response.statusCode}');
        return "${response.statusCode} ${response.body}"; // Data posting failed
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $error');
      return "Error Occurred-$error"; // Data posting failed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Expanded(
            child: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Lottie.asset(
                    'assets/raw/reset.json',
                    width: 200,
                    height: 300,
                    repeat: true,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontFamily: "MontserratBold",
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Will send you One Time Passcode \nto this email address",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontFamily: "MontserratRegular",
                    ),
                  ),
                  SizedBox(
                    height: 36,
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
                        hintText: "Enter your Email",
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
                        disabledBorder: OutlineInputBorder(
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
                  GestureDetector(
                    onTap: () async {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Enter Email"),
                          ),
                        );
                      } else {
                        String message =
                            await sendOTP(_emailController.text.trim());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity, // Set the desired width
                      height: 52.0, // Set the desired height
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
                                "Send OTP",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: ResetDialog(),
        );
      },
    );
  }
}

class ResetDialog extends StatefulWidget {
  const ResetDialog({
    super.key,
  });

  @override
  State<ResetDialog> createState() => _ResetDialogState();
}

class _ResetDialogState extends State<ResetDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/raw/done.json',
            width: 180,
            height: 180,
            repeat: true,
          ),
          SizedBox(
            height: 8,
          ),
          const Text(
            "Email verified \nsuccessfully",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.normal,
              fontFamily: "MontserratRegular",
            ),
          ),
          SizedBox(
            height: 36,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => Login()));
            },
            child: Container(
              width: 120, // Set the desired width
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
                  "Login",
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
        ],
      ),
    );
  }
}
