// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:veg_net/services/api_handler.dart';
import 'package:veg_net/screens/sign_in.dart';
// import 'dart:typed_data';

// import 'package:cryptology/cryptology.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController user_name_controller = TextEditingController();
  TextEditingController user_first_name_controller = TextEditingController();
  TextEditingController user_email_controller = TextEditingController();
  final _user_password_controller = TextEditingController();

  Map<String, dynamic> user_signup_data = {
    'user_name': '',
    'user_first_name': '',
    'user_email': '',
    'user_password': ''
  };

  @override
  void initState() {
    super.initState();
    //  EncryptionTest.test_encryption();
  }

  @override
  Widget build(BuildContext context) {
    var static_context_obj = context;
    // double screen_height = MediaQuery.of(context).size.height;
    // double screen_width = MediaQuery.of(context).size.width;

    // const double logo_height = screen_height / 4.1;

    // print(screenHeight);
    // print(screenWidth);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
                child: SizedBox(
              height: 50,
            )),
            Center(
              child: SizedBox(
                  height: 170,
                  child: Image.asset(
                    './assets/images/startup_logo.png',
                    height: 50,
                  )),
            ),

            Center(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    TextField(
                      //style: TextStyle(fontSize: 10),
                      controller: user_name_controller,
                      decoration: InputDecoration(
                          hintText: 'User Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: user_first_name_controller,
                      decoration: InputDecoration(
                          hintText: 'First Name',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: user_email_controller,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _user_password_controller,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  sign_up_handler(static_context_obj);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 21, 88, 25)),
                ),
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            // const Center(
            //   child: Text('Get Fresh Vegetables At Your DoorStepss'),
            // ),

            //
          ],
        ),
      ),
    );
  }

  void sign_up_handler(BuildContext context) async {
    assign_text_field_data_to_map();
    // Call API
    var status = await VegNetAPI.post_user_signup_data(user_signup_data);
    bool is_status_100 = status == 100;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          backgroundColor: Colors.white,
          content: Text(is_status_100
              ? "Sign Up Successful\nPlease Sign In From Next Page"
              : "Some error has occurred\nPlease try using a different email or username"),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pop();

                is_status_100
                    ? Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()))
                    : Navigator.of(context).pop();
              },
              child: const Text("Ok"),
            )
          ],
          scrollable: true,
        );
      },
    );
  }

  void alert_dialog_notifier(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          backgroundColor: Colors.white,
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Ok"),
            )
          ],
          scrollable: true,
        );
      },
    );
  }

  void assign_text_field_data_to_map() async {
    user_signup_data['user_name'] = user_name_controller.text;
    user_signup_data['user_first_name'] = user_first_name_controller.text;
    user_signup_data['user_email'] = user_email_controller.text;
    //user_signup_data['user_password'] = await _encrypted_password();
    user_signup_data['user_password'] = _user_password_controller.text;
  }

  // Future<String> _encrypted_password() async {
  //   final DataEncryption dataEncryption = DataEncryption.initial(
  //       secretKey: 'veg_net@#QWkljhsda', mode: AESMode.cbc, iv: '12k!*VzX,s]');
  //   final Uint8List dataAsBytes = _user_password_controller.text.toBytes();
  //   final encryptedData = await dataEncryption.encrypt(dataAsBytes);
  //   String encrypted_password = String.fromCharCodes(encryptedData);
  //   return encrypted_password.toString();
  // }
}
