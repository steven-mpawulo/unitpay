class WithdrawTransaction {
  double amount;
  String id;
  String firstname;
  String lastname;
  String withdrawTo;
  DateTime dateTime;

  WithdrawTransaction({
    required this.amount,
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.withdrawTo,
    required this.dateTime,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "amount": amount,
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "withdrawTo": withdrawTo,
      "dateTime": dateTime,
    };
  }

  WithdrawTransaction fromFireStore(firestore) {
    return WithdrawTransaction(
      amount: firestore["amount"],
      id: firestore["id"],
      firstname: firestore["firstname"],
      lastname: firestore["lastname"],
      withdrawTo: firestore["withdrawTo"],
      dateTime: firestore["dateTime"],
    );
  }
}
