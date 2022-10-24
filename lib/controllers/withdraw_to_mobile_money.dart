import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithDrawToMobileMoney extends ChangeNotifier {
  Future withDrawToMobileMoney(
    String secretKey,
    String accountBank, // code representing mobile money operator
    String accountNumber, // this is the mobile number
    int amount,
    String currency, // currency code
    String beneficiaryName,
  ) async {
    var url = Uri.parse("https://api.flutterwave.com/v3/transfers");
    try {
      var response = await http.post(url, headers: {
        "Authorization": secretKey
      }, body: {
        "accountBank": accountBank,
        "accountNumber": accountNumber,
        "amount": amount,
        "currency": currency,
        "beneficiaryName": beneficiaryName,
      });
      return response;
    } catch (e) {
      print(e.toString());
    }
  }
}
