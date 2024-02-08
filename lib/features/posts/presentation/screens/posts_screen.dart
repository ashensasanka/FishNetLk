import 'package:fishnetlk/core/screens/error_screen.dart';
import 'package:fishnetlk/core/screens/loader.dart';
import 'package:fishnetlk/features/posts/presentation/widgets/make_post_widget.dart';
import 'package:fishnetlk/features/posts/presentation/widgets/post_tile.dart';
import 'package:fishnetlk/features/posts/providers/get_all_posts_provider.dart';
// import 'package:fishnetlk/features/story/presentation/screens/stories_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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



            // Stories View
            // StoriesView(),
            // SliverToBoxAdapter(
            //   child: SizedBox(height: 8),
            // ),

            // displays list of posts

          ],
        ),
      );
    });
  }
}

// class PostsList extends ConsumerWidget {
//   const PostsList({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final posts = ref.watch(getAllPostsProvider);
//
//     return posts.when(
//       data: (postsList) {
//         return SliverList.separated(
//
//           itemCount: postsList.length,
//           separatorBuilder: (context, index) => const SizedBox(height: 8),
//           itemBuilder: (context, index) {
//             final post = postsList.elementAt(index);
//             return Text(post.content);
//           },
//         );
//       },
//       error: (error, stackTrace) {
//         return SliverToBoxAdapter(
//           child: ErrorScreen(error: error.toString()),
//         );
//       },
//       loading: () {
//         return const SliverToBoxAdapter(
//           child: Loader(),
//         );
//       },
//     );
//   }
// }

