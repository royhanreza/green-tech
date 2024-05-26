import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_tech/core/app_asset.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RefillStatusScreen extends StatefulWidget {
  const RefillStatusScreen({super.key});

  @override
  State<RefillStatusScreen> createState() => _RefillStatusScreenState();
}

class _RefillStatusScreenState extends State<RefillStatusScreen> {
  double _refillPercent = 0;
  final double _refillCapacity = 500;

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Status Refill'),
            ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // const SizedBox(
                                    //   width: 10,
                                    // ),
                                    Expanded(
                                        child: Text(
                                      'Status refill ditampilkan di halaman ini',
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
                                      Icons.water,
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
                              'Status',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CircularPercentIndicator(
                                radius: 120.0,
                                lineWidth: 15.0,
                                animation: true,
                                percent: _refillPercent,
                                center: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${(_refillPercent * 100).round().toString()} %",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      "${(_refillPercent * _refillCapacity).round().toString()} Liter",
                                      style: const TextStyle(fontSize: 14.0),
                                    )
                                  ],
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: _statusColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                      // const Spacer(),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50)),
                          onPressed: () {
                            _onPressRefresh();
                          },
                          child: const Text('Muat Ulang')),
                    ),
                  ],
                )
              ],
            )));
  }

  void _onPressRefresh() {
    debugPrint('Memuat Ulang..');
    Random rng = Random();
    double randomNumber = rng.nextInt(100) / 100;
    setState(() {
      _refillPercent = randomNumber;
    });

    debugPrint(randomNumber.toString());
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(const SnackBar(content: Text('Memuat Ulang..')));
  }

  Color _statusColor() {
    if (_refillPercent >= 0 && _refillPercent <= 0.10) {
      return Colors.red;
    } else if (_refillPercent >= 0.11 && _refillPercent <= 0.60) {
      return Colors.amber;
    } else if (_refillPercent >= 0.61 && _refillPercent <= 1) {
      return Colors.blue;
    }

    return Colors.blue;
  }
}
