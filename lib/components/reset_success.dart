import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:unitpay/screens/login_screen.dart';

class ResetSuccess extends StatelessWidget {
  final String message;
  const ResetSuccess({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 30.0,
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                  size: 40.0,
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              message,
              style: GoogleFonts.merriweather(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Container(
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
                  "Proceed to login",
                  style: GoogleFonts.merriweather(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
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
