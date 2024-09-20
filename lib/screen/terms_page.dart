import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff201f30),
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: const Color(0xff8282a6),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Terms and Conditions",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "1. Introduction",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome to our app. By accessing or using this app, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms, you must not use our app.",
                style: TextStyle(fontSize: 16,color: Colors.white70),
              ),
              SizedBox(height: 20),
              Text(
                "2. Usage of the App",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white70),
              ),
              SizedBox(height: 10),
              Text(
                "You agree not to misuse the app or help anyone else to do so. Misuse includes: hacking, sending viruses, or engaging in any activity that disrupts our service.",
                style: TextStyle(fontSize: 16,color: Colors.white70),
              ),
              SizedBox(height: 20),
              Text(
                "3. Privacy",
                style: TextStyle(color: Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Your privacy is important to us. Please review our Privacy Policy to understand how we collect, use, and protect your personal information.",
                style: TextStyle(color: Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "4. Changes to the Terms",
                style: TextStyle(color: Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We may modify these terms at any time. If we make changes, we will notify you by revising the date at the top of these terms.",
                style: TextStyle(color: Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "5. Limitation of Liability",
                style: TextStyle(color: Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "We are not liable for any damages or losses arising from your use of our app. Use the app at your own risk.",
                style: TextStyle(color: Colors.white70,fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                "6. Governing Law",
                style: TextStyle(color: Colors.white70,fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "These terms are governed by the laws of [your country/state].",
                style: TextStyle(color: Colors.white70,fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
