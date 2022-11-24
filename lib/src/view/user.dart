import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fireauth/src/helper/firestore.dart';
import 'package:fireauth/src/helper/widget/price_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoramlUserScreen extends StatefulWidget {
  const NoramlUserScreen({super.key});

  @override
  State<NoramlUserScreen> createState() => _NoramlUserScreenState();
}

class _NoramlUserScreenState extends State<NoramlUserScreen> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> priceStream;
  @override
  initState() {
    priceStream = priceDoc.snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: priceStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error.toString());
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                return PriceCard(price: snapshot.data!.get("price"));
              })),
    );
  }
}
