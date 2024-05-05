import 'package:fishnetlk/features/chat/presentation/screens/chats_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '/core/screens/error_screen.dart';
import '/features/posts/presentation/screens/create_post_screen.dart';

class Routes {
  // Here we defined the page routs when we pressing the buttons gave an argument of the app
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreatePostScreen.routeName:
        return _cupertinoRoute(
          const CreatePostScreen(),
        );
      case ChatScreen.routeName:
        return _cupertinoRoute(
          const ChatScreen(
            userId: 'userIds',
          ),
        );
      case ChatsScreen.routeName:
        return _cupertinoRoute(
          const ChatsScreen(),
        );
      default:
        return _cupertinoRoute(
          ErrorScreen(
            error: 'Wrong Route provided ${settings.name}',
          ),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );

  Routes._();
}
