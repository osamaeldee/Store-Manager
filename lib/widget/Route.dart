import 'package:flutter/material.dart';
import 'package:store/pages/Foods.dart';
import 'package:store/pages/Freezers.dart';
import 'package:store/pages/cheeses.dart';
import 'package:store/pages/drinks.dart';
import 'package:store/pages/otherpro.dart';

void navigateToPage(BuildContext context, String label) {
  Widget page;
  switch (label) {
    case 'إضافة مشروبات':
      page = AddBeveragePage();
      break;
    case 'إضافة مجمدات':
      page = AddFrozenItemsPage();
      break;
    case 'إضافة مأكولات':
      page = AddProductPage();
      break;
    case 'إضافة جبن':
      page = AddCheesePage();
      break;
    case 'اضافه منتجات اخرا!!':
      page = AddProductsInCartonsPage();
      break;
    default:
      return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
