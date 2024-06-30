import 'package:flutter/material.dart';
import 'package:green_tech/core/app_asset.dart';
import 'package:green_tech/core/app_route.dart';
import 'package:green_tech/src/view/widget/home/menu_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: [
        Container(
            height: 100,
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
            ))),
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 15,
              // ),
              // Card(
              //   child: Padding(
              //     padding: const EdgeInsets.all(24),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Expanded(
              //                 child: Text(
              //               'Status Refill',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodyMedium
              //                   ?.copyWith(fontWeight: FontWeight.bold),
              //             )),
              //             Text(
              //               '32%',
              //               style: Theme.of(context)
              //                   .textTheme
              //                   .bodyMedium
              //                   ?.copyWith(fontWeight: FontWeight.bold),
              //             )
              //           ],
              //         ),
              //         const SizedBox(
              //           height: 5,
              //         ),
              //         Text(
              //           '32 / 100 Lt',
              //           style: Theme.of(context).textTheme.bodySmall,
              //         ),
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         LinearProgressIndicator(
              //           value: 0.32,
              //           semanticsLabel: 'Status Penampungan Air',
              //           borderRadius: BorderRadius.circular(2),
              //           color: Colors.blue,
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
                // padding: const EdgeInsets.only(left: 5, top: 24, bottom: 24),
                padding: const EdgeInsets.only(left: 5, top: 100, bottom: 24),
                child: Text(
                  'Menu',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: GridView.count(
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: const <Widget>[
                  HomeMenuItem(
                    title: 'Semprotan Otomatis',
                    icon: Icon(
                      Icons.shower,
                      size: 48,
                    ),
                    screen: AppRoute.automaticSpray,
                  ),
                  HomeMenuItem(
                    title: 'Status Refill',
                    icon: Icon(
                      Icons.water,
                      size: 48,
                    ),
                    screen: AppRoute.refillStatus,
                  ),
                  HomeMenuItem(
                    title: 'Penjadwalan Otomatis',
                    icon: Icon(
                      Icons.update,
                      size: 48,
                    ),
                    screen: AppRoute.automationSchedule,
                  ),
                ],
              ))
            ],
          ),
        ),
      ],
    )));
  }
}
