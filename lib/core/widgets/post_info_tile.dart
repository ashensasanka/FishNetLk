import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishnetlk/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../controller/home_controller.dart';
import '../../features/posts/presentation/widgets/icon_text_button.dart';
import '../../features/posts/presentation/widgets/post_Image_video_view.dart';
import '../../features/posts/presentation/widgets/round_like_icon.dart';

// Post information tile
class PostInfoTile extends StatelessWidget {
  int index ;
  PostInfoTile({
    Key? key,
    required this.index
  }) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

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
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                          stream: _firestore
                              .collection('Users')
                              .doc('${userId.postdetails[index].email.toString()}')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            }
                            final DocumentSnapshot document = snapshot.data!;
                            final Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                            return Text(
                              '${data['username']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                        Text(
                          userId.postdetails[index].createDay!.fromNow(),
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
                child: Text('* ${userId.postdetails[index].from} *',
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
// Post like buttons
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