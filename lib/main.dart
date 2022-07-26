import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testimpack/navigator.dart';
import 'package:testimpack/views/homepages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: NavigatorImpack(),
    );
  }
}
