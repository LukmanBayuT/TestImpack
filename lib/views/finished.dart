import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testimpack/navigator.dart';
import 'package:testimpack/views/homepages.dart';

class Finished extends StatelessWidget {
  const Finished({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              size: 300,
              color: Colors.amber,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: Get.width / 1.2,
              height: Get.height / 8,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Get.offAll(() => const NavigatorImpack());
                  },
                  child: const Text('Kembali Ke Menu Utama')),
            )
          ],
        ),
      ),
    );
  }
}
