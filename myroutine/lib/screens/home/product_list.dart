import 'package:flutter/material.dart';
import 'package:myroutine/models/product.dart';
import 'package:myroutine/screens/home/product_tile.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    //TODO nem köti össze a uid-val, ezért tölti be mindig ugyanazt a collectiont
    final products = Provider.of<List<Product>>(context);
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductTile(product: products[index]);
      },
    );
  }
}
