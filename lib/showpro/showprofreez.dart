import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FrozenItemsListPage extends StatelessWidget {
  final DatabaseReference databaseReference;

  const FrozenItemsListPage({Key? key, required this.databaseReference})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المنتجات المجمدة'),
      ),
      body: StreamBuilder(
        stream: databaseReference.child('frozen_items').onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> items = snapshot.data!.snapshot.value;
            List<dynamic> itemsList = items.keys.toList();
            List<dynamic> itemsData = items.values.toList();

            if (itemsList.isEmpty) {
              return const Center(
                child: Text('🧊🧊 لا يوجد منتجات مجمدة هنا!'),
              );
            }
            return ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (BuildContext context, int index) {
                final itemKey = itemsList[index];
                final item = itemsData[index];

                if (item != null) {
                  return Card(
                    child: ListTile(
                      title: Text(item['productName'] ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الفئة: ${item['category'] ?? ''}'),
                          Text('سعر الكرتونة: ${item['pricePerCarton'] ?? ''}'),
                          Text('الكمية: ${item['quantity'] ?? ''}'),
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
                                        'هل أنت متأكد أنك تريد حذف هذا المنتج المجمد؟'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Deleting the frozen item
                                          databaseReference
                                              .child('frozen_items')
                                              .child(itemKey)
                                              .remove()
                                              .then((_) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'تم حذف المنتج المجمد بنجاح!'),
                                              ),
                                            );
                                          }).catchError((error) {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'حدث خطأ أثناء حذف المنتج المجمد: $error'),
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
