import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/controllers/auth_controller.dart';
import 'package:unitpay/controllers/database_controller.dart';
import 'package:unitpay/controllers/flutterwave_deposit.dart';
import 'package:unitpay/models/wallet.dart';
import 'package:unitpay/screens/deposit_screen.dart';
import 'package:unitpay/screens/rent_detail_screen.dart';
import 'package:unitpay/screens/withdraw_screen.dart';
import 'package:unitpay/models/user.dart';

class TenantScreen extends StatefulWidget {
  const TenantScreen({Key? key}) : super(key: key);

  @override
  State<TenantScreen> createState() => _TenantScreenState();
}

class _TenantScreenState extends State<TenantScreen> {
  bool isProfilePicUrlEmpty = true;
  User user =
      User(id: "", firstName: "", lastName: "", email: "", profilePicUrl: "");

  Future fetchUserData(String uid) async {
    dynamic userData =
        await Provider.of<DatabaseController>(context, listen: false)
            .getUserData(uid);
    return userData;
  }

  Wallet wallet =
      Wallet(balance: 0.0, id: "", firstName: "", lastName: "", email: "");
  bool isLoading = true;

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

  @override
  void didChangeDependencies() {
    Future<String> uid = fetchUserUid();
    uid.then((value) async {
      var userData = fetchUserData(value);
      userData.then((value) {
        setState(() {
          user = user.fromFireStore(value);
          if (user.profilePicUrl.isNotEmpty) {
            setState(() {
              isProfilePicUrlEmpty = false;
            });
          }
        });
      });
      var walletData = fetchWalletData(value);
      walletData.then((value) {
        setState(() {
          wallet = wallet.fromFireStore(value);
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
        message: 'Loading',
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 239),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  height: 100.0,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: ListTile(
                        title: Text(
                          "Hey ${wallet.firstName} ${wallet.lastName} ",
                          style: GoogleFonts.merriweather(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 40.0,
                            child: ClipOval(
                              child: isProfilePicUrlEmpty
                                  ? const Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Image(
                                      image: NetworkImage(user.profilePicUrl),
                                      height: 60.0,
                                      width: 60.0,
                                      fit: BoxFit.fill,
                                    ),
                            )),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Container(
                      width: 350.0,
                      height: 220.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "UGX",
                            style: GoogleFonts.merriweather(
                              //fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Text(wallet.balance.toString(),
                              style: GoogleFonts.merriweather(
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              )),
                          const SizedBox(height: 80.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 150.0,
                                decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Consumer<FlutterWaveDeposit>(builder:
                                    (context, flutterWaveDeposit, child) {
                                  return MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DepositScreen(
                                            firstname: wallet.firstName,
                                            lastname: wallet.lastName,
                                            email: wallet.email,
                                            id: wallet.id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Deposit",
                                      style: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              Container(
                                width: 150.0,
                                decoration: BoxDecoration(
                                  color: Colors.amberAccent,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            const WithdrawScreen()),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Withdraw",
                                    style: GoogleFonts.merriweather(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Services",
                        style: GoogleFonts.merriweather(
                          fontSize: 18.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RentDetailScreen(),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.amberAccent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.house,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Pay Rent",
                                      style: GoogleFonts.merriweather(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Card(
                              color: Colors.amberAccent,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              child: SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.tv,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Pay Tv",
                                      style: GoogleFonts.merriweather(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
