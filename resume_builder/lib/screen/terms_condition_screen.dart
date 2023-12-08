import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TermsConditionScreen extends StatefulWidget {
  const TermsConditionScreen({super.key});

  @override
  State<TermsConditionScreen> createState() => _TermsConditionScreenState();
}

class _TermsConditionScreenState extends State<TermsConditionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.blue,
          // Color of the status bar
          statusBarIconBrightness: Brightness.dark,
          // Brightness of system icons (e.g., network, battery)
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
      ),
      body: const SingleChildScrollView(
        child:  Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "1.Introduction",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MontserratBold",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "Welcome to Lizmy. At Lizmy, we take your privacy and data security seriously. This Privacy Policy explains how we collect, use, disclose, and protect your personal information when you visit and use our website. By accessing or using Lizmy, you consent to the practices described in this policy.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "2. Information We Collect",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "2.1. Personal Information: When you use Lizmy, we may collect personal information such as your name, email address, phone number, and other information you voluntarily provide to us when using our services.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "2.2. Non-Personal Information: We may also collect non-personal information, including but not limited to your IP address, browser type, and device information.\n\n\n3. How We Use Your Information",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "3.1. To Provide Services: We may use your personal information to provide the services you request, including resume building, account creation, and customer support.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "3.2. To Improve Our Services: We may use non-personal information to analyze and improve our website's performance, features, and user experience.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "4. Disclosure of Your Information",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "We do not sell, trade, or otherwise transfer your personal information to outside parties. However, we may share your information with trusted third parties who assist us in operating our website, conducting our business, or servicing you, as long as those parties agree to keep this information confidential.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "5. Security",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "We take reasonable steps to protect your personal information from unauthorized access or disclosure. However, no method of data transmission or storage is entirely secure. Therefore, we cannot guarantee the absolute security of your information.\n\n6. Your Choices",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "You may choose not to provide certain personal information, but this may limit your ability to use some of our services.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "7. Cookies\n\nWe may use cookies and other tracking technologies to enhance your experience on our website. You can adjust your browser settings to disable cookies, but doing so may affect the functionality of our website.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "8. Changes to this Privacy Policy\n\nWe may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons. We will notify you of any significant changes by posting the new policy on our website.",
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
              Text(
                "Terms and Conditions of Use for Lizmy",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MontserratBold",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "1. Acceptance of Terms\n\nBy using Lizmy and its services, you agree to comply with and be bound by the following Terms and Conditions. Please read these terms carefully.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ), SizedBox(
                height: 26,
              ),
              Text(
                "2. User Eligibility\n\nYou must be at least 18 years of age to use Lizmy or have the legal consent of a parent or guardian. By using our services, you represent and warrant that you are eligible to use this website.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "3. User Account\n\n3.1. You may be required to create an account to access certain features of Lizmy. You are responsible for maintaining the confidentiality of your account information.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "3.2. You are responsible for all activities that occur under your account. If you suspect any unauthorized use of your account, you must notify us immediately.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "4. Privacy Policy\n\nYour use of Lizmy is also governed by our Privacy Policy. By using our services, you consent to our collection, use, and sharing of information as described in the Privacy Policy.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "5. Use of Lizmy\n\n5.1. Lizmy is provided for personal and non-commercial use. You agree not to use our services for any unauthorized or illegal purposes.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "5.2. You agree not to engage in any activity that may disrupt the proper functioning of Lizmy.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "6. Intellectual Property\n\n6.1. All content on Lizmy, including text, graphics, logos, and software, is the property of Lizmy or its licensors and is protected by copyright and other intellectual property laws.\n\n6.2. You are granted a limited, non-exclusive, and non-transferable license to use our website for personal, non-commercial purposes.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "7. Limitation of Liability\n\n7.1. Lizmy is provided as is. We make no representations or warranties about the accuracy, reliability, or availability of our services.\n\n7.2. Lizmy and its team shall not be liable for any direct, indirect, incidental, consequential, or punitive damages resulting from your use or inability to use our services.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "8. Modification of Terms\n\nWe reserve the right to modify these Terms and Conditions at any time. Any changes will be effective immediately upon posting. We encourage you to check the terms regularly.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "9. Termination\n\nWe may, at our discretion, terminate or suspend your access to Lizmy for any reason, including violating these Terms and Conditions.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                  fontFamily: "MontserratRegular",
                ),
              ),SizedBox(
                height: 26,
              ),
              Text(
                "10. Contact Us\n\nIf you have any questions or concerns about these Terms and Conditions, please contact us at contact@lizmy.com",
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
            ],
          ),
        ),
      ),
    );
  }
}
