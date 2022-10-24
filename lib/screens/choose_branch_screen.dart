import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/screens/rent_amount_screen.dart';
import 'package:unitpay/secrets/secret.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChooseBranchScreen extends StatefulWidget {
  final String accountName;
  final String accountNumber;
  final String bankName;
  final int bankID;
  final String bankCode;
  const ChooseBranchScreen({
    Key? key,
    required this.bankID,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
  }) : super(key: key);

  @override
  State<ChooseBranchScreen> createState() => _ChooseBranchScreenState();
}

class _ChooseBranchScreenState extends State<ChooseBranchScreen> {
  List _branches = [];
  int _branchesCount = 0;
  bool _isLoading = true;

  fetchBankBranches() async {
    int id = widget.bankID;
    var url = Uri.parse("https://api.flutterwave.com/v3/banks/$id/branches");
    try {
      var response = await http.get(url, headers: {"Authorization": secretKey});
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<void> didChangeDependencies() async {
    var branchData = await fetchBankBranches();
    var branches = jsonDecode(branchData.body);
    List branchesList = branches["data"];
    int branchCount = branchesList.length.toInt();
    setState(() {
      _branches = branchesList;
    });
    setState(() {
      _branchesCount = branchCount;
    });
    setState(() {
      _isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Loading(message: "Loading available branches");
    } else {
      return Scaffold(
          backgroundColor: const Color.fromARGB(255, 243, 240, 239),
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              "Choose branch",
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
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RentAmountScreen(
                                accountName: widget.accountName,
                                accountNumber: widget.accountNumber,
                                bankName: widget.bankName,
                                branchName: _branches[index]["branch_name"],
                                bankCode: widget.bankCode,
                                branchCode: _branches[index]["branch_code"],
                              ),
                            ),
                          );
                        },
                        title: Text(
                          _branches[index]["branch_name"],
                          style: GoogleFonts.merriweather(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _branchesCount,
                ),
              ),
            ),
          ));
    }
  }
}
