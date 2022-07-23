import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:testimpack/views/add_pages.dart';
import 'package:testimpack/views/finished.dart';
import 'package:testimpack/views/homepages.dart';
import 'package:testimpack/views/homepages_future.dart';
import 'package:testimpack/views/profile.dart';

class NavigatorImpack extends StatefulWidget {
  const NavigatorImpack({Key? key}) : super(key: key);

  @override
  State<NavigatorImpack> createState() => _NavigatorImpackState();
}

class _NavigatorImpackState extends State<NavigatorImpack> {
  int index = 0;

  var pagesUser = [
    const FutureHomepages(),
    AddPages(),
    const ProfilePages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 500),
        height: 50,
        animationCurve: Curves.easeInOutExpo,
        backgroundColor: Colors.transparent,
        index: index,
        items: const [
          Icon(
            Icons.home_filled,
          ),
          Icon(
            Icons.book,
          ),
          Icon(
            Icons.person,
          ),
        ],
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: pagesUser[index],
      ),
    );
  }
}
