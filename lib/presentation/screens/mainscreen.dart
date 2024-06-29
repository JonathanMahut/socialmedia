import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/enum/user_type.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/domain/services/auth_service.dart';
import 'package:social_media_app/presentation/components/fab_container.dart';
import 'package:social_media_app/presentation/pages/feeds.dart';
import 'package:social_media_app/presentation/pages/notification.dart';
import 'package:social_media_app/presentation/pages/profile.dart';
import 'package:social_media_app/presentation/pages/search.dart';
import 'package:social_media_app/presentation/screens/artist_home_screen.dart';
import 'package:social_media_app/presentation/screens/client_home_screen.dart';
import 'package:social_media_app/presentation/screens/supplier_home_screen.dart';
import 'package:social_media_app/presentation/screens/event_organisator_home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _page = 0;
  List<Map<String, dynamic>> _pages = [];

  @override
  void initState() {
    super.initState();
//    _fetchUserDataAndBuildPages();
  }

  @override
  void didChangeDependencies() {
    // Use didChangeDependencies instead of initState
    super.didChangeDependencies();
    _fetchUserDataAndBuildPages();
  }

  Future<void> _fetchUserDataAndBuildPages() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    User? firebaseUser = authService.getCurrentUser();

    if (firebaseUser != null) {
      DocumentSnapshot userSnapshot = await usersRef.doc(firebaseUser.uid).get();
      if (userSnapshot.exists) {
        UserModel currentUser = UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
        setState(() {
          _pages = _buildPagesForUser(currentUser.userType);
        });
      }
    }
  }

  List<Map<String, dynamic>> _buildPagesForUser(UserType userType) {
    switch (userType) {
      case UserType.client:
        return [
          {
            'title': 'Home',
            'icon': Ionicons.home,
            'page': const ClientHomeScreen(),
            'index': 0,
          },
          {
            'title': 'Search',
            'icon': Ionicons.search,
            'page': const Search(),
            'index': 1,
          },
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
        ];
      case UserType.tattooArtist:
        return [
          {
            'title': 'Home',
            'icon': Ionicons.home,
            'page': const ArtistHomeScreen(),
            'index': 0,
          },
          {
            'title': 'Search',
            'icon': Ionicons.search,
            'page': const Search(),
            'index': 1,
          },
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
        ];
      case UserType.supplier:
        return [
          {
            'title': 'Home',
            'icon': Ionicons.home,
            'page': const SupplierHomeScreen(),
            'index': 0,
          },
          {
            'title': 'Search',
            'icon': Ionicons.search,
            'page': const Search(),
            'index': 1,
          },
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
        ];
      case UserType.eventOrganizer:
        return [
          {
            'title': 'Home',
            'icon': Ionicons.home,
            'page': const EventOrganizerHomeScreen(),
            'index': 0,
          },
          {
            'title': 'Search',
            'icon': Ionicons.search,
            'page': const Search(),
            'index': 1,
          },
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
        ];
      default:
        return []; // Handle unknown user types
    }
  }

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
        child: _pages.isNotEmpty ? _pages[_page]['page'] : Container(),
      ),
      bottomNavigationBar: _pages.isNotEmpty
          ? BottomAppBar(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  for (Map item in _pages)
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
            )
          : const SizedBox.shrink(),
    );
  }

  buildFab() {
    return const SizedBox(
      height: 45.0,
      width: 45.0,
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
