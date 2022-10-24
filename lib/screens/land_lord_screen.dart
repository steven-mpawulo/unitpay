import 'package:flutter/material.dart';

class LandLordScreen extends StatefulWidget {
  const LandLordScreen({Key? key}) : super(key: key);

  @override
  State<LandLordScreen> createState() => _LandLordScreenState();
}

class _LandLordScreenState extends State<LandLordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(242, 255, 255, 255),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "Steven Mpawulo",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 25.0,
                  ),
                ],
              ),
              Center(
                child: Container(
                  width: 350.0,
                  height: 220.0,
                  decoration: const BoxDecoration(),
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15.0,
                        ),
                        const Text(
                          "Wallet",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          "Balance",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text("0.0",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            )),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: const Text("Deposit"),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                child: const Text("Withdraw"),
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
                    const Text("My Property"),
                    Card(
                      child: ListTile(
                          onTap: () {},
                          title: const Text("Property Name : Jeera Heights"),
                          subtitle: const Text("Location : Jeera"),
                          trailing: IconButton(
                            onPressed: () {},
                            color: Colors.black,
                            icon: const Icon(
                              Icons.delete,
                            ),
                          )),
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
