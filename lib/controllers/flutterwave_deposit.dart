import 'package:flutter/material.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:unitpay/secrets/secret.dart';

class FlutterWaveDeposit extends ChangeNotifier {
  Future makeDeposit(
    BuildContext context,
    String firstname,
    String lastname,
    String amount,
    String email,
    String phoneNumber,
  ) async {
    try {
      Flutterwave flutterwave = Flutterwave.forUIPayment(
          context: context,
          encryptionKey: encryptionKey,
          publicKey: publicKey,
          currency: "UGX",
          amount: amount,
          email: email,
          fullName: firstname + lastname,
          txRef: "trial deposit",
          isDebugMode: true,
          phoneNumber: phoneNumber,
          acceptCardPayment: true,
          acceptUSSDPayment: false,
          acceptAccountPayment: false,
          acceptFrancophoneMobileMoney: false,
          acceptGhanaPayment: false,
          acceptMpesaPayment: false,
          acceptRwandaMoneyPayment: true,
          acceptUgandaPayment: true,
          acceptZambiaPayment: false);

      final response = await flutterwave.initializeForUiPayments();
      return response;
    } catch (e) {
      print(e.toString());
    }
  }
}
