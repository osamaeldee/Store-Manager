import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductListPage extends StatelessWidget {
  final DatabaseReference databaseReference;

  const ProductListPage({Key? key, required this.databaseReference})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة المنتجات'),
      ),
      body: StreamBuilder(
        stream: databaseReference.child('foots').onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> products = snapshot.data!.snapshot.value;
            List<dynamic> productsList = products.keys.toList();
            List<dynamic> productsData = products.values.toList();

            if (productsList.isEmpty) {
              return const Center(
                child: Text('🧐🧐لا يوجد منتجات هنا!'),
              );
            }
            return ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (BuildContext context, int index) {
                // Ensure product data is not null
                final productKey = productsList[index];
                final product = productsData[index];

                if (product != null) {
                  return Card(
                    child: ListTile(
                      title: Text(product['productName'] ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('الفئة: ${product['category'] ?? ''}'),
                          Text(
                              'سعر الكرتونة: ${product['pricePerCarton'] ?? ''}'),
                          Text('سعر الوحدة: ${product['pricePerUnit'] ?? ''}'),
                          Text('الكمية: ${product['quantity'] ?? ''}'),
                          Text(
                              'المنتجات في الكرتونة: ${product['productsPerCarton'] ?? ''}'),
                          Text(
                              'السعر الإجمالي: ${product['totalPrice'] ?? ''}'),
                          // Adding the added date
                          Text('تاريخ الإضافة: ${product['addedDate'] ?? ''}'),
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
                                          // Deleting the product
                                          databaseReference
                                              .child('products')
                                              .child(productKey)
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
