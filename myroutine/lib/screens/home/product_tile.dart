import 'package:flutter/material.dart';
import 'package:myroutine/models/product.dart';

class ProductTile extends StatelessWidget {
  ProductTile({required this.product });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.deepPurple[100],
          ),
            title: Text(product.skinProblem),
            subtitle: Text(product.skinType),
          )
      )
      );
  }
}
