import 'package:flutter/material.dart';
import 'package:store/pages/ShowSections.dart';
import 'package:store/pages/homepage.dart';

void navigateToPage3(BuildContext context, String label) {
  Widget page;
  switch (label) {
    case "صفحه عرض المنتجات":
      page = Showsection();
      break;
    case "صفحه اضافه المنتجات":
      page = Homepage();
      break;
    default:
      return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
