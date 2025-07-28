import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        
        child: Padding(padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          children: [
            Image.asset('assets/images/illustration.png',width: 240),
      
          ],
        ),
        ),
      ),
    );
  }
}
