class Wallet {
  double balance;
  String id;
  String firstName;
  String lastName;
  String email;

  Wallet({
    required this.balance,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toFireStore() {
    return {
      "balance": balance,
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "email": email
    };
  }

  Wallet fromFireStore(firestore) {
    return Wallet(
      balance: firestore["balance"],
      id: firestore["id"],
      firstName: firestore["firstName"],
      lastName: firestore["lastName"],
      email: firestore["email"],
    );
  }

  double deposit(double amount) {
    balance += amount;
    return balance;
  }

  double withdraw(double amount) {
    balance -= amount;
    return balance;
  }
}
