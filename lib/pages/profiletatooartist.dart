import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_app/auth/register/register.dart';
import 'package:social_media_app/components/stream_grid_wrapper.dart';
import 'package:social_media_app/models/enum/gender_type.dart';
import 'package:social_media_app/models/enum/user_type.dart';
import 'package:social_media_app/models/post.dart';
import 'package:social_media_app/models/tatoo_artist.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/edit_profile.dart';
import 'package:social_media_app/screens/list_posts.dart';
import 'package:social_media_app/screens/settings.dart';
import 'package:social_media_app/utils/firebase.dart';
import 'package:social_media_app/widgets/genredropdownwidget.dart';
import 'package:social_media_app/widgets/post_tiles.dart';

class ProfileTatooArtist extends StatefulWidget {
  final profileId;

  const ProfileTatooArtist({super.key, this.profileId});

  @override
  _ProfileTatooArtistState createState() => _ProfileTatooArtistState();
}

class _ProfileTatooArtistState extends State<ProfileTatooArtist> {
  User? user;
  bool isLoading = false;
  int postCount = 0;
  int followersCount = 0;
  int followingCount = 0;
  bool isFollowing = false;
  UserModel? users;
  final DateTime timestamp = DateTime.now();
  ScrollController controller = ScrollController();

  String userType = UserType.CLIENT.name;

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  void initState() {
    super.initState();
    checkIfFollowing();
  }

  // Determine usertype of the current user

