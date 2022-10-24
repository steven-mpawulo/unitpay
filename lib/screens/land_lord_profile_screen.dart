import 'package:flutter/material.dart';

class LandLordProfileScreen extends StatefulWidget {
  const LandLordProfileScreen({Key? key}) : super(key: key);

  @override
  State<LandLordProfileScreen> createState() => _LandLordProfileScreenState();
}

class _LandLordProfileScreenState extends State<LandLordProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
                const Center(
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Set New Photo",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Card(
                  child: ListTile(
                    onTap: () {},
                    title: const Text("First Name : "),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {},
                    title: const Text("Last Name : "),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {},
                    title: const Text("Email : "),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {},
                    title: const Text("Change Password"),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {},
                    title: const Text("Verify Account"),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 400.0,
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: MaterialButton(
                    onPressed: () {},
                    child: const Text("Log Out"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
