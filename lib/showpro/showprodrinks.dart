import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BeverageListPage extends StatelessWidget {
  final DatabaseReference databaseReference;

  const BeverageListPage({Key? key, required this.databaseReference})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المشروبات'),
      ),
      body: StreamBuilder(
        stream: databaseReference.child('beverages').onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> beverages = snapshot.data!.snapshot.value;
            List<dynamic> beverageKeys = beverages.keys.toList();
            List<dynamic> beverageData = beverages.values.toList();

            if (beverageKeys.isEmpty) {
              return const Center(
                child: Text('🧐🧐 لا يوجد مشروبات هنا!'),
              );
            }
            return ListView.builder(
              itemCount: beverageKeys.length,
              itemBuilder: (BuildContext context, int index) {
                final beverageKey = beverageKeys[index];
                final beverage = beverageData[index];

                if (beverage != null) {
                  return Card(
                    child: ListTile(
                      title: Text(beverage['productName'] ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الفئة: ${beverage['category'] ?? ''}'),
                          Text(
                              'سعر الكرتونة: ${beverage['pricePerCarton'] ?? ''}'),
                          Text('الكمية: ${beverage['quantity'] ?? ''}'),
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
                                        'هل أنت متأكد أنك تريد حذف هذا المشروب؟'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          databaseReference
                                              .child('beverages')
                                              .child(beverageKey)
                                              .remove()
                                              .then((_) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'تم حذف المشروب بنجاح!'),
                                              ),
                                            );
                                          }).catchError((error) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'حدث خطأ أثناء حذف المشروب: $error'),
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
