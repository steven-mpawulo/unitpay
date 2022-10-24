import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutterwave/utils/flutterwave_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/components/success_widget.dart';
import 'package:unitpay/controllers/auth_controller.dart';
import 'package:unitpay/controllers/database_controller.dart';
import 'package:unitpay/controllers/flutterwave_deposit.dart';
import 'package:intl/intl.dart';
import 'package:unitpay/models/deposit_transaction.dart';

class DepositScreen extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String email;
  final String id;
  const DepositScreen({
    Key? key,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.id,
  }) : super(key: key);

  @override
  State<DepositScreen> createState() => _DepositScreen();
}

class _DepositScreen extends State<DepositScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _amount = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  fetchDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

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
                    "Deposit",
                    style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Deposit from anywhere at anytime.",
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
                          "Enter Phone Number",
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _phoneNumber,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please provide a phone number";
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
                            hintText: "256700000000",
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
                              return "Please provide a value";
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
                    child: Consumer<AuthController>(
                        builder: (context, authController, child) {
                      return Consumer<DatabaseController>(
                          builder: (context, dataBaseController, child) {
                        return Consumer<FlutterWaveDeposit>(
                            builder: (context, flutterWaveDeposit, child) {
                          return MaterialButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await flutterWaveDeposit
                                    .makeDeposit(
                                  context,
                                  widget.firstname,
                                  widget.lastname,
                                  _amount.text,
                                  widget.email,
                                  _phoneNumber.text,
                                )
                                    .then((value) async {
                                  if (value != null) {
                                    // var message = value.message;
                                    var successful = value.data.status;
                                    if (successful ==
                                        FlutterwaveConstants.SUCCESSFUL) {
                                      AlertDialog alert = const AlertDialog(
                                        actions: [
                                          Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ))
                                        ],
                                      );
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          });
                                      var date = fetchDate();
                                      DepositTransaction depositTransaction =
                                          DepositTransaction(
                                        amount: double.parse(value.data.amount),
                                        id: value.data.id,
                                        firstName: widget.firstname,
                                        lastName: widget.lastname,
                                        dateTime: date,
                                        email: widget.email,
                                        reference: value.data.txRef,
                                        depositedBy: widget.id,
                                      );
                                      Map<String, dynamic> depositData =
                                          depositTransaction.toFireStore();
                                      await dataBaseController
                                          .saveDepositData(depositData);
                                      String uid =
                                          await authController.getUserUid();
                                      var walletData = await dataBaseController
                                          .getWalletData(uid);
                                      var walletValues = walletData.data();
                                      double initialBalance =
                                          walletValues["balance"];
                                      double availableBalance = initialBalance +
                                          double.parse(value.data.amount);
                                      Map<String, dynamic> updateData = {
                                        "balance": availableBalance
                                      };
                                      await dataBaseController
                                          .updateWalletAmount(uid, updateData);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Success(
                                              message: "Deposit Successful"),
                                        ),
                                      );
                                    } else {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const Failed(
                                      //         message: "Deposit Failed"),
                                      //   ),
                                      // );
                                      // SnackBar snackBar = const SnackBar(
                                      //   content: SizedBox(
                                      //     height: 70.0,
                                      //     child: Center(
                                      //       child: Text(
                                      //         "Trasaction failed \n Please try again.",
                                      //         style: TextStyle(
                                      //           color: Colors.white,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   backgroundColor: Colors.pinkAccent,
                                      //   duration: Duration(
                                      //     seconds: 10,
                                      //   ),
                                      //   behavior: SnackBarBehavior.floating,
                                      //   width: 300.0,
                                      // );
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(snackBar);
                                    }
                                  } else {
                                    SnackBar snackBar = const SnackBar(
                                      content: SizedBox(
                                        height: 70.0,
                                        child: Center(
                                          child: Text(
                                            "Trasaction Cancelled.",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Colors.pinkAccent,
                                      duration: Duration(
                                        seconds: 8,
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      width: 300.0,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                });
                              }
                            },
                            child: Text(
                              "Deposit",
                              style: GoogleFonts.merriweather(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        });
                      });
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
