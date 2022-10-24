class RentPaymentTransaction {
  double amount;
  String id;
  String paymentFrom;
  String paymentTo;
  DateTime dateTime;

  RentPaymentTransaction({
    required this.amount,
    required this.id,
    required this.paymentFrom,
    required this.paymentTo,
    required this.dateTime,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "amount": amount,
      "id": id,
      "paymentFrom": paymentFrom,
      "paymentTo": paymentTo,
      "dateTime": dateTime,
    };
  }

  RentPaymentTransaction fromFireStore(firestore) {
    return RentPaymentTransaction(
        amount: firestore["amount"],
        id: firestore["id"],
        paymentFrom: firestore["paymentFrom"],
        paymentTo: firestore["paymentTo"],
        dateTime: firestore["dateTime"]);
  }
}
