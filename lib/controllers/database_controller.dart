import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Save User data
  Future saveUserData(Map<String, dynamic> user) async {
    try {
      var response =
          await _firestore.collection("User").doc(user["id"]).set(user);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  // save wallet data
  Future saveWalletData(Map<String, dynamic> wallet) async {
    try {
      var response =
          await _firestore.collection("Wallet").doc(wallet["id"]).set(wallet);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  // save deposit data
  Future saveDepositData(Map<String, dynamic> deposit) async {
    try {
      DocumentReference response =
          await _firestore.collection("Transaction").add(deposit);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  // save withdraw data
  Future saveWithDrawData(Map<String, dynamic> withdraw) async {
    try {
      DocumentReference response =
          await _firestore.collection("Transaction").add(withdraw);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  // save rentpayment transaction data
  Future saveRentPayment(Map<String, dynamic> rentpayment) async {
    try {
      DocumentReference response =
          await _firestore.collection("Rentpayment").add(rentpayment);
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  // Retrieve User data
  Future getUserData(String id) async {
    try {
      DocumentSnapshot userDocument =
          await _firestore.collection("User").doc(id).get();
      return userDocument;
    } catch (e) {
      print(e.toString());
    }
  }

  // Retrieve wallet data
  Future getWalletData(String id) async {
    try {
      DocumentSnapshot walletDocument =
          await _firestore.collection("Wallet").doc(id).get();
      return walletDocument;
    } catch (e) {
      print(e.toString());
    }
  }

  // Retrieve deposit data
  Future getDepositData() async {}
  // Retrieve  withdraw data
  Future getWithDrawData() async {}
  // Retrieve rentpayment transaction data
  Future getRentPaymentData() async {}

  Future getTransactions(String id) async {
    try {
      var response = await _firestore
          .collection("Transaction")
          .where("depositedBy", isEqualTo: id)
          .get();
      return response;
    } catch (e) {
      print(e.toString());
    }
  }

  // update User data
  Future updateUserData(String id, Map<String, dynamic> updateData) async {
    try {
      var response = await _firestore
          .collection("User")
          .doc(id)
          .set(updateData, SetOptions(merge: true));
    } catch (e) {}
  }

  // update wallet amount
  Future updateWalletAmount(String id, Map<String, dynamic> updateData) async {
    try {
      var response = await _firestore
          .collection("Wallet")
          .doc(id)
          .set(updateData, SetOptions(merge: true));
      return response;
    } catch (e) {}
  }
}
