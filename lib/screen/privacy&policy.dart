import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xff201f30),
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: const Color(0xff8282a6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Privacy Policy",
                style: TextStyle(color:Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "1. Introduction",
                style: TextStyle(color:Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We are committed to protecting your personal information and your right to privacy. This policy explains what information we collect and how we use it.",
                style: TextStyle(color:Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "2. Information We Collect",
                style: TextStyle(color:Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We may collect personal information like your name, email address, and any other information you provide to us while using our app.",
                style: TextStyle(color:Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "3. How We Use Your Information",
                style: TextStyle(color:Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We use the information we collect to provide, maintain, and improve our services. We may also use your information to communicate with you and respond to your inquiries.",
                style: TextStyle(color:Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "4. Sharing Your Information",
                style: TextStyle(color:Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We do not share your personal information with third parties except as necessary to provide our services, comply with the law, or protect our rights.",
                style: TextStyle(color:Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "5. Data Security",
                style: TextStyle(color:Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure. However, no security system is perfect.",
                style: TextStyle(color:Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "6. Changes to This Policy",
                style: TextStyle(color:Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We may update this Privacy Policy from time to time. Any changes will be posted on this page.",
                style: TextStyle(color:Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "7. Contact Us",
                style: TextStyle(color:Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "If you have any questions about this Privacy Policy, please contact us at [your email/contact info].",
                style: TextStyle(color:Colors.white70,fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
