class DepositTransaction {
  double amount;
  String id;
  String firstName;
  String lastName;
  String type = "Deposit";
  String email;
  String dateTime;
  String reference;
  String depositedBy;

  DepositTransaction({
    required this.amount,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateTime,
    required this.email,
    required this.reference,
    required this.depositedBy,
    type,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "amount": amount,
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "type": type,
      "dateTime": dateTime,
      "email": email,
      "reference": reference,
      "depositedBy": depositedBy
    };
  }

  DepositTransaction fromFireStore(firestore) {
    return DepositTransaction(
      amount: firestore["amount"],
      id: firestore["id"],
      firstName: firestore["firstname"],
      lastName: firestore["lastname"],
      type: firestore["type"],
      dateTime: firestore["dateTime"],
      email: firestore["email"],
      reference: firestore["reference"],
      depositedBy: firestore["depositedBy"],
    );
  }
}
