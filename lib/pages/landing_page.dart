import 'package:flutter/material.dart';
import 'package:tinder_clone/pages/login_page.dart'; 

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
            SizedBox(height: 50), 
            Image.asset(
              'assets/images/icons/SoulSync_logo.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 20), 
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.purple,
                    Colors.pink,
                    Colors.deepPurple,
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'SoulSync',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'GreatVibes-Regular',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color.fromARGB(255, 164, 20, 147), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), 
                ),
                backgroundColor: Colors.purple, 
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Unlock Romance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
