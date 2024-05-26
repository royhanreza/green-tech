import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeMenuItem extends StatelessWidget {
  const HomeMenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.screen,
  });

  final String title;
  final Icon icon;
  final dynamic screen;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      // color: Colors.teal[100],
      child: InkWell(
        onTap: () {
          if (screen != null) {
            Get.to(screen);
          } else {
            debugPrint('tapped');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
