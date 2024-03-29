import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  final VoidCallback onClicked;

  const DrawerMenuWidget({
    Key? key,
  required this.onClicked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
      // icon: FaIcon(FontAwesomeIcons.alignLeft),
      icon: const Icon(Icons.menu),
      color: Colors.black,
      onPressed: onClicked,
  );
}
