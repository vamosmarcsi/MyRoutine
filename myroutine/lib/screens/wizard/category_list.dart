import 'package:flutter/material.dart';
import 'package:myroutine/screens/wizard/wizard_product_list.dart';
import 'package:myroutine/services/constants.dart';
class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: categories.map((c){
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                title: Text(c),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                          },
                          icon: Icon(Icons.add_circle)),
                    ],
                  )
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
