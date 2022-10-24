import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/screens/choose_branch_screen.dart';
import 'package:unitpay/secrets/secret.dart';

class ChooseDestinationBankScreen extends StatefulWidget {
  final String accountName;
  final String accountNumber;
  const ChooseDestinationBankScreen(
      {Key? key, required this.accountName, required this.accountNumber})
      : super(key: key);

  @override
  State<ChooseDestinationBankScreen> createState() => _RentPaymentScreenState();
}

class _RentPaymentScreenState extends State<ChooseDestinationBankScreen> {
  List _banks = [];
  int _bankCount = 0;
  bool _isLoading = true;
  fetchBanks() async {
    var url = Uri.parse("https://api.flutterwave.com/v3/banks/UG");
    try {
      var response = await http.get(url, headers: {"Authorization": secretKey});
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  getListOfBanks() async {
    var bankData = await fetchBanks();
    var banks = jsonDecode(bankData.body);
    //print(banks);
    //print("only bank information");
    //print(banks["data"]);
    //var data = banks["data"];

    return banks;
  }

  @override
  Future<void> didChangeDependencies() async {
    var bankData = await fetchBanks();
    var banks = jsonDecode(bankData.body);
    List bankList = banks["data"];
    int start = 5;
    int end = (bankList.length.toInt() - 1);
    List availableBanks = bankList.sublist(start, end);
    setState(() {
      _banks = availableBanks;
    });
    setState(() {
      _bankCount = availableBanks.length.toInt();
    });
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Loading(
        message: 'Loading available banks',
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 239),
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            "Choose bank",
            style: GoogleFonts.merriweather(
              color: Colors.black,
            ),
          ),
          titleTextStyle: GoogleFonts.merriweather(
            fontSize: 20.0,
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(
                20.0,
              ),
              child: ListView.builder(
                itemCount: _bankCount,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseBranchScreen(
                              bankID: _banks[index]["id"],
                              accountName: widget.accountName,
                              accountNumber: widget.accountNumber,
                              bankName: _banks[index]["name"],
                              bankCode: _banks[index]["code"],
                            ),
                          ),
                        );
                      },
                      title: Text(
                        _banks[index]["name"],
                        style: GoogleFonts.merriweather(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
  }
}
