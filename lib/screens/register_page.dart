import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/routes/app_route.gr.dart';
import 'package:mobile_app/values/app_api.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _UserProfileState();
}

class _UserProfileState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailCtrl = TextEditingController(text: "testing@gmail.com");
  final _passwordCtrl = TextEditingController(text: "P@ssw0rd");
  final _age = TextEditingController(text: "21");
  final _firstName = TextEditingController(text: "Testing");
  final _lastName = TextEditingController(text: "Testing");

  var url = Uri.https(AppApi.baseUrl, AppApi.register);
  _register() async {
    final storage = await SharedPreferences.getInstance();
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        'username': _emailCtrl.text,
        'password': _passwordCtrl.text,
        'email': _emailCtrl.text,
        'age': int.parse(_age.text),
        'firstName': _firstName.text,
        'lastName': _lastName.text
      }),
    );
    var parsedData = json.decode(response.body);
    if (response.statusCode == 200) {
      if (parsedData["status"] == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(parsedData["error"]["message"])));
      }
      // ignore: use_build_context_synchronously
      String? token = parsedData["data"]["token"];
      storage.setString('access_token', token!);
      context.router.push(const EditUserRoute());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(parsedData["error"]["errors"][0]["message"])));
    }
  }

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
                          height: 10,
                        ),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.25,
                    right: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _firstName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your First Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _lastName,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Last Name',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Last Name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _age,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Age',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Age';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          controller: _passwordCtrl,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromRGBO(
                                              147, 30, 139, 1)),
                                      child: const Text(
                                        "Back",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        _register();
                                        // Navigator.pop(context);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color.fromRGBO(
                                              147, 30, 139, 1)),
                                      child: const Text(
                                        "Register",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ])
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
