import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:store/pages/ShowSections.dart';
import 'package:store/pages/homepage.dart';

class MyCustomWidgetContent1 extends StatefulWidget {
  @override
  _MyCustomWidgetContent1State createState() => _MyCustomWidgetContent1State();
}

class _MyCustomWidgetContent1State extends State<MyCustomWidgetContent1> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: _currentIndex,
      backgroundColor: Colors.grey[200]!,
      items: const <Widget>[
        Icon(Icons.shopping_cart, size: 30),
        Icon(Icons.home, size: 30),
      ],
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 1:
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: Homepage(),
                type: PageTransitionType.bottomToTop,
                duration: const Duration(milliseconds: 500),
              ),
            );
            break;
          case 0:
            Navigator.pushReplacement(
              context,
              PageTransition(
                child: Showsection(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: const Duration(milliseconds: 500),
              ),
            );
            break;
          default:
            break;
        }
      },
    );
  }
}
