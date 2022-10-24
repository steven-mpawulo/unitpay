import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitpay/screens/login_screen.dart';
import 'package:unitpay/screens/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80.0,
            ),
            Center(
              child: Image.asset(
                "assets/images/logo_transparent.png",
                height: 300.0,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
              ),
              child: Container(
                width: 300.0,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const SignUpScreen()),
                      ),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
              ),
              child: Container(
                width: 300.0,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const LogInScreen()),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
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
