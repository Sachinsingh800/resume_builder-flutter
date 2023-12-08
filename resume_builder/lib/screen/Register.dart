import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:resume_builder/screen/Login.dart';
import 'package:resume_builder/verify_email_screen.dart';

import 'homepage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: RegisterDesign(),
          ),
        ),
      ),
    );
  }
}


class RegisterDesign extends StatefulWidget {
  const RegisterDesign({super.key});

  @override
  State<RegisterDesign> createState() => _RegisterDesignState();
}

class _RegisterDesignState extends State<RegisterDesign> with SingleTickerProviderStateMixin {

  bool _isLoding = false;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

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
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void register(name, email, password) async {
    setState(() {
      _isLoding = true;
    });
    final requestBody = {
      'name': name,
      'email': email,
      'password': password,
    };
    final String requestBodyJson = jsonEncode(requestBody);

    try {
      Response response = await post(
        Uri.parse('https://lizmyresume.onrender.com/user/auth/register'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );
      if (response.statusCode == 201) {
        setState(() {
          _isLoding = false;
        });
        var data = jsonDecode(response.body.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "Register successfully ${response.statusCode}${response.body}"),
          ),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  VerifyEmailScreen(email: email)));
      } else {
        setState(() {
          _isLoding = false;
        });
        print('Failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${response.statusCode} Body:${response.body}"),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoding = false;
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
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Enter Name"),
        ),
      );
    }else if(_emailController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Enter Email"),
        ),
      );
    }else if(_passwordController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Enter Password"),
        ),
      );
    }else if(_passwordController.text != _confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Password Does not match"),
        ),
      );
    }else{

      register(_nameController.text.toString(), _emailController.text.toString(),
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
                "Create Account",
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MontserratBold",
                ),
              ),
              Text(
                "Sign up to get Started!!!",
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
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontFamily: "MontserratRegular",
                  ),
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    labelText: "Full Name",
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
              SizedBox(
                height: 16,
              ),
              TextField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmPasswordController,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                    fontFamily: "MontserratRegular",
                  ),
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password",
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
                height: 36,
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
                    child: _isLoding ? CircularProgressIndicator(strokeWidth: 2, color: Colors.white,):Text(
                      "Sign Up",
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
                      context, MaterialPageRoute(builder: (_) => Login()));
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
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontFamily: "MontserratBold",
                          ),
                        ),
                        Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 16,
                            color:  Color(0xFF02AABD),
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
                onTap:(){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> HomePage()));
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
