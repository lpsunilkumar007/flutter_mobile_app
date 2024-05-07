import 'package:flutter/material.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
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
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'First Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: TextFormField(
                              initialValue:
                                  "This is your first Flutter project.",
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Education',
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            initialValue: "",
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Social',
                            )),
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
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Processing Data')),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Submit",
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {Navigator.pop(context);},
                                  child: const Text(
                                    "User Profile",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),                       

                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}