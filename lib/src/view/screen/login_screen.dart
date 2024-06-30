import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_tech/core/app_asset.dart';
import 'package:green_tech/core/app_color.dart';
import 'package:green_tech/core/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      print('success login');
      _saveUserLoggedInStatus(true);
      Get.off(AppRoute.root);
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (error) {
      print('ERROR: $error');
    }
  }

  Future<void> _saveUserLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  String _accessCode = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppAsset.logoGreenTech,
                            width: 120,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              'Automatic fertilizing watering',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          // const SizedBox(
                          //   width: double.infinity,
                          //   child: Text(
                          //     'Masukkan kode untuk mengakses aplikasi',
                          //     style: TextStyle(
                          //         color: Colors.black54,
                          //         fontWeight: FontWeight.w600,
                          //         fontSize: 12),
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // TextFormField(
                          //   style: const TextStyle(color: Colors.black87),
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.green.shade50,
                          //     border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //         borderSide: BorderSide.none),
                          //     contentPadding: const EdgeInsets.only(
                          //         left: 10, top: 10, right: 10, bottom: 10),
                          //   ),
                          //   initialValue: _accessCode,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _accessCode = value;
                          //     });
                          //   },
                          // ),
                          // const SizedBox(
                          //   height: 24,
                          // ),
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         backgroundColor: Colors.green,
                          //         minimumSize: const Size(double.infinity, 50)),
                          //     onPressed: () {
                          //       _onPressLogin();
                          //     },
                          //     child: const Text(
                          //       'Masuk',
                          //       style: TextStyle(color: Colors.white),
                          //     )),
                          SignInButton(
                            Buttons.google,
                            onPressed: () => _handleSignIn(context),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  void _onPressLogin() async {
    debugPrint('Logging in..');
    if (_accessCode.isEmpty) {
      _showScaffold(content: "Masukkan kode");
      return;
    }

    Get.to(AppRoute.root);
  }

  void _showScaffold({required String content}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
