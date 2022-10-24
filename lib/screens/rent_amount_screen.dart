import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/controllers/rent_payment_to_bank_account.dart';
import 'package:unitpay/screens/tenant_home_screen.dart';
import 'package:unitpay/secrets/secret.dart';

class RentAmountScreen extends StatefulWidget {
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String branchName;
  final String bankCode; // will be used as account name
  final String branchCode; // will be used as destination branch code
  const RentAmountScreen({
    Key? key,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.bankCode,
    required this.branchCode,
  }) : super(key: key);

  @override
  State<RentAmountScreen> createState() => _RentAmountScreenState();
}

class _RentAmountScreenState extends State<RentAmountScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();

  makePayment(String accountBank, String accountNumber, int amount,
      String destinationBranchCode, String beneficiaryName) async {
    var url = Uri.parse("https://api.flutterwave.com/v3/transfers");
    try {
      var response = await http.post(
        url,
        headers: {
          "Authorization": secretKey,
          "Content-type": "application/json"
        },
        body: jsonEncode({
          "account_bank": accountBank,
          "account_number": accountNumber,
          "amount": amount,
          "narration": "Test UGX bank transfers",
          "currency": "UGX",
          "destination_branch_code": destinationBranchCode,
          "beneficiary_name": beneficiaryName,
        }),
      );
      return response;
    } catch (e) {
      print(e);
    }
  }

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
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Rent details",
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    child: Text(
                      "Account name : ${widget.accountName}",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Account number : ${widget.accountNumber}",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Bank :  ${widget.bankName}",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Branch : ${widget.branchName}",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16.0),
                  Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Amount",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          controller: _amount,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please provide amount";
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
                        const SizedBox(height: 16.0),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            color: Colors.amberAccent,
                          ),
                          child: MaterialButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {}
                            },
                            child: Text(
                              "Pay",
                              style: GoogleFonts.merriweather(
                                fontWeight: FontWeight.bold,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TenantHomeScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Cancel",
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
