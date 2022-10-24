import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitpay/screens/tenant_profile_screen.dart';
import 'package:unitpay/screens/tenant_screen.dart';
import 'package:unitpay/screens/tenant_transaction_screen.dart';

class TenantHomeScreen extends StatefulWidget {
  const TenantHomeScreen({Key? key}) : super(key: key);

  @override
  State<TenantHomeScreen> createState() => _TenantHomeScreenState();
}

class _TenantHomeScreenState extends State<TenantHomeScreen> {
  int _currentindex = 0;
  final List _screens = [
    const TenantScreen(),
    const TenantTransactionScreen(),
    const TenantProfileScreen(),
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
