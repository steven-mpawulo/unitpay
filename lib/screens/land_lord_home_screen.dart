import 'package:flutter/material.dart';
import 'package:unitpay/screens/land_lord_profile_screen.dart';
import 'package:unitpay/screens/land_lord_screen.dart';
import 'package:unitpay/screens/land_lord_transaction_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LandLordHomeScreen extends StatefulWidget {
  const LandLordHomeScreen({Key? key}) : super(key: key);

  @override
  State<LandLordHomeScreen> createState() => _LandLordHomeScreenState();
}

class _LandLordHomeScreenState extends State<LandLordHomeScreen> {
  int _currentindex = 0;
  final List _screens = [
    const LandLordScreen(),
    const LandLordTransactionScreen(),
    const LandLordProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: GoogleFonts.merriweather(
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
        unselectedLabelStyle: GoogleFonts.merriweather(),
        selectedItemColor: Colors.black,
        currentIndex: _currentindex,
        onTap: (index) {
          setState(() {
            _currentindex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox(height: 40.0, child: Icon(Icons.home)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(height: 40.0, child: Icon(Icons.send_rounded)),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: SizedBox(height: 40.0, child: Icon(Icons.person)),
            label: "Profile",
          )
        ],
      ),
    );
  }
}
