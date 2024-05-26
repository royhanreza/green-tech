import 'package:flutter/material.dart';
import 'package:green_tech/core/app_asset.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // const SizedBox(
                            //   width: 10,
                            // ),
                            Expanded(
                                child: Text(
                              'Atur IP Address / URL untuk API',
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
                    const Text('IP Address / URL'),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(filled: true),
                      initialValue: _ipAddress,
                      onChanged: (value) {
                        setState(() {
                          _ipAddress = value;
                        });
                      },
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
                  child: Text(_isLoadingSave ? 'Menyimpan..' : 'Simpan')),
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
    _showScaffold(content: "Pengaturan berhasil tersimpan");
  }

  void _showScaffold({required String content}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
