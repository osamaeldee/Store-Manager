import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:store/showpro/showprofoot.dart';
import 'package:store/showpro/showpro_other.dart';
import 'package:store/showpro/showprocheeses.dart';
import 'package:store/showpro/showprodrinks.dart';
import 'package:store/showpro/showprofreez.dart';

void navigateToPage1(BuildContext context, String label) {
  final _databaseReference = FirebaseDatabase.instance.ref();

  Widget page;
  switch (label) {
    case "عرض المشروبات":
      page = BeverageListPage(
        databaseReference: _databaseReference,
      );
      break;
    case "عرض المجمدات":
      page = FrozenItemsListPage(
        databaseReference: _databaseReference,
      );
      break;
    case "عرض مأكولات":
      page = ProductListPage(
        databaseReference: _databaseReference,
      );
      break;
    case "عرض الجبن":
      page = CheeseListPage(
        databaseReference: _databaseReference,
      );
      break;
    case 'اضافه منتجات اخرا!!':
      page = ProductsInCartonsListPage(
        databaseReference: _databaseReference,
      );
      break;
    default:
      return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
