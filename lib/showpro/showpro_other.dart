import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductsInCartonsListPage extends StatelessWidget {
  final DatabaseReference databaseReference;

  const ProductsInCartonsListPage({Key? key, required this.databaseReference})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('قائمة المنتجات المتنوعة في الكرتونات'),
        ),
        body: StreamBuilder(
          stream: databaseReference.child('products_in_cartons').onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              Map<dynamic, dynamic> items = snapshot.data!.snapshot.value;
              List<dynamic> itemsList = items.keys.toList();
              List<dynamic> itemsData = items.values.toList();

              if (itemsList.isEmpty) {
                return const Center(
                  child: Text('📦📦 لا يوجد منتجات متنوعة في الكرتونات هنا!'),
                );
              }
              return ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (BuildContext context, int index) {
                  // Ensure item data is not null
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
                            Text(
                                'الكمية في الكرتونة: ${item['quantityPerCarton'] ?? ''}'),
                            Text(
                                'سعر الكرتونة: ${item['pricePerCarton'] ?? ''}'),
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
                                          'هل أنت متأكد أنك تريد حذف هذا المنتج المتنوع في الكرتونة؟'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Deleting the item
                                            databaseReference
                                                .child('products_in_cartons')
                                                .child(itemKey)
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
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('تأكيد الحذف'),
                      content: const Text(
                          'هل أنت متأكد أنك تريد حذف جميع المنتجات؟'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Deleting all products
                            databaseReference
                                .child('products_in_cartons')
                                .remove()
                                .then((_) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text('تم حذف جميع المنتجات بنجاح!'),
                                ),
                              );
                            }).catchError((error) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'حدث خطأ أثناء حذف جميع المنتجات: $error'),
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
        ));
  }
}
