import 'package:flutter/material.dart';

class PriceCard extends StatelessWidget {
  final String price;
  const PriceCard({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            "سعر الدولار اليوم هو",
            style: Theme.of(context).textTheme.headline5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              price,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ]),
      ),
    );
  }
}
