import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_app/components/fab_container.dart';
import 'package:social_media_app/pages/feeds.dart';
import 'package:social_media_app/pages/notification.dart';
import 'package:social_media_app/pages/profile.dart';
import 'package:social_media_app/pages/search.dart';
import 'package:social_media_app/utils/firebase.dart';

class TabScreenClient extends StatefulWidget {
  const TabScreenClient({super.key});

  @override
  _TabScreenStateClient createState() => _TabScreenStateClient();
}

class _TabScreenStateClient extends State<TabScreenClient> {
  int _page = 0;

  List pages = [
    {
      'title': 'Home',
      'icon': Ionicons.home,
      'page': const Feeds(),
      'index': 0,
    },
    {
      'title': 'Search',
      'icon': Ionicons.search,
      'page': const Search(),
      'index': 1,
    },
    // {
    //   'title': 'unsee',
    //   'icon': Ionicons.add_circle,
    //   'page': const Text('nes'),
    //   'index': 2,
    // },
    {
      'title': 'Notification',
      'icon': CupertinoIcons.bell_solid,
      'page': const Activities(),
      'index': 2,
    },
    {
      'title': 'Profile',
      'icon': CupertinoIcons.person_fill,
      'page': Profile(profileId: firebaseAuth.currentUser!.uid),
      'index': 3,
    },
    // {
    //   'title': 'ProfileClient',
    //   'icon': CupertinoIcons.person_fill,
    //   'page': ProfileClient(profileId: firebaseAuth.currentUser!.uid),
    //   'index': 5,
    // },
    // {
    //   'title': 'ProfileTatooArtist',
    //   'icon': CupertinoIcons.person_fill,
    //   'page': ProfileTatooArtist(profileId: firebaseAuth.currentUser!.uid),
    //   'index': 6,
    // },
    // {
    //   'title': 'flashes',
    //   'icon': Ionicons.flash,
    //   'page': Flashes(),
    //   'index': 7,
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[_page]['page'],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 5),
            for (Map item in pages)
              item['index'] == 2
                  ? buildFab()
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: IconButton(
                        icon: Icon(
                          item['icon'],
                          color: item['index'] != _page
                              ? Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black
                              : Theme.of(context).colorScheme.secondary,
                          size: 25.0,
                        ),
                        onPressed: () => navigationTapped(item['index']),
                      ),
                    ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  buildFab() {
    return const SizedBox(
      height: 45.0,
      width: 45.0,
      // ignore: missing_required_param
      child: FabContainer(
        icon: Ionicons.add_outline,
        mini: true,
      ),
    );
  }

  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
