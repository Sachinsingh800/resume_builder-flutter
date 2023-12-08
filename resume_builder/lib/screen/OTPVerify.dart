// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_builder/screen/Login.dart';

class OTPVerify extends StatefulWidget {
  const OTPVerify({Key? key, this.email}) : super(key: key);

  // Add a named constructor that accepts phoneNumber
  const OTPVerify.withemail({Key? key, required this.email}) : super(key: key);

  final String? email;
  @override
  // ignore: library_private_types_in_public_api
  _OTPVerifyState createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Center(
                    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 70),
        Image.asset('assets/images/Group 183.png'),
        const SizedBox(height: 20),
        // Image.asset('assets/OTPVerify/OTP Verification.png'),
        const SizedBox(height: 20),
        Text('Enter the OTP sent to ${widget.email ?? "your email"}'),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
                height: 47,
                width: 47,
                child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin1) {},
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.titleLarge,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ])),
            SizedBox(
                height: 47,
                width: 47,
                child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin2) {},
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.titleLarge,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ])),
            SizedBox(
                height: 47,
                width: 47,
                child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin3) {},
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.titleLarge,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ])),
            SizedBox(
                height: 47,
                width: 47,
                child: TextFormField(
                    onChanged: (value) {
                      if (value.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    onSaved: (pin4) {},
                    decoration: const InputDecoration(hintText: "0"),
                    style: Theme.of(context).textTheme.titleLarge,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                    ])),
          ]),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {},
          child: const Text('Resend OTP',
              style: TextStyle(fontSize: 14, color: Color(0xff009AA4))),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  Login()));
          },
          child: Image.asset('assets/images/Frame 175.png'),
        )
      ],
    )))));
  }
}
