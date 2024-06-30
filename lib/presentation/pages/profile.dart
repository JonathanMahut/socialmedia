import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/presentation/pages/auth/register/register.dart';
import 'package:social_media_app/presentation/screens/edit_profile.dart';
import 'package:social_media_app/presentation/screens/settings.dart';
import 'package:social_media_app/presentation/widgets/post_tiles.dart';

class Profile extends StatefulWidget {
  final String profileId;

  const Profile({super.key, required this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  UserModel? users;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      DocumentSnapshot doc = await usersRef.doc(widget.profileId).get();
      if (doc.exists) {
        setState(() {
          users = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      // Handle error appropriately (e.g., show a snackbar)
    }
  }

  checkIfFollowing() async {
    DocumentSnapshot doc =
        await followersRef.doc(widget.profileId).collection('userFollowers').doc(currentUserId()).get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  buildCountColumn(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        )
      ],
    );
  }

  buildProfileButton() {
    // viewing your own profile - should show edit profile button
    bool isProfileOwner = widget.profileId == currentUserId();
    if (isProfileOwner) {
      return buildButton(
          text: "Edit Profile",
          function: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => EditProfile(
                  user: users,
                ),
              ),
            );
          });
      // viewing someone else's profile - should show follow/unfollow button
    } else if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollow,
      );
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollow,
      );
    }
  }

  buildButton({required String text, required VoidCallback function}) {
    return SizedBox(
      width: 130.0,
      height: 38.0,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFollowing ? Colors.white : Colors.blue,
          side: BorderSide(
            color: isFollowing ? Colors.grey : Colors.blue,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isFollowing ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  handleUnfollow() {
    // Implement unfollow logic here
    print('Unfollow clicked');
  }

  handleFollow() {
    // Implement follow logic here
    print('Follow clicked');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tatoo Connect'),
        actions: [
          if (widget.profileId == firebaseAuth.currentUser!.uid)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () async {
                    await firebaseAuth.signOut();
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (_) => const Register(),
                      ),
                    );
                  },
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
      body: StreamBuilder(
        stream: usersRef.doc(widget.profileId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('User not found'));
          }
          UserModel user = UserModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: false,
                toolbarHeight: 5.0,
                collapsedHeight: 6.0,
                expandedHeight: 225.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            // Wrap the first Padding in an Expanded
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  user.photoUrl?.isEmpty ?? true
                                      ? CircleAvatar(
                                          radius: 40.0,
                                          backgroundColor: Theme.of(context).colorScheme.secondary,
                                          child: Center(
                                            child: Text(
                                              user.username[0].toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 40.0,
                                          backgroundImage: CachedNetworkImageProvider(
                                            '${user.photoUrl}',
                                          ),
                                        ),
                                  const SizedBox(width: 20.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 32.0),
                                        Text(
                                          user.username,
                                          style: TextStyle(
                                            fontSize: constraints.maxWidth > 600 ? 18 : 16,
                                            fontWeight: FontWeight.w900,
                                          ),
                                          maxLines: null,
                                        ),
                                        Text(
                                          user.country!,
                                          style: TextStyle(
                                            fontSize: constraints.maxWidth > 600 ? 14 : 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          user.email,
                                          style: const TextStyle(fontSize: 10.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (widget.profileId == currentUserId())
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (_) => const Setting(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Ionicons.settings_outline,
                                        color: Theme.of(context).colorScheme.secondary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            // Wrap the second Padding in an Expanded
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: user.bio!.isEmpty
                                  ? Container()
                                  : Text(
                                      user.bio!,
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: null,
                                    ),
                            ),
                          ),
                          Expanded(
                            // Wrap the third Padding in an Expanded
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  StreamBuilder(
                                    stream: postRef.where('ownerId', isEqualTo: widget.profileId).snapshots(),
                                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        postCount = snapshot.data!.docs.length;
                                        return buildCountColumn("POSTS", postCount);
                                      } else {
                                        return buildCountColumn("POSTS", 0);
                                      }
                                    },
                                  ),
                                  StreamBuilder(
                                    stream: followersRef.doc(widget.profileId).collection('userFollowers').snapshots(),
                                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        followersCount = snapshot.data!.docs.length;
                                        return buildCountColumn("FOLLOWERS", followersCount);
                                      } else {
                                        return buildCountColumn("FOLLOWERS", 0);
                                      }
                                    },
                                  ),
                                  StreamBuilder(
                                    stream: followingRef.doc(widget.profileId).collection('userFollowing').snapshots(),
                                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        followingCount = snapshot.data!.docs.length;
                                        return buildCountColumn("FOLLOWING", followingCount);
                                      } else {
                                        return buildCountColumn("FOLLOWING", 0);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0), // No need to wrap SizedBox in Expanded
                          if (widget.profileId != currentUserId())
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: buildProfileButton(),
                            )
                          else
                            const SizedBox(),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: postRef
                          .where('ownerId', isEqualTo: widget.profileId)
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              PostModel post =
                                  PostModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                              return PostTile(post: post);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('No posts yet'),
                          );
                        }
                      },
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
