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

class LogViewInfoTile extends StatelessWidget {
  int index ;
  LogViewInfoTile({
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
                  Text('LogBook of ' + userId.makePostUi[1].fullName.toString()),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigator.of(context).pushNamed(
                  //     //   ProfileScreen.routeName,
                  //     //   arguments: userId,
                  //     // );
                  //   },
                  //   child: CircleAvatar(
                  //     // backgroundImage: NetworkImage(userId.makePostUi[1].image as String),
                  //   ),
                  // ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   userId.makePostUi[1].fullName as String,
                      //   style: const TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      // Text(
                      //   userId.makePostUi[1].birthDay!.fromNow(),
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey,
                      //   ),
                      // ),
                    ],
                  ),

                  const Spacer(),
                  const Icon(Icons.more_horiz),
                ],
              ),
            ),
            Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('Date : ' + userId.logShowUi[index].date.toString().split(' ')[0],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Name : '+userId.logShowUi[index].name.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Method of Fishing : '+userId.logShowUi[index].method.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Location : '+userId.logShowUi[index].lat.toString()+' , '+userId.logShowUi[index].long.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Quantity : '+userId.logShowUi[index].quantity.toString()+' kg'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('All Costs : Rs. '+userId.logShowUi[index].cost.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Selling Price (1kg) : Rs. '+userId.logShowUi[index].sellprice.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Quantity sold : Rs. '+userId.logShowUi[index].soldquantity.toString()),
            ),
            SizedBox(height: 15,)
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
