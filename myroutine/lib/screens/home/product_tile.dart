import 'package:flutter/material.dart';
import 'package:myroutine/models/product.dart';
import 'package:myroutine/shared/constants.dart';

import '../admin/settings_form.dart';

class ProductTile extends StatelessWidget {
  ProductTile({required this.product });
  final Product product;

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm()
            );
          });
    }
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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: () => _showSettingsPanel(), icon: Icon(Icons.edit)),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            ],
          ),
          )
      )
      );
  }
}
