import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:store/widget/addfirbase/ElevatedButton.dart';
import 'package:store/widget/FormBuilderTextField.dart';

class AddProductPage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إضافة منتجات المقرمشات والوجبات الخفيفة",
          style: TextStyle(
              color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CustomFormBuilderTextField(
                      name: 'category',
                      labelText: 'الفئة',
                      validator: FormBuilderValidators.required(),
                      color: Colors.black,
                      fontSize: 18,
                      borderRadius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormBuilderTextField(
                      name: 'productName',
                      labelText: 'اسم المنتج',
                      validator: FormBuilderValidators.required(),
                      color: Colors.black,
                      fontSize: 18,
                      borderRadius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormBuilderTextField(
                      name: 'quantity',
                      labelText: '(بلكرتونه)الكمية',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                      color: Colors.black,
                      fontSize: 18,
                      keyboardType: TextInputType.number,
                      borderRadius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormBuilderTextField(
                      name: 'pricePerUnit',
                      labelText: 'سعر القطعة',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                      color: Colors.black,
                      fontSize: 18,
                      borderRadius: 50,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CustomFormBuilderTextField(
                      name: 'pricePerCarton',
                      labelText: 'سعر الكرتونة (اختياري)',
                      color: Colors.black,
                      fontSize: 18,
                      keyboardType: TextInputType.number,
                      borderRadius: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormBuilderTextField(
                      name: 'productsPerCarton',
                      labelText: 'عدد المنتجات في الكرتونة',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ]),
                      color: Colors.black,
                      fontSize: 18,
                      borderRadius: 50,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    buildAddProductButton(context, _formKey, databaseReference),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
