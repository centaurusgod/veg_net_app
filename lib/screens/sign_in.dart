// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously, avoid_print, empty_catches

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veg_net/screens/sign_up_page.dart';
import 'package:veg_net/services/api_handler.dart';
import 'package:veg_net/screens/home.dart';
import 'package:veg_net/services/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _user_name_controller = TextEditingController();
  final _user_password_controller = TextEditingController();
  //late SharedPreferences prefs;
  // int status = 101;
  SharedPreferences? prefs;
  Map<String, dynamic> user_login_data = {
    'user_name': 'random',
    'user_token': Null
  };

  @override
  void initState() {
    super.initState();
    // initialize_shared_preferences();
  }

  @override
  void dispose() {
    super.dispose();
    _user_password_controller.dispose();
    _user_name_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      controller: _user_name_controller,
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
                  // sign_up_handler(static_context_obj);
                  sign_in_handler();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 21, 88, 25)),
                ),
                child: const Text(
                  'LogIn',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 350,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  // sign_up_handler(static_context_obj);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 75, 0, 83)),
                ),
                child: const Text(
                  'Sign Up',
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

  // sign_in_handler() async {
  //   var status = await VegNetAPI.post_user_login({
  //     'user_name': _user_name_controller.text,
  //     'user_password': _user_password_controller.text
  //   });
  //   // status == 101
  //   //     ? Navigator.push(
  //   //         context, MaterialPageRoute(builder: (context) => UserHomePage()))
  //   //     : showDialog(
  //   //         context: context,
  //   //         builder: (BuildContext context) {
  //   //           return AlertDialog(
  //   //             title: Text("Message"),
  //   //             backgroundColor: Colors.white,
  //   //             content: Text(
  //   //                 "Incorrect Credentials \nCheck your username and password"),
  //   //             actions: [
  //   //               ElevatedButton(
  //   //                 onPressed: () {
  //   //                   Navigator.of(context).pop();
  //   //                 },
  //   //                 child: const Text("Ok"),
  //   //               )
  //   //             ],
  //   //             scrollable: true,
  //   //           );
  //   //         },
  //   //       );
  //   await prefs?.setString('token', status['token']);
  //   print(status['status']);
  //   print(status['token']);
  //   // initialize_shared_preferences();
  // }

  Future<void> sign_in_handler() async {
    // Assuming VegNetAPI.post_user_login returns a Map with 'status' and 'token'
    var status = await VegNetAPI.post_user_login({
      'user_name': _user_name_controller.text,
      'user_password': _user_password_controller.text,
    });

    try {
      bool is_store_sucess = await SharedPref.store_local_user_data({
        'user_name': _user_name_controller.text,
        'user_token': status['token']
      });
      if (is_store_sucess) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserHomePage()));
      }
    } catch (error) {}

    if (prefs != null) {
      await prefs!.setString('user_token', status['token']);
      await prefs!.setString('user_name', _user_name_controller.text);
    }
    print("aaaaaa");
    print(status['token']);
    print("bbbb");
    // print(status['token']);
  }

  // Future<void> initialize_shared_preferences() async {
  //   try {
  //     prefs = await SharedPreferences.getInstance();

  //     final String? user_token = prefs?.getString('user_token');
  //     final String? user_name = prefs?.getString('user_name');

  //     if (user_token != null) {
  //       //send token to verify if it matches with the database one
  //       user_login_data['user_name'] = user_name;
  //       user_login_data['user_token'] = user_token;
  //       var status_response =
  //           await VegNetAPI.verify_user_token(user_login_data);
  //       if (status_response == 102) {
  //         print("before delay");
  //         await Future.delayed(const Duration(milliseconds: 5000), () {
  //           print("after delay");
  //           setState(() {
  //             _is_initialized = true;
  //           });
  //         });

  //         Navigator.of(context).pop();
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => UserHomePage()));
  //       }
  //     }
  //   } catch (error) {
  //     print("Some ERRRROR HAS OCCCCURRRREEEEDDD");
  //   }
  // }
}
