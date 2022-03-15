import 'package:flutter/material.dart';
import 'package:myroutine/models/product.dart';
import 'package:myroutine/shared/constants.dart';

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
            backgroundColor: myPrimaryColor,
          ),
            title: Text(product.brand),
            subtitle: Text(product.name),
          )
      )
      );
  }
}
