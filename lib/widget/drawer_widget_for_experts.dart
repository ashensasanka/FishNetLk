import 'package:flutter/material.dart';
import '../data/drawer_items_for_experts.dart';
import '../model/drawer_item_for_experts.dart';

class ExpertsDrawerWidget extends StatelessWidget{
  final ValueChanged<ExpertsDrawerItem> onSelectedItem;

  const ExpertsDrawerWidget({
    Key? key,
    required this.onSelectedItem,
}) :super(key:key);

  @override
  Widget build(BuildContext context)=> Container(
    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
    child: SingleChildScrollView(
      child: Column(
        children: [
          const DrawerHeader(child: Icon(Icons.person, size: 100,color: Colors.black,)),
          buildDrawerItems(context),
        ],
      ),
    ),
  );

  Widget buildDrawerItems(BuildContext context) =>Column(
    children: ExpertsDrawerItems.all
        .map(
            (item) => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              leading: Icon(item.icon, color: Colors.black,),
              title: Text(
                item.title,
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
              onTap: () => onSelectedItem(item),
            )
        )
        .toList(),
  );
}