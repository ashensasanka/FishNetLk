import 'package:fishnetlk/features/posts/presentation/widgets/make_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../../controller/home_controller.dart';
import '../../../../core/widgets/post_info_tile.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchPostsList();
        },
        child: CustomScrollView(
          slivers: [
            FeedMakePostWidget(),
            //PostMyList(),
            SliverToBoxAdapter(
              child: Container(
                height: 605,
                // Set a height or adjust it according to your layout
                child: ListView.separated(
                  itemCount: ctrl.postdetails.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return PostInfoTile(index:index); // Replace with your actual widget
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