  checkCurrentUserType() async {
    DocumentSnapshot doc = await usersRef
        .doc(currentUserId())
        .collection('users')
        .doc(currentUserId())
        .get();
    // Get the Usertype of the current user
    userType = doc.get('usertype');

    // Define the good User Model for the current user according to the Usertype

    setState(() {
      if (userType == UserType.CLIENT.name) {
        // Code for Client user type
      } else if (userType == UserType.TATOOARTIST.name) {
        // Code for TatooArtist user type
      } else if (userType == UserType.VENDOR.name) {
        // Code for Vendor user type
      } else if (userType == UserType.EVENTORGANISATOR.name) {
        // Code for EventOrganisator user type
      } else {
        // Code for default user type
      }
    });
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId())
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    GenderType selectedGenre = GenderType.UNKNOWN;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Tatoo Connect'),
        actions: [
          widget.profileId == firebaseAuth.currentUser!.uid
              ? Center(
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
              : const SizedBox()
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            floating: false,
            toolbarHeight: 5.0,
            collapsedHeight: 6.0,
            expandedHeight: 225.0,
            flexibleSpace: FlexibleSpaceBar(
              background: StreamBuilder(
                stream: usersRef.doc(widget.profileId).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    TatooArtist user = TatooArtist.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: user.photoUrl?.isEmpty ?? true
                                  ? CircleAvatar(
                                      radius: 40.0,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      child: Center(
                                        child: Text(
                                          user.username![0].toUpperCase(),
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
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        '${user.photoUrl}',
                                      ),
                                    ),
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 32.0),
                                Row(
                                  children: [
                                    const Visibility(
                                      visible: false,
                                      child: SizedBox(width: 10.0),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 130.0,
                                          child: Text(
                                            user.username!,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            maxLines: null,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 130.0,
                                          child: Text(
                                            user.country!,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.email!,
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    widget.profileId == currentUserId()
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                  builder: (_) =>
                                                      const Setting(),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Ionicons.settings_outline,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                const Text(
                                                  'settings',
                                                  style: TextStyle(
                                                    fontSize: 11.5,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : const Text('')
                                    // : buildLikeButton()
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, left: 20.0),
                                  child: user.bio!.isEmpty
                                      ? Container()
                                      : SizedBox(
                                          width: 200,
                                          child: Text(
                                            user.bio!,
                                            style: const TextStyle(
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: null,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Container(),
                        //Diplay the Gender of the currennt user if the
                        user.userType == UserType.TATOOARTIST.name ||
                                user.userType == UserType.CLIENT.name
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 20.0),
                                child: SizedBox(
                                  width: 200,
                                  child: GenreDDWidget(
                                    initial: selectedGenre,
                                    onItemChange: (GenderType g) =>
                                        selectedGenre = g,
                                  ),
                                ),
                              )
                            : Container(),
                        //Diplay list of TattooStylist if user is a TatooArtist
                        user.userType == UserType.TATOOARTIST.name
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, left: 20.0),
                                child: SizedBox(
                                  width: 200,
                                  child: Text(
                                    'Website : ${user.website}',
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: null,
                                  ),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: 50.0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                StreamBuilder(
                                  stream: postRef
                                      .where('ownerId',
                                          isEqualTo: widget.profileId)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot<Object?>? snap =
                                          snapshot.data;
                                      List<DocumentSnapshot> docs = snap!.docs;
                                      return buildCount("POSTS", docs.length);
                                    } else {
                                      return buildCount("POSTS", 0);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 0.3,
                                    color: Colors.grey,
                                  ),
                                ),
                                StreamBuilder(
                                  stream: followersRef
                                      .doc(widget.profileId)
                                      .collection('userFollowers')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot<Object?>? snap =
                                          snapshot.data;
                                      List<DocumentSnapshot> docs = snap!.docs;
                                      return buildCount(
                                          "FOLLOWERS", docs.length);
                                    } else {
                                      return buildCount("FOLLOWERS", 0);
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 0.3,
                                    color: Colors.grey,
                                  ),
                                ),
                                StreamBuilder(
                                  stream: followingRef
                                      .doc(widget.profileId)
                                      .collection('userFollowing')
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot<Object?>? snap =
                                          snapshot.data;
                                      List<DocumentSnapshot> docs = snap!.docs;
                                      return buildCount(
                                          "FOLLOWING", docs.length);
                                    } else {
                                      return buildCount("FOLLOWING", 0);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        buildProfileButton(user),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index > 0) return null;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            'All Posts',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () async {
                              DocumentSnapshot doc =
                                  await usersRef.doc(widget.profileId).get();
                              var currentUser = UserModel.fromJson(
                                doc.data() as Map<String, dynamic>,
                              );
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => ListPosts(
                                    userId: widget.profileId,
                                    username: currentUser.username,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Ionicons.grid_outline),
                          )
                        ],
                      ),
                    ),
                    buildPostView()
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  buildCount(String label, int count) {
    return Column(
      children: <Widget>[
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
            fontFamily: 'Ubuntu-Regular',
          ),
        ),
        const SizedBox(height: 3.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontFamily: 'Ubuntu-Regular',
          ),
        )
      ],
    );
  }

  buildProfileButton(user) {
    if (widget.profileId == firebaseAuth.currentUser!.uid) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (_) => EditProfile(
                user: user,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          width: 250.0,
          height: 40.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              'Edit Profile',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
    }
    return buildFollowButton(user);
  }

  buildFollowButton(user) {
    // if viewing your own profile - show edit profile button
    if (widget.profileId == firebaseAuth.currentUser!.uid) {
      return buildProfileButton(user);
    }
    // display follow button
    return InkWell(
      onTap: () {
        handleFollow(user);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        width: 250.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: isFollowing
              ? Colors.white
              : Theme.of(context).colorScheme.secondary,
          border: Border.all(
            color: isFollowing
                ? Colors.grey
                : Theme.of(context).colorScheme.secondary,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            isFollowing ? 'Unfollow' : 'Follow',
            style: TextStyle(
              color: isFollowing ? Colors.black : Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  handleFollow(user) {
    if (isFollowing) {
      // unfollow user
      followersRef
          .doc(widget.profileId)
          .collection('userFollowers')
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
      followingRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection('userFollowing')
          .doc(widget.profileId)
          .get()
          .then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
      setState(() {
        isFollowing = false;
      });
    } else {
      // follow user
      followersRef
          .doc(widget.profileId)
          .collection('userFollowers')
          .doc(firebaseAuth.currentUser!.uid)
          .set({});
      followingRef
          .doc(firebaseAuth.currentUser!.uid)
          .collection('userFollowing')
          .doc(widget.profileId)
          .set({});
      setState(() {
        isFollowing = true;
      });
    }
  }

  buildPostView() {
    return StreamGridWrapper(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      physics: const NeverScrollableScrollPhysics(),
      stream: postRef.where('ownerId', isEqualTo: widget.profileId).snapshots(),
      itemBuilder: (_, documentSnapshot) {
        PostModel post = PostModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        );
        return PostTile(
          post: post,
        );
      },
    );
  }
}
