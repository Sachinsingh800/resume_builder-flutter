// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'IntroScreen2.dart';

class IntroScreen1 extends StatefulWidget {
  final VoidCallback onNextPressed;
  const IntroScreen1({super.key, required this.onNextPressed});

  @override
  State<IntroScreen1> createState() => _IntroScreen1State();
}

class _IntroScreen1State extends State<IntroScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
// Set the status bar color, including the area behind system icons, to white
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
      body: FadeTransition(
        opacity: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            const Text(
              "Get Perfoessional",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontFamily: "MontserratRegular",
              ),
            ),
            Container(
              height: 46,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: const Text(
                  "Resume Builder",
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
              "& CV Templates",
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontFamily: "MontserratRegular",
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 26,
              ),
            ),
            Stack(
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Image.asset(
                    "assets/asifC.png",
                    width: MediaQuery.of(context).size.width, // Set your desired width
                    height: 507,

                  ),
                ),
                Positioned(
                  bottom: 28,
                  left: MediaQuery.of(context).size.width * 0.43,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32.0),
                    child: SkipContainer(),
                  ),
                ),
              ],
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
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
