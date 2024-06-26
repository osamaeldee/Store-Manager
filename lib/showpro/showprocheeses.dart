import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CheeseListPage extends StatelessWidget {
  final DatabaseReference databaseReference;

  const CheeseListPage({Key? key, required this.databaseReference})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة منتجات الجبن'),
      ),
      body: StreamBuilder(
        stream: databaseReference.child('cheese').onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> cheeses = snapshot.data!.snapshot.value;
            List<dynamic> cheeseKeys = cheeses.keys.toList();
            List<dynamic> cheeseData = cheeses.values.toList();

            if (cheeseKeys.isEmpty) {
              return const Center(
                child: Text('🧀🧀 لا يوجد جبن هنا!'),
              );
            }
            return ListView.builder(
              itemCount: cheeseKeys.length,
              itemBuilder: (BuildContext context, int index) {
                final cheeseKey = cheeseKeys[index];
                final cheese = cheeseData[index];

                if (cheese != null) {
                  return Card(
                    child: ListTile(
                      title: Text(cheese['productName'] ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الفئة: ${cheese['category'] ?? ''}'),
                          Text('الكمية: ${cheese['quantity'] ?? ''}'),
                          Text('سعر الكيلو: ${cheese['pricePerKilo'] ?? ''}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('تأكيد الحذف'),
                                    content: const Text(
                                        'هل أنت متأكد أنك تريد حذف هذا المنتج؟'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          databaseReference
                                              .child('cheeses')
                                              .child(cheeseKey)
                                              .remove()
                                              .then((_) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'تم حذف المنتج بنجاح!'),
                                              ),
                                            );
                                          }).catchError((error) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'حدث خطأ أثناء حذف المنتج: $error'),
                                              ),
                                            );
                                          });
                                        },
                                        child: const Text('نعم'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('لا'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('حدث خطأ أثناء جلب البيانات'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
