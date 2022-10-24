import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:unitpay/screens/tenant_home_screen.dart';

class Failed extends StatelessWidget {
  final String message;
  const Failed({Key? key, required this.message}) : super(key: key);

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
                  Icons.error,
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
                color: Colors.amber,
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const TenantHomeScreen()),
                    ),
                  );
                },
                child: Text(
                  "Proceed to home",
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
