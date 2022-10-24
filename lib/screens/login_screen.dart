import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/controllers/auth_controller.dart';
import 'package:unitpay/screens/reset_password_screen.dart';
import 'package:unitpay/screens/signup_screen.dart';
import 'package:unitpay/screens/tenant_home_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formkey = GlobalKey<FormState>();
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
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Enter your login details to continue.",
                    style: GoogleFonts.merriweather(
                      fontSize: 15.0,
                      wordSpacing: 4.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Not a UnitPay member?",
                    style: GoogleFonts.merriweather(
                      fontSize: 15.0,
                      wordSpacing: 4.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  GestureDetector(
                    child: Text(
                      "Sign up",
                      style: GoogleFonts.merriweather(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              obscureText: _obscuretext,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              },
                              style: GoogleFonts.merriweather(
                                decoration: TextDecoration.none,
                              ),
                              cursorColor: Colors.black,
                              cursorHeight: 25.0,
                              textInputAction: TextInputAction.done,
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
                    child: Consumer<AuthController>(
                        builder: (context, authController, child) {
                      return MaterialButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Loading(
                                  message: 'Signing in',
                                ),
                              ),
                            );
                            await authController
                                .signin(_email.text, _password.text)
                                .then((value) {
                              if (value != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TenantHomeScreen(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LogInScreen(),
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(authController.error);
                              }
                            });
                          }
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
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
                            builder: (context) => const ResetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot password?",
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
