import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/controllers/database_controller.dart';

import '../controllers/auth_controller.dart';
import 'package:unitpay/models/wallet.dart';

class TenantTransactionScreen extends StatefulWidget {
  const TenantTransactionScreen({Key? key}) : super(key: key);

  @override
  State<TenantTransactionScreen> createState() =>
      _TenantTransactionScreenState();
}

class _TenantTransactionScreenState extends State<TenantTransactionScreen> {
  List _transactions = [];
  int _transactionCount = 0;
  bool isLoading = true;
  Wallet wallet =
      Wallet(balance: 0.0, id: "", firstName: "", lastName: "", email: "");
  Future<String> fetchUserUid() async {
    String uid =
        await Provider.of<AuthController>(context, listen: false).getUserUid();
    return uid;
  }

  Future fetchWalletData(String uid) async {
    dynamic walletData =
        await Provider.of<DatabaseController>(context, listen: false)
            .getWalletData(uid);
    return walletData;
  }

  Future fetchTransactionData(String uid) async {
    dynamic transactionData =
        await await Provider.of<DatabaseController>(context, listen: false)
            .getTransactions(uid);
    return transactionData;
  }

  @override
  void didChangeDependencies() {
    Future<String> uid = fetchUserUid();
    uid.then((value) async {
      var transactionData = fetchTransactionData(value);
      transactionData.then((value) {
        List transactions = value.docs;
        setState(() {
          _transactions = transactions;
        });
        setState(() {
          _transactionCount = transactions.length.toInt();
        });
        setState(() {
          isLoading = false;
        });
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Loading(
        message: 'Loading transactions',
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 239),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: _transactionCount,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    isThreeLine: true,
                    minVerticalPadding: 20.0,
                    title: Text(
                      "${_transactions[index].data()["type"]}:\nDate : ${_transactions[index].data()["dateTime"]}",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Amount : ${_transactions[index].data()["amount"].toString()}",
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Text(
                      "id : ${_transactions[index].data()["id"]}",
                      style: GoogleFonts.merriweather(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }
}
