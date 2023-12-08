// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'IntroScreen3.dart';

class IntroScreen2 extends StatefulWidget {
  final VoidCallback onNextPressed;
  const IntroScreen2({super.key, required this.onNextPressed});

  @override
  State<IntroScreen2> createState() => _IntroScreen2State();
}

class _IntroScreen2State extends State<IntroScreen2>with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Color of the status bar
        statusBarIconBrightness: Brightness.dark, // Brightness of system icons (e.g., network, battery)
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark
      ),
    );
    // Create an animation controller with a duration
    _controller = AnimationController(
      vsync: this, // Use the widget's TickerProvider
      duration: Duration(milliseconds: 700), // Adjust the duration as needed
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.keyboard_backspace_outlined, color: Colors.black87,)),
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0,
            ),
            Container(
              height: 46,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: const Text(
                  "Customize",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "MontserratBold",
                  ),
                ),
              ),
            ),
            const Text(
              "Your Resume",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontFamily: "MontserratRegular",
              ),
            ),
            const Text(
              "According to your",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontFamily: "MontserratRegular",
              ),
            ),
            const Text(
              "Choice",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontFamily: "MontserratBold",
              ),
            ),

            Stack(
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Image.asset(
                    "assets/asifB.png",
                    width: double.infinity, // Set your desired width
                    height: MediaQuery.of(context).size.height * 0.4978038067, // Set your desired height
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.center,
              child: Padding(
                padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.42,).copyWith(top: MediaQuery.of(context).size.height * 0.08284773060029),
                child: SkipContainer(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 32,
        child: FloatingActionButton.extended(
          onPressed: () {
            widget.onNextPressed();
          },
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: "MontserratRegular",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkipContainer extends StatelessWidget {
  const SkipContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
        ),
        SizedBox(width: 16), // Add spacing between circles
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue, // You can change the color
          ),
        ),
        SizedBox(width: 16), // Add spacing between circles
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey, // You can change the color
          ),
        ),
      ],
    );
  }
}
