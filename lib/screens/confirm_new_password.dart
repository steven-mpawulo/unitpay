import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/components/reset_success.dart';
import 'package:unitpay/controllers/auth_controller.dart';
import 'package:unitpay/screens/reset_password_screen.dart';

class ConfirmNewpassword extends StatefulWidget {
  const ConfirmNewpassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmNewpassword> createState() => _ConfirmNewpasswordState();
}

class _ConfirmNewpasswordState extends State<ConfirmNewpassword> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscuretext = true;
  String _show = "Show";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPasswordScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 32.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Reset Password",
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Enter your code and your new password.",
                    style: GoogleFonts.merriweather(
                      fontSize: 15.0,
                      wordSpacing: 4.0,
                      color: const Color.fromARGB(255, 73, 72, 72),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Code",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _code,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Code is required";
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
                          "New Password",
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
                  const SizedBox(
                    height: 20,
                  ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Loading(
                                message: 'Changing password',
                              ),
                            ),
                          );
                          if (_formkey.currentState!.validate()) {
                            await authController
                                .confirmnewpassword(_code.text, _password.text)
                                .then((value) {
                              if (value != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ResetSuccess(
                                        message: "Success password reset"),
                                  ),
                                );
                              } else {}
                            });
                          }
                        },
                        child: Text(
                          "Reset password",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }),
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
