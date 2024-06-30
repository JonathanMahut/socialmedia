import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/domain/services/post_service.dart';
import 'package:social_media_app/presentation/pages/profile.dart';
import 'package:social_media_app/presentation/screens/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewPostDetails extends StatefulWidget {
  final PostModel post;

  const ViewPostDetails({super.key, required this.post});

  @override
  State<ViewPostDetails> createState() => _ViewPostDetailsState();
}

class _ViewPostDetailsState extends State<ViewPostDetails> {
  int _currentMediaIndex = 0;
  final PostService services = PostService();
  String currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: SingleChildScrollView(
        // Wrap in SingleChildScrollView for scrollable content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
            buildUserInfoRow(context),
            const SizedBox(height: 10),

            // Carousel for Media
            CarouselSlider(
              items: widget.post.mediaUrls.map((mediaUrl) {
                return Builder(
                  builder: (BuildContext context) {
                    return CachedNetworkImage(
                      imageUrl: mediaUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.width, // Responsive height
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentMediaIndex = index;
                  });
                },
              ),
            ),

            // Indicators for Carousel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.post.mediaUrls.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentMediaIndex == entry.key ? Colors.blueAccent : Colors.grey,
                  ),
                );
              }).toList(),
            ),

            // Like and Comment Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  buildLikeButton(),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => CommentsScreen(post: widget.post),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.chat_bubble, size: 20),
                        const SizedBox(width: 4),
                        StreamBuilder(
                          stream: commentRef.doc(widget.post.postId).collection("comments").snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              QuerySnapshot snap = snapshot.data!;
                              List<DocumentSnapshot> docs = snap.docs;
                              return Text('${docs.length} comments', style: const TextStyle(fontSize: 14));
                            } else {
                              return const Text('0 comments', style: TextStyle(fontSize: 14));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Likes Count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: likesRef.where('postId', isEqualTo: widget.post.postId).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    QuerySnapshot snap = snapshot.data!;
                    List<DocumentSnapshot> docs = snap.docs;
                    return Text('${docs.length} likes',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
                  } else {
                    return const Text('0 likes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
                  }
                },
              ),
            ),

            // Description and Hashtags
            if (widget.post.description != null && widget.post.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(widget.post.description!, style: const TextStyle(fontSize: 16)),
              ),
            if (widget.post.hashtags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 8.0,
                  children: widget.post.hashtags.map((hashtag) {
                    return Text(
                      '#$hashtag',
                      style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                    );
                  }).toList(),
                ),
              ),

            // Timestamp
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                timeago.format(widget.post.timestamp.toDate()),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build User Information Row
  Widget buildUserInfoRow(BuildContext context) {
    return StreamBuilder(
      stream: usersRef.doc(widget.post.ownerId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data!;
          UserModel user = UserModel.fromJson(snap.data() as Map<String, dynamic>);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => showProfile(context, profileId: user.id),
                  child: user.photoUrl!.isEmpty
                      ? CircleAvatar(
                          radius: 20,
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          child: Center(
                            child: Text(
                              user.username[0].toUpperCase(),
                              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider('${user.photoUrl}'),
                        ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    if (widget.post.location != null && widget.post.location!.isNotEmpty)
                      Text(
                        widget.post.location!,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                  ],
                ),
                const Spacer(), // Push elements to the left
                IconButton(
                  onPressed: () {
                    // Handle more options (report, share, etc.)
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  // Build Like Button
  Widget buildLikeButton() {
    return StreamBuilder(
      stream: likesRef
          .where('postId', isEqualTo: widget.post.postId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];

          Future<bool> onLikeButtonTapped(bool isLiked) async {
            if (docs.isEmpty) {
              likesRef.add({
                'userId': currentUserId(),
                'postId': widget.post.postId,
                'dateCreated': Timestamp.now(),
              });
              addLikesToNotification();
              return !isLiked;
            } else {
              likesRef.doc(docs[0].id).delete();
              services.removeLikeFromNotification(widget.post.ownerId, widget.post.postId, currentUserId());
              return isLiked;
            }
          }

          return LikeButton(
            onTap: onLikeButtonTapped,
            size: 20,
            circleColor: const CircleColor(start: Color(0xffFFC0CB), end: Color(0xffff0000)),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Color(0xffFFA500),
              dotSecondaryColor: Color(0xffd8392b),
              dotThirdColor: Color(0xffFF69B4),
              dotLastColor: Color(0xffff8c00),
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                docs.isEmpty ? Ionicons.heart_outline : Ionicons.heart,
                color: docs.isEmpty
                    ? Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black
                    : Colors.red,
                size: 20,
              );
            },
          );
        }
        return Container();
      },
    );
  }

  // Add Likes to Notification
  addLikesToNotification() async {
    bool isNotMe = currentUserId() != widget.post.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      services.addLikesToNotification(
        "like",
        user.username,
        currentUserId(),
        widget.post.postId,
        widget.post.mediaUrls[0],
        widget.post.ownerId,
        user.photoUrl!,
      );
    }
  }

  // Show Profile
  showProfile(BuildContext context, {String? profileId}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => Profile(profileId: profileId!),
      ),
    );
  }
}
