import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../controller/home_controller.dart';
import '../../features/posts/presentation/widgets/icon_text_button.dart';
import '../../features/posts/presentation/widgets/round_like_icon.dart';

class LogViewInfoTile extends StatelessWidget {
  int index ;
  LogViewInfoTile({
    Key? key,
    required this.index
  }) : super(key: key);

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
                  Text('LogBook of ${userId.makePostUi[1].fullName}'),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    ],
                  ),

                  const Spacer(),
                  const Icon(Icons.more_horiz),
                ],
              ),
            ),
            Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text('Date : ${userId.logShowUi[index].date.toString().split(' ')[0]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Name : ${userId.logShowUi[index].name}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Method of Fishing : ${userId.logShowUi[index].method}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Location : ${userId.logShowUi[index].lat} , ${userId.logShowUi[index].long}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Quantity : ${userId.logShowUi[index].quantity} kg'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('All Costs : Rs. ${userId.logShowUi[index].cost}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Selling Price (1kg) : Rs. ${userId.logShowUi[index].sellprice}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text('Quantity sold : Rs. ${userId.logShowUi[index].soldquantity}'),
            ),
            const SizedBox(height: 15,)
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
        Text('$likes'),
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
        const IconTextButton(
          icon: FontAwesomeIcons.solidMessage,
          label: 'Comment',
        ),
        const IconTextButton(
          icon: FontAwesomeIcons.share,
          label: 'Share',
        ),
      ],
    );
  }
}
