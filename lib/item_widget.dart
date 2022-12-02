// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:proj_list/home_controller.dart';
import 'package:proj_list/models/item_model.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  final ItemModel item;
  final Function()? removeClicked;

  const ItemWidget(
      {super.key, required this.item, required this.removeClicked});

  @override
  Widget build(BuildContext context) {
    //final controller = Provider.of<HomeController>(context);
    return Observer(
      builder: (_) {
        return ListTile(
          title: Text(item.title),
          leading: Checkbox(
            value: item.check,
            onChanged: (bool? value) {
              item.setCheck(value);
            },
          ),
          trailing: IconButton(
            color: Colors.red,
            icon: Icon(Icons.remove_circle),
            onPressed: removeClicked,
          ),
        );
      },
    );
  }
}
