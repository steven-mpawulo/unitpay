import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unitpay/secrets/secret.dart';

class RentPaymentToBankAccount extends ChangeNotifier {
  Future rentPayment(
    int accountName,
    String accountNumber,
    int amount,
    String narration,
    // String beneficiaryName,
    // String destinationBranchCode,
  ) async {
    var url = Uri.parse("https://api.flutterwave.com/v3/transfers");
    try {
      var response = await http.post(url, headers: {
        "Authorization": secretKey
      }, body: {
        "account_bank": accountName,
        "account_number": accountNumber,
        "amount": amount,
        "narration": narration,
        //"currency": "NGN".hashCode,
        // "beneficiaryName": beneficiaryName,
        // "destinationBranchCode": destinationBranchCode,
      });
      return response;
    } catch (e) {
      print(e.toString());
    }
  }
}
