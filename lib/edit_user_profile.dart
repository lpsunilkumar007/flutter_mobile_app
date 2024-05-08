import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/datatable_profile.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  File? _image; // Store the picked image
  final _picker = ImagePicker();

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
                        const SizedBox(
                          height: 30,
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
                                         Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DataTableExample()));  
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
