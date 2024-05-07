import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_app/edit_user_profile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/pexels-anniroenkae-2693208.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        const Text(
                          "Users",
                          style: TextStyle(fontSize: 16),
                        ),
                        const Text(
                          "Computer Science Student",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.sizeOf(context).height * 0.1,
                      left: MediaQuery.sizeOf(context).width * 0.28,
                      child: const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKfW83kzKnkiFOVLmKQ2sdlAiATvqWYfdRx2Q8UNlxUkyq9lyrO5KuyWhcxw&s"),
                      )),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.43,
                    right: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About Me",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            overflow: TextOverflow.clip,
                            "This project is a starting point for Flutter application.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Education",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: const Text(
                            overflow: TextOverflow.clip,
                            "A few resources to get you started if this is your first Flutter project.",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Social",
                              style: TextStyle(fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(
                                      Uri.parse("https://www.facebook.com/"),
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      throw Exception('Could not launch');
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/images/facebook.png",
                                    height: 50,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(
                                      Uri.parse("https://github.com/"),
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      throw Exception('Could not launch');
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/images/github.png",
                                    height: 50,
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    if (!await launchUrl(
                                      Uri.parse("https://www.google.com/"),
                                      mode: LaunchMode.externalApplication,
                                    )) {
                                      throw Exception('Could not launch');
                                    }
                                  },
                                  child: Image.asset(
                                    "assets/images/google.png",
                                    height: 50,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(height:1),
                            const SizedBox(
                              height: 10,
                            ),                            
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const EditUserProfile()),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(
                                        20), // Set the desired border radius
                                    child: Container(
                                      width: 120,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            147, 30, 139, 1),
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                147, 30, 139, 1),
                                            width: 2), // Add a border
                                        borderRadius: BorderRadius.circular(
                                            20), // Same value as InkWell's borderRadius
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Edit User',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
