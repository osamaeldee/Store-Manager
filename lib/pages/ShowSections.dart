import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:store/Appimage.dart';
import 'package:store/showpro/showpro_other.dart';
import 'package:store/widget/BottomNavigationBar1.dart';
import 'package:store/widget/listname.dart';
import 'package:store/widget/showRoute.dart';

class Showsection extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    late List<String> itemNames = show;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'صفحه عرض الاقسام ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index < 4) {
                    return _buildGridTile(
                      context,
                      [
                        AppImageAssets.chees2,
                        AppImageAssets.other2,
                        AppImageAssets.drink2,
                        AppImageAssets.food2,
                      ][index],
                      itemNames[index],
                    );
                  }
                  return null;
                },
                childCount: 4,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildLargeTile(
                      context, AppImageAssets.other, ' عرض المنتجات الاخرا!!'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyCustomWidgetContent1(),
    );
  }

  Widget _buildGridTile(BuildContext context, String imagePath, String label) {
    return GestureDetector(
      onTap: () => navigateToPage1(context, label),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeTile(BuildContext context, String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsInCartonsListPage(
                    databaseReference: databaseReference,
                  )),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.width / 2,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
