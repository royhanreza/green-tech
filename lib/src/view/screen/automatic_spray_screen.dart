import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_tech/core/app_asset.dart';

class AutomaticSprayScreen extends StatefulWidget {
  const AutomaticSprayScreen({super.key});

  @override
  State<AutomaticSprayScreen> createState() => _AutomaticSprayScreenState();
}

class _AutomaticSprayScreenState extends State<AutomaticSprayScreen> {
  bool _isInitDataLoading = true;
  StreamSubscription<DatabaseEvent>? _subscription;

  bool _isValveOneLoading = false;
  bool _isValveTwoLoading = false;

  bool _isValveOneActive = true;
  bool _isValveTwoActive = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getControlValue();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Semprotan Otomatis'),
            ),
            body: SingleChildScrollView(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // const SizedBox(
                                //   width: 10,
                                // ),
                                Expanded(
                                    child: Text(
                                  'Semprot tanaman secara otomatis dengan sekali klik',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: brightness == Brightness.light
                                          ? Colors.white
                                          : null),
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.shower,
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
                    child: _isInitDataLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kontrol',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Card(
                                clipBehavior: Clip.hardEdge,
                                // color: Colors.teal[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.opacity),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Selenoid Valve 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Aktifkan selenoid valve 1",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Switch(
                                            value: _isValveOneActive,
                                            onChanged: _isValveOneLoading
                                                ? null
                                                : (bool value) {
                                                    _onChangeValveOne(value);
                                                  },
                                          ),
                                        ],
                                      )),
                                      Visibility(
                                          visible: _isValveOneLoading,
                                          child:
                                              const CircularProgressIndicator()),
                                    ],
                                  ),
                                ),
                                // child: InkWell(
                                //   onTap: _isValveOneLoading
                                //       ? null
                                //       : () {
                                //           debugPrint('valve 1 tapped');
                                //           _onTapValveOne();
                                //         },
                                //   child: ,
                                // ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                clipBehavior: Clip.hardEdge,
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.opacity),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Selenoid Valve 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Aktifkan selenoid valve 2",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Switch(
                                              value: _isValveTwoActive,
                                              onChanged: _isValveTwoLoading
                                                  ? null
                                                  : (bool value) {
                                                      _onChangeValveTwo(value);
                                                    }),
                                        ],
                                      )),
                                      Visibility(
                                          visible: _isValveTwoLoading,
                                          child:
                                              const CircularProgressIndicator()),
                                    ],
                                  ),
                                ),
                                // color: Colors.teal[100],
                                // child: InkWell(
                                //   onTap: _isValveTwoLoading
                                //       ? null
                                //       : () {
                                //           debugPrint('valve 2 tapped');
                                //           _onTapValveTwo();
                                //         },
                                //   child: ,
                                // ),
                              )
                            ],
                          ),
                  )
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 24, right: 24, top: 10, bottom: 24),
                  //   child: Column(children: [
                  //     Card(
                  //       // elevation: 0,
                  //       shadowColor: Colors.transparent,
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(20),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.shower),
                  //             const SizedBox(
                  //               width: 10,
                  //             ),
                  //             Expanded(
                  //                 child: Text(
                  //                     'Semprot tanaman secara otomatis dengan sekali klik'))
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ]),
                  // ),
                ],
              ),
            )));
  }

  void _getControlValue() async {
    DatabaseReference controlRef = FirebaseDatabase.instance.ref('control');
    _subscription = controlRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      bool relay1 = data['relay1'] == 1 ? true : false;
      bool relay2 = data['relay2'] == 1 ? true : false;
      setState(() {
        _isValveOneActive = relay1;
        _isValveTwoActive = relay2;
        _isInitDataLoading = false;
      });
    });
  }

  void _onChangeValveOne(bool active) async {
    print('toggle valve 1');
    setState(() {
      _isValveOneLoading = true;
    });

    DatabaseReference ref = FirebaseDatabase.instance.ref("control");
    await ref.update({
      "relay1": active ? 1 : 0,
    });

    await Future.delayed(const Duration(seconds: 10));

    setState(() {
      _isValveOneLoading = false;
    });

    if (active) {
      _showValveSnackBar(contentText: 'Selenoid valve 1 berhasil diaktifkan');
    } else {
      _showValveSnackBar(
          contentText: 'Selenoid valve 1 berhasil dinonaktifkan');
    }
  }

  void _onChangeValveTwo(bool active) async {
    print('toggle valve 1');
    setState(() {
      _isValveTwoLoading = true;
    });

    DatabaseReference ref = FirebaseDatabase.instance.ref("control");
    await ref.update({
      "relay2": active ? 1 : 0,
    });

    await Future.delayed(const Duration(seconds: 10));

    setState(() {
      _isValveTwoLoading = false;
    });

    if (active) {
      _showValveSnackBar(contentText: 'Selenoid valve 2 berhasil diaktifkan');
    } else {
      _showValveSnackBar(
          contentText: 'Selenoid valve 2 berhasil dinonaktifkan');
    }
  }

  void _onTapValveTwo() async {
    setState(() {
      _isValveTwoLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isValveTwoLoading = false;
    });
    _showValveSnackBar(contentText: 'Selenoid valve 2 berhasil diaktifkan');
  }

  void _showValveSnackBar({required String contentText}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(contentText)));
  }
}
