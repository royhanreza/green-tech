import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:green_tech/core/app_asset.dart';
import 'package:green_tech/core/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoadingSave = false;

  String _ipAddress = "";

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    // color: AppColor.primary,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     AppColor.primary,
                    //     Colors.red.shade400,
                    //   ],
                    // ),
                    image: DecorationImage(
                  image: const AssetImage(AppAsset.illustrationPlant),
                  fit: BoxFit.cover,
                  opacity: brightness == Brightness.light ? 0.8 : 0.6,
                )),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black54,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 24, top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Expanded(
                            //     child: Text(
                            //   'Atur IP Address / URL untuk API',
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: brightness == Brightness.light
                            //           ? Colors.white
                            //           : null),
                            // )),
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Icon(
                              Icons.settings,
                              size: 48,
                              color: brightness == Brightness.light
                                  ? Colors.white
                                  : null,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengaturan',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton.icon(
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade400,
                            minimumSize: const Size(double.infinity, 50)),
                        onPressed: () {
                          _showLogoutDialog();
                        },
                        label: const Text(
                          'Log Out',
                          style: TextStyle(color: Colors.white),
                        )),
                    // const Text('IP Address / URL'),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // TextFormField(
                    //   decoration: const InputDecoration(filled: true),
                    //   initialValue: _ipAddress,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _ipAddress = value;
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Column(
        //   children: [
        //     const Spacer(),
        //     Padding(
        //       padding: const EdgeInsets.all(24),
        //       child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //               minimumSize: const Size(double.infinity, 50)),
        //           onPressed: _isLoadingSave
        //               ? null
        //               : () {
        //                   _onPressSave();
        //                 },
        //           child: Text(_isLoadingSave ? 'Menyimpan..' : 'Simpan')),
        //     ),
        //   ],
        // )
      ],
    )));
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar dari aplikasi?'),
          content: const Text('Anda akan keluar dari aplikasi'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Keluar'),
              onPressed: () => _handleSignOut(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    await _googleSignIn.signOut();
    _saveUserLoggedInStatus(false);
    Get.off(AppRoute.login);
  }

  Future<void> _saveUserLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
  }

  void _onPressSave() async {
    debugPrint('Menyimpan..');
    setState(() {
      _isLoadingSave = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoadingSave = false;
    });
    _showScaffold(content: "Pengaturan berhasil tersimpan");
  }

  void _showScaffold({required String content}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
