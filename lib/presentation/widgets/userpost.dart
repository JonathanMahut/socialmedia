import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/domain/services/post_service.dart';
import 'package:social_media_app/presentation/components/custom_card.dart';
import 'package:social_media_app/presentation/pages/profile.dart';
import 'package:social_media_app/presentation/screens/comment.dart';
import 'package:social_media_app/presentation/screens/view_image.dart'; // You'll need to create this screen
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/view_post_details.dart..dart';

class UserPost extends StatefulWidget {
  final PostModel post;

  const UserPost({Key? key, required this.post}) : super(key: key);

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  final DateTime timestamp = DateTime.now();
  int _currentMediaIndex = 0;

  String currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  final PostService services = PostService();

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => ViewPostDetails(post: widget.post), // Navigate to detailed post view
          ),
        );
      },
      borderRadius: BorderRadius.circular(10.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Carousel for multiple images/videos
              CarouselSlider(
                items: widget.post.mediaUrls.map((mediaUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: mediaUrl,
                          height: constraints.maxWidth < 600 ? 250 : 350,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: constraints.maxWidth < 600 ? 250 : 350,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentMediaIndex = index;
                    });
                  },
                ),
              ),
              // Indicators for carousel
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Row(
                        children: [
                          buildLikeButton(),
                          const SizedBox(width: 10.0),
                          InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => CommentsScreen(post: widget.post),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.chat_bubble,
                                  size: 25.0,
                                ),
                                const SizedBox(width: 5.0),
                                StreamBuilder(
                                  stream: commentRef.doc(widget.post.postId).collection("comments").snapshots(),
                                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      QuerySnapshot snap = snapshot.data!;
                                      List<DocumentSnapshot> docs = snap.docs;
                                      return buildCommentsCount(context, docs.length);
                                    } else {
                                      return buildCommentsCount(context, 0);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    StreamBuilder<QuerySnapshot>(
                      stream: likesRef.where('postId', isEqualTo: widget.post.postId).snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          QuerySnapshot snap = snapshot.data!;
                          List<DocumentSnapshot> docs = snap.docs;
                          return buildLikesCount(context, docs.length);
                        } else {
                          return buildLikesCount(context, 0);
                        }
                      },
                    ),
                    if (widget.post.description != null && widget.post.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 3.0),
                        child: Text(
                          widget.post.description!,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                            fontSize: 15.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    const SizedBox(height: 3.0),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        timeago.format(widget.post.timestamp.toDate()),
                        style: const TextStyle(fontSize: 10.0),
                      ),
                    ),
                    if (widget.post.hashtags.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 3.0),
                        child: Wrap(
                          spacing: 8.0,
                          children: widget.post.hashtags.map((hashtag) {
                            return Text(
                              '#$hashtag',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              buildUser(context),
            ],
          );
        },
      ),
    );
  }

  buildLikeButton() {
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
            size: 25.0,
            circleColor: const CircleColor(start: Color(0xffFFC0CB), end: Color(0xffff0000)),
            bubblesColor: const BubblesColor(
                dotPrimaryColor: Color(0xffFFA500),
                dotSecondaryColor: Color(0xffd8392b),
                dotThirdColor: Color(0xffFF69B4),
                dotLastColor: Color(0xffff8c00)),
            likeBuilder: (bool isLiked) {
              return Icon(
                docs.isEmpty ? Ionicons.heart_outline : Ionicons.heart,
                color: docs.isEmpty
                    ? Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black
                    : Colors.red,
                size: 25,
              );
            },
          );
        }
        return Container();
      },
    );
  }

  addLikesToNotification() async {
    bool isNotMe = currentUserId() != widget.post.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      services.addLikesToNotification(
        "like",
        user.username!,
        currentUserId(),
        widget.post.postId,
        widget.post.mediaUrls[0],
        widget.post.ownerId,
        user.photoUrl!,
      );
    }
  }

  buildLikesCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(left: 7.0),
      child: Text(
        '$count likes',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10.0,
        ),
      ),
    );
  }

  buildCommentsCount(BuildContext context, int count) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.5),
      child: Text(
        '$count comments',
        style: const TextStyle(fontSize: 8.5, fontWeight: FontWeight.bold),
      ),
    );
  }

  buildUser(BuildContext context) {
    bool isMe = currentUserId() == widget.post.ownerId;
    return StreamBuilder(
      stream: usersRef.doc(widget.post.ownerId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot snap = snapshot.data!;
          UserModel user = UserModel.fromJson(snap.data() as Map<String, dynamic>);
          return Visibility(
            visible: !isMe,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50.0,
                decoration: const BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: GestureDetector(
                  onTap: () => showProfile(context, profileId: user.id!),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        user.photoUrl!.isEmpty
                            ? CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Theme.of(context).colorScheme.secondary,
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
                                radius: 20.0,
                                backgroundImage: CachedNetworkImageProvider(
                                  '${user.photoUrl}',
                                ),
                              ),
                        const SizedBox(width: 5.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username!, // Use the username from the fetched user data
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.post.location ?? 'Tatoo Connect',
                              style: const TextStyle(
                                fontSize: 10.0,
                                color: Color(0xff4D4D4D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  showProfile(BuildContext context, {String? profileId}) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => Profile(profileId: profileId!),
      ),
    );
  }
}
