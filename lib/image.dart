import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfile extends StatefulWidget {
  const ImageProfile({super.key});

  @override
  State<ImageProfile> createState() => _ImageProfileState();
}

class _ImageProfileState extends State<ImageProfile> {
  File? _image; // Store the picked image
  final _picker = ImagePicker();

  Future<void> _cameraImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        
                        builder: (BuildContext context) => AlertDialog(
                              actions: <Widget>[
                                
                                IconButton(
                                  icon: const Icon(
                                    Icons.camera,
                                    color: Colors.black,
                                  ),
                                  onPressed: _cameraImagePicker,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.browse_gallery,
                                      color: Colors.black),
                                  onPressed: _openImagePicker,
                                ),
                              ],
                            ));
                  },
                  child: const Text('Select An Image'),
                ),
              ),
              const SizedBox(height: 35),
              // Display the picked image
              if (_image != null) Image.file(_image!),
            ],
          ),
        ),
      ),
    );
  }
}
