import 'package:flutter/material.dart';
import 'package:store/Appimage.dart'; // Assuming AppImageAssets contains the image paths.
import 'package:store/pages/ShowSections.dart';
import 'package:store/pages/homepage.dart';
import 'package:store/widget/listname.dart';
import 'package:typewritertext/typewritertext.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("مرحباً بك"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 10,
      ),
      backgroundColor: Colors.teal.shade50,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageCard(
                    AppImageAssets.MAKHAZIN, "عرض المنتجاات في المخزن"),
                _buildImageCard(
                    AppImageAssets.ma5zan, "اضافه منتجات في المخزن"),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TypeWriterText(
                text: Text(
                  name,
                  style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                duration: const Duration(milliseconds: 60),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Homepage())));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 12.0,
                ),
                textStyle: const TextStyle(fontSize: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: const Text("معرفة المزيد"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (label == "اضافه منتجات في المخزن") {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Homepage())));
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => Showsection())));
            }
          },
          child: Container(
            height: MediaQuery.of(context).size.width * 0.45,
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
      ],
    );
  }
}
