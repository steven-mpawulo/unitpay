import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/components/success_widget.dart';
import 'package:unitpay/controllers/auth_controller.dart';
import 'package:unitpay/controllers/database_controller.dart';
import 'package:unitpay/models/wallet.dart';
import 'package:unitpay/screens/login_screen.dart';

import '../models/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscuretext = true;
  String _show = "Show";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(232, 245, 234, 234),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Enter your details to get started",
                    style: GoogleFonts.merriweather(
                      wordSpacing: 8.0,
                      fontSize: 15.0,
                      color: const Color.fromARGB(255, 73, 72, 72),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Name",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _firstName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "First name is required";
                            }
                            return null;
                          },
                          style: GoogleFonts.merriweather(
                            decoration: TextDecoration.none,
                          ),
                          cursorColor: Colors.black,
                          cursorHeight: 25.0,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14.0),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  14.0,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Last Name",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _lastName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Last name is required";
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          cursorHeight: 25.0,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  14.0,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Email",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          cursorHeight: 25.0,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(14.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  14.0,
                                ),
                              ),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          "Password",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Stack(
                          children: [
                            TextFormField(
                              controller: _password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                              cursorColor: Colors.black,
                              cursorHeight: 25.0,
                              obscureText: _obscuretext,
                              textInputAction: TextInputAction.done,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(14.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      14.0,
                                    ),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscuretext = !_obscuretext;
                                  if (_obscuretext) {
                                    _show = "Show";
                                  } else {
                                    _show = "Hide";
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                  20.0,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(_show),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Colors.amberAccent,
                    ),
                    child: Consumer<DatabaseController>(
                        builder: (context, dataBaseController, child) {
                      return Consumer<AuthController>(
                          builder: (context, authController, child) {
                        return MaterialButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Loading(
                                    message: 'Creating account',
                                  ),
                                ),
                              );
                              await authController
                                  .signup(_email.text, _password.text)
                                  .then((value) async {
                                if (value != null) {
                                  User user = User(
                                      id: value.user.uid,
                                      firstName: _firstName.text,
                                      lastName: _lastName.text,
                                      email: _email.text,
                                      profilePicUrl: "");
                                  Map<String, dynamic> userData =
                                      user.toFireStore();
                                  Wallet wallet = Wallet(
                                      balance: 0.0,
                                      id: value.user.uid,
                                      firstName: _firstName.text,
                                      lastName: _lastName.text,
                                      email: _email.text);
                                  Map<String, dynamic> walletData =
                                      wallet.toFireStore();
                                  await dataBaseController
                                      .saveUserData(userData);
                                  await dataBaseController
                                      .saveWalletData(walletData);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Success(
                                        message: 'Account Created',
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(authController.error);
                                }
                              });
                            }
                          },
                          child: Text(
                            "Signup",
                            style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      });
                    }),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LogInScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Got an account? Login",
                        style: GoogleFonts.merriweather(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
