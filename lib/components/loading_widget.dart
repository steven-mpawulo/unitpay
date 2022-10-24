import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
  final String message;
  const Loading({Key? key, required this.message}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitChasingDots(
              color: Colors.black,
            ),
            const SizedBox(height: 16.0),
            Text(widget.message,
                style: GoogleFonts.merriweather(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                )),
          ],
        ),
      ),
    );
  }
}
