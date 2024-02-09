import 'package:fishnetlk/data/drawer_items.dart';
import 'package:flutter/material.dart';
import '../model/drawer_item.dart';

class DrawerWidget extends StatelessWidget{
  final ValueChanged<DrawerItem> onSelectedItem;

  const DrawerWidget({
    Key? key,
    required this.onSelectedItem,
}) :super(key:key);

  @override
  Widget build(BuildContext context)=> Container(
    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.person, size: 100,color: Colors.black,)),
          buildDrawerItems(context),
        ],
      ),
    ),
  );

  Widget buildDrawerItems(BuildContext context) =>Column(
    children: DrawerItems.all
        .map(
            (item) => ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Icon(item.icon, color: Colors.black,),
              title: Text(
                item.title,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              onTap: () => onSelectedItem(item),
            )
        )
        .toList(),
  );
}