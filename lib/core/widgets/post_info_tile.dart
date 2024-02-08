// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fishnetlk/core/constants/extensions.dart';
import 'package:fishnetlk/core/screens/loader.dart';
// import 'package:fishnetlk/core/screens/profile_screen.dart';
import 'package:fishnetlk/features/auth/providers/get_user_info_by_id_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controller/home_controller.dart';
import '../../features/posts/presentation/widgets/icon_text_button.dart';
import '../../features/posts/presentation/widgets/post_Image_video_view.dart';
import '../../features/posts/presentation/widgets/round_like_icon.dart';

class PostInfoTile extends StatelessWidget {
  int index ;
  PostInfoTile({
    Key? key,
    required this.index
    // required this.datePublished,
    // required this.userId,
  }) : super(key: key);

  // final DateTime datePublished;
  // final String userId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (userId) {
        return Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(
                        //   ProfileScreen.routeName,
                        //   arguments: userId,
                        // );
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userId.makePostUi[1].image as String),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userId.makePostUi[1].fullName as String,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userId.makePostUi[1].birthDay!.fromNow(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Text('* ' + userId.postdetails[index].from.toString() + ' *',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 4),
                child: Text(userId.postdetails[index].title as String),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: Text(userId.postdetails[index].description as String),
              ),
              PostImageVideoView(
                fileUrl: userId.postdetails[index].image as String,
                fileType: userId.postdetails[index].filetype as String,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    // Post stats
                    PostStats(
                      likes: 1,
                    ),
                    const Divider(),
                    // // Post Buttons
                    PostButtons(),
                  ],
                ),
              )
            ],
          ),
        );
  });
}
}

 class PostStats extends StatelessWidget {
  const PostStats({
    super.key,
    required this.likes,
  });

  final int likes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const RoundLikeIcon(),
        const SizedBox(width: 5),
        Text('${likes}'),
      ],
    );
  }
}

class PostButtons extends StatefulWidget {
  const PostButtons({super.key});

  @override
  State<PostButtons> createState() => _PostButtonsState();
}

class _PostButtonsState extends State<PostButtons> {
  bool isLiked = true;
  @override
  Widget build(BuildContext context) {

    // final isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconTextButton(
          icon: isLiked
              ? Icons.thumb_up_alt
              : Icons.thumb_up_alt_outlined,
          color: isLiked ? Colors.blue : Colors.black,
          label: 'Like',
          onPressed: () {
            // Toggle the liked state when the button is pressed
            setState(() {
              isLiked = !isLiked;
            });
            // TODO: Perform any other necessary operations, such as updating the server or local state
          },
        ),
        IconTextButton(
          icon: FontAwesomeIcons.solidMessage,
          label: 'Comment',
          // onPressed: () {
          //   Navigator.of(context).pushNamed(
          //     CommentsScreen.routeName,
          //     arguments: post.postId,
          //   );
          // },
        ),
        IconTextButton(
          icon: FontAwesomeIcons.share,
          label: 'Share',
        ),
      ],
    );
  }
}


// class PostButtons extends StatelessWidget {
//   const PostButtons({
//     super.key,
//     // required this.post,
//   });
//
//   // final Post post;
//
//   @override
//   Widget build(BuildContext context) {
//     bool isLiked = true;
//     // final isLiked = post.likes.contains(FirebaseAuth.instance.currentUser!.uid);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         IconTextButton(
//           icon: isLiked
//               ? Icons.thumb_up_alt
//               : Icons.thumb_up_alt_outlined,
//           color: isLiked ? Colors.blue : Colors.black,
//           label: 'Like',
//           onPressed: () {
//             // Toggle the liked state when the button is pressed
//             setState(() {
//               isLiked = !isLiked;
//             });
//             // TODO: Perform any other necessary operations, such as updating the server or local state
//           },
//         ),
//         IconTextButton(
//           icon: FontAwesomeIcons.solidMessage,
//           label: 'Comment',
//           // onPressed: () {
//           //   Navigator.of(context).pushNamed(
//           //     CommentsScreen.routeName,
//           //     arguments: post.postId,
//           //   );
//           // },
//         ),
//         IconTextButton(
//           icon: FontAwesomeIcons.share,
//           label: 'Share',
//         ),
//       ],
//     );
//   }
// }