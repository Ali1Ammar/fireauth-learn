import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireauth/src/helper/firestore.dart';
import 'package:fireauth/src/helper/nav_helper.dart';
import 'package:fireauth/src/view/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final priceController = TextEditingController();

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ادخل السعر الجديد",
                textDirection: TextDirection.rtl,
              ),
            ),
            TextField(
              controller: priceController,
              onChanged: (val) {
                priceDoc
                    .set({"price": val, "date": FieldValue.serverTimestamp()});
              },
            ),
            TextButton(
                onPressed: () {
                  priceDoc.set({
                    "price": priceController.text,
                    "date": FieldValue.serverTimestamp()
                  });
                },
                child: Text("تحديث")),
          ],
        ),
      ),
    );
  }
}
