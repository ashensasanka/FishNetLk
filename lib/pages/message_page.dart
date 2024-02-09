import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget/drawer_menu_widget.dart';

class MessagePage extends ConsumerStatefulWidget {
  final VoidCallback openDrawer;

  const MessagePage({super.key, required this.openDrawer});

  @override
  ConsumerState<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends ConsumerState<MessagePage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: DrawerMenuWidget(onClicked: widget.openDrawer),
          title: const Text('Message Page'),
        ),
      );
}