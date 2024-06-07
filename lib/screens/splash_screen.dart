// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:veg_net/screens/home.dart';
import 'package:veg_net/screens/sign_in.dart';
import 'package:veg_net/services/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _is_initialized = false;

  @override
  void initState() {
    super.initState();
    check_logged_in_status();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _is_initialized
            ? Container(
                color: Colors.black,
              )
            : Center(
                child: Column(
                  children: [
                    SizedBox(height: 250),
                    SizedBox(
                        height: 170,
                        child: Image.asset(
                          './assets/images/startup_logo.png',
                          height: 50,
                        )),
                    SizedBox(
                      height: 35,
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        strokeWidth: 5.0,
                        // value: 55,
                      ),
                    ),
                  ],
                ),
              ));
  }

  void check_logged_in_status() async {
    _is_initialized = await SharedPref.initialize_shared_preferences();

    if (_is_initialized) {
      await Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserHomePage()));
      });
    } else {
      await Future.delayed(const Duration(milliseconds: 800), () {
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      });
    }
  }
}
