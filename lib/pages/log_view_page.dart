import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../controller/home_controller.dart';
import 'logview_info_tile.dart';

class LogViewPage extends StatefulWidget {
  const LogViewPage({super.key});

  @override
  State<LogViewPage> createState() => _LogViewPageState();
}

class _LogViewPageState extends State<LogViewPage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 605,
                  child: ListView.separated(
                    itemCount: ctrl.logShowUi.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      return LogViewInfoTile(
                          index: index); // Replace with your actual widget
                    },
                  ),
                ),
              )
            ],
          ),
          backgroundColor: const Color(0xFFE9EFFF),
        );
      },
    );
  }
}
