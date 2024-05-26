import 'package:flutter/material.dart';
import 'package:green_tech/core/app_asset.dart';
import 'package:intl/intl.dart';

class AutomationScheduleScreen extends StatefulWidget {
  const AutomationScheduleScreen({super.key});

  @override
  State<AutomationScheduleScreen> createState() =>
      _AutomationScheduleScreenState();
}

enum DayFilter { senin, selasa, rabu, kamis, jumat, sabtu, minggu }

class _AutomationScheduleScreenState extends State<AutomationScheduleScreen> {
  bool _isLoadingSave = false;

  TimeOfDay _scheduleTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  String _scheduleTimeText =
      DateFormat('hh:mm').format(DateTime.now()).toString();

  Set<DayFilter> days = <DayFilter>{};

  bool _isEveryday = false;

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Penjadwalan Otomatis'),
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
                                      'Penjadwalan siram pupuk AB Mix Secara Otomatis',
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
                                      Icons.update,
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
                              'Buat Jadwal',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text('Waktu'),
                            const SizedBox(
                              height: 10,
                            ),
                            ActionChip(
                                onPressed: () {
                                  _onPressTime();
                                },
                                avatar: const Icon(Icons.schedule),
                                label: Text(_scheduleTimeText)),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Hari'),
                            const SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              spacing: 5,
                              children: DayFilter.values.map((DayFilter day) {
                                return FilterChip(
                                  label: Text(day.name),
                                  selected: days.contains(day),
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      setState(() {
                                        days.add(day);
                                      });
                                    } else {
                                      setState(() {
                                        days.remove(day);
                                      });
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                    value: _isEveryday,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isEveryday = value!;
                                      });
                                    }),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isEveryday = !_isEveryday;
                                    });
                                  },
                                  child: const Text('Ulangi Setiap Hari'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
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
                          onPressed: _isLoadingSave
                              ? null
                              : () {
                                  _onPressSave();
                                },
                          child: Text(_isLoadingSave
                              ? 'Menyimpan..'
                              : 'Simpan Jadwal')),
                    ),
                  ],
                )
              ],
            )));
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

    _showScaffold(content: "Jadwal berhasil tersimpan");
  }

  void _showScaffold({required String content}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  void _onPressTime() async {
    var time =
        await showTimePicker(context: context, initialTime: _scheduleTime);

    final now = DateTime.now();
    if (time != null) {
      setState(() {
        // _timeC.text = "${time.hour}:${time.minute}";
        _scheduleTime = TimeOfDay(hour: time.hour, minute: time.minute);
        _scheduleTimeText = DateFormat('hh:mm')
            .format(
                DateTime(now.year, now.month, now.day, time.hour, time.minute))
            .toString();
        // _scheduleTime = DateFormat('hh:mm').format(DateTime(year));
      });
    }
  }
}
