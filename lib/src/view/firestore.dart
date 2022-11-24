import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FireStoreTestScreen extends StatefulWidget {
  const FireStoreTestScreen({super.key});

  @override
  State<FireStoreTestScreen> createState() => _FireStoreTestScreenState();
}

class _FireStoreTestScreenState extends State<FireStoreTestScreen> {
  Map<String, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                // set without merge (create new document , replace old)
                final id = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance.collection("userdata").doc().set({
                  "name": "ALi ${Random().nextInt(50)}",
                  "age": Random().nextInt(50),
                  "address": {"city": "baghdad", "country": "iraq"},
                  "phoneNumber": ["07777", "04444"],
                  "isAdmin": true
                });
                // var collection = FirebaseFirestore.instance
                //     .collection("userdata")
                //     .doc(id)
                //     .collection("messege");
                // collection.doc().set({"msg": "hi"});
                // collection.doc().set({"msg": "hi"});
                // collection.doc().set({"msg": "hi"});
                // collection.doc().set({"msg": "hi"});
              },
              child: Text("add")),
          TextButton(
              onPressed: () {
                // set with merge (create new document if not exist , update if exist)

                final id = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance.collection("userdata").doc(id).set({
                  "name": "Mohmeed",
                  // "age": 18,
                  // "address": {"city": "baghdad", "country": "iraq"},
                  "phoneNumber": ["07777", "04444", "9999"],
                  "isAdmin": true
                }, SetOptions(merge: true));
              },
              child: Text("set with merge")),
          TextButton(
              onPressed: () {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance
                    .collection("userdata")
                    .doc(id)
                    .update({
                  "name": "Hassan",
                  "age": 18,
                  // "address": {"city": "baghdad", "country": "iraq"},
                  "phoneNumber": [
                    "07777",
                  ],
                  // "isAdmin": true
                });
              },
              child: Text("update")),
          TextButton(
              onPressed: () {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                FirebaseFirestore.instance
                    .collection("userdata")
                    .doc(id)
                    .delete();
              },
              child: Text("delete")),
          TextButton(
              onPressed: () async {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                final res = await FirebaseFirestore.instance
                    .collection("userdata")
                    .doc(id)
                    .get();
                data = res.data();
                setState(() {});
              },
              child: Text("get")),
          TextButton(
              onPressed: () async {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                final res = await FirebaseFirestore.instance
                    .collection("userdata")
                    .where("age", isGreaterThan: 15)
                    // .where("name", whereIn: ["Ali", "Hassan"])
                    .where("isAdmin", isEqualTo: true)
                    .get();
                final datas = res.docs.map((e) => e.data()).toList();
                print(datas);
              },
              child: Text("query")),
          TextButton(
              onPressed: () async {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                final res = await FirebaseFirestore.instance
                    .collection("userdata")
                    .where("age", isGreaterThan: 15)
                    .where("isAdmin", isEqualTo: true)
                    .get();
                final datas = res.docs.map((e) => e.data()).toList();
                print(datas);
              },
              child: Text("query")),
          TextButton(
              onPressed: () async {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                final res = await FirebaseFirestore.instance
                    .collection("userdata")
                    .where("age", whereNotIn: [19, 20, 21])
                    // .where("phoneNumber",
                    //     arrayContainsAny: ["07777ds", "0555"])
                    .get();
                final datas = res.docs.map((e) => e.data()).toList();
                print(datas);
              },
              child: Text("query array")),
          TextButton(
              onPressed: () async {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                final res = await FirebaseFirestore.instance
                    .collection("userdata")
                    .where("age", isNotEqualTo: 19)
                    .get();
                print(res.docs.length);
              },
              child: Text("count")),
          TextButton(
              onPressed: () async {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                final res = await FirebaseFirestore.instance
                    .collection("userdata")
                    .orderBy("age", descending: true)
                    .get();
                res.docs
                  // ..sort((f, s) {
                  //   return (s.get("age") as int)
                  //       .compareTo((f.get("age") as int));
                  // })
                  ..forEach((element) {
                    print(element.get("age"));
                  });
              },
              child: Text("order by")),
          TextButton(
              onPressed: () async {
                // only update exist element
                final id = FirebaseAuth.instance.currentUser!.uid;
                final res = await FirebaseFirestore.instance
                    .collection("userdata")
                    // .startAfter(values)
                    .limit(10)
                    .get();
                print(res.docs.length);
              },
              child: Text("count")),
          if (data != null) ...[
            Text(data!['name']),
            Text(data!['isAdmin'].toString())
          ]
        ],
      ),
    );
  }
}
