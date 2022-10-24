import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unitpay/components/loading_widget.dart';
import 'package:unitpay/controllers/auth_controller.dart';
import 'package:unitpay/controllers/database_controller.dart';
import 'package:unitpay/screens/login_screen.dart';
import 'package:unitpay/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TenantProfileScreen extends StatefulWidget {
  const TenantProfileScreen({Key? key}) : super(key: key);

  @override
  State<TenantProfileScreen> createState() => _TenantProfileScreenState();
}

class _TenantProfileScreenState extends State<TenantProfileScreen> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  late File profileImage;
  bool imageAvailable = false;
  bool isProfilePicUrlEmpty = true;

  Future getImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageAvailable = true;
      });
      var profImage = File(image.path);
      setState(() {
        profileImage = profImage;
      });
      final storageRef = storage.ref();
      final profilePicRef = storageRef.child(user.id);
      try {
        await profilePicRef.putFile(profImage);
        await profilePicRef.getDownloadURL().then((value) async {
          Map<String, dynamic> data = {
            "profilePicUrl": value.toString(),
          };
          await Provider.of<DatabaseController>(context, listen: false)
              .updateUserData(user.id, data);
        });
      } on FirebaseException catch (e) {
        print(e.toString());
      }
    } else {
      return null;
    }
  }

  User user =
      User(id: "", firstName: "", lastName: "", email: "", profilePicUrl: "");
  bool isLoading = true;
  Future<String> fetchUserUid() async {
    String uid =
        await Provider.of<AuthController>(context, listen: false).getUserUid();
    return uid;
  }

  Future fetchUserData(String uid) async {
    dynamic userData =
        await Provider.of<DatabaseController>(context, listen: false)
            .getUserData(uid);
    return userData;
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
        message: 'Loading profile',
      );
    } else {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 239),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: isProfilePicUrlEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            color: Colors.black,
                                          ),
                                          Text(
                                            "Add photo",
                                            style: GoogleFonts.merriweather(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Image(
                                      image: NetworkImage(user.profilePicUrl),
                                      fit: BoxFit.fill,
                                      width: 120.0,
                                      height: 120.0,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                            "First Name : ${user.firstName}",
                            style: GoogleFonts.merriweather(),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text("Last Name : ${user.lastName}",
                              style: GoogleFonts.merriweather()),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                            "Email : ${user.email}",
                            style: GoogleFonts.merriweather(),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                            "Change Password",
                            style: GoogleFonts.merriweather(),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          onTap: () {},
                          title: Text(
                            "Verify Account",
                            style: GoogleFonts.merriweather(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 400.0,
                  decoration: const BoxDecoration(
                    color: Colors.amberAccent,
                  ),
                  child: Consumer<AuthController>(
                      builder: (context, authController, child) {
                    return MaterialButton(
                      onPressed: () async {
                        await authController.signout().then(
                              (value) => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LogInScreen(),
                                ),
                              ),
                            );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LogOut",
                            style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
