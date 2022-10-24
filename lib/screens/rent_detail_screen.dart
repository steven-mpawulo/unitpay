import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitpay/screens/choose_destination_bank.dart';

class RentDetailScreen extends StatefulWidget {
  const RentDetailScreen({Key? key}) : super(key: key);

  @override
  State<RentDetailScreen> createState() => _RentAmountScreenState();
}

class _RentAmountScreenState extends State<RentDetailScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _accountName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                    "Enter rent details",
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Pay rent anywhere at anytime.",
                    style: GoogleFonts.merriweather(
                      fontSize: 15.0,
                      wordSpacing: 4.0,
                    ),
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
                          "Enter Account Name",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _accountName,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please provide amount name";
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
                        Text(
                          "Enter Account Number",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _accountNumber,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please provide a account number";
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
                    child: MaterialButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChooseDestinationBankScreen(
                                accountName: _accountName.text,
                                accountNumber: _accountNumber.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
