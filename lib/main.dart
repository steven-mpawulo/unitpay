import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/controllers/auth_controller.dart';
import 'package:unitpay/controllers/database_controller.dart';
import 'package:unitpay/controllers/flutterwave_deposit.dart';
import 'package:unitpay/controllers/rent_payment_to_bank_account.dart';
import 'package:unitpay/controllers/withdraw_to_mobile_money.dart';
import 'package:unitpay/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthController()),
    ChangeNotifierProvider(create: (_) => DatabaseController()),
    ChangeNotifierProvider(create: (_) => FlutterWaveDeposit()),
    ChangeNotifierProvider(create: (_) => RentPaymentToBankAccount()),
    ChangeNotifierProvider(create: (_) => WithDrawToMobileMoney()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
