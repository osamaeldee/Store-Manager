import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

Widget buildAddProductButtonother(
  BuildContext context,
  GlobalKey<FormBuilderState> _formKey,
  DatabaseReference databaseReference, {
  double buttonWidth = double.infinity,
  double fontSize = 16.0,
  Color buttonColor = Colors.green,
  Color textColor = Colors.white,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState?.saveAndValidate() ?? false) {
            final Map<String, dynamic> formData =
                Map.from(_formKey.currentState!.value);
            final int quantityPerCarton =
                int.tryParse(formData['quantityPerCarton'] ?? '') ?? 0;
            final double pricePerCarton =
                double.tryParse(formData['pricePerCarton'] ?? '') ?? 0.0;
            final double totalPrice = quantityPerCarton * pricePerCarton;

            formData['totalPrice'] = totalPrice.toStringAsFixed(2);

            DatabaseReference newProductRef =
                databaseReference.child('products_in_cartons').push();
            newProductRef.set(formData).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('تم إضافة المنتج بنجاح!'),
                ),
              );
              _formKey.currentState?.reset();
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('حدث خطأ أثناء إضافة المنتج: $error'),
                ),
              );
            });
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: Text(
          'إضافة المنتج',
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
