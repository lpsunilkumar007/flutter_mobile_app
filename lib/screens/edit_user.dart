import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mobile_app/routes/app_route.gr.dart';
import 'package:mobile_app/values/app_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserPage> {
  File? _image; // Store the picked image
  final _picker = ImagePicker();

  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _age = TextEditingController();
  final _role = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var url = Uri.https(AppApi.baseUrl, AppApi.user);
  Future<void> fetchData() async {
    final storage = await SharedPreferences.getInstance();
    var accessToken = await storage.getString('access_token');
    bool authenticated = !JwtDecoder.isExpired(accessToken!);
    if (authenticated) {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );
      var parsedData = json.decode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          print(parsedData["data"]);
          _firstName.text = parsedData["data"]["firstName"];
          _lastName.text = parsedData["data"]["lastName"];
          _usernameCtrl.text = parsedData["data"]["username"];
          _emailCtrl.text = parsedData["data"]["email"];
          _role.text = parsedData["data"]["role"];
          var age = parsedData["data"]["age"];
          _age.text = age.toString();
        });
      } else if (response.statusCode == 403 || response.statusCode == 401) {
        context.router.push(LoginRoute(onResult: (bool) {}));
      }
    } else {
      context.router.push(LoginRoute(onResult: (bool) {}));
    }
  }

  Future<void> imageCropper(ImageSource source) async {
    XFile? images = await _picker.pickImage(source: source);
    if (images != null) {
      var cropper = (await ImageCropper()
          .cropImage(sourcePath: images.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio7x5
      ], uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            cropFrameColor: Theme.of(context).colorScheme.primary,
            cropGridColor: Colors.red,
            showCropGrid: false),
      ]));

      if (cropper != null) {
        setState(() {
          _image = File(cropper.path);
        });
      }
    }
  }

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
                          height: 90,
                        ),
                        const Text(
                          "Users Profile",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: MediaQuery.sizeOf(context).height * 0.1,
                      left: MediaQuery.sizeOf(context).width * 0.28,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 82.0, // Adjust the size as needed
                            backgroundImage: _image != null
                                ? Image.file(_image!).image
                                : const NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKfW83kzKnkiFOVLmKQ2sdlAiATvqWYfdRx2Q8UNlxUkyq9lyrO5KuyWhcxw&s"), // Placeholder image
                          ),
                        ],
                      )),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.25,
                    left: MediaQuery.sizeOf(context).width * 0.62,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color.fromRGBO(147, 30, 139, 1),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 100,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      IconButton(
                                        icon: const Icon(
                                          Icons.camera,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          imageCropper(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.image,
                                            color: Colors.black),
                                        onPressed: () {
                                          imageCropper(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.black),
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.35,
                    right: 20,
                    left: 20,
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _firstName,
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'First Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter First Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _lastName,
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Last Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Last Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _usernameCtrl,
                          // The validator receives the text that the user has entered.
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'User Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter User Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _age,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Age',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _role,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Role',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Role';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const DataTableExample()));
                                      }
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
                                          'Submit',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // InkWell(
                                  //   onTap: () async {
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               const UserProfile()),
                                  //     );
                                  //   },
                                  //   borderRadius: BorderRadius.circular(
                                  //       20), // Set the desired border radius
                                  //   child: Container(
                                  //     width: 120,
                                  //     height: 50,
                                  //     decoration: BoxDecoration(
                                  //       color: const Color.fromRGBO(
                                  //           147, 30, 139, 1),
                                  //       border: Border.all(
                                  //           color: const Color.fromRGBO(
                                  //               147, 30, 139, 1),
                                  //           width: 2), // Add a border
                                  //       borderRadius: BorderRadius.circular(
                                  //           20), // Same value as InkWell's borderRadius
                                  //     ),
                                  //     child: const Center(
                                  //       child: Text(
                                  //         'User Profile',
                                  //         style: TextStyle(color: Colors.white),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ]),
                          ],
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
