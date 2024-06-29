import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:social_media_app/core/utils/firebase.dart'; // Assuming you have a file with Firestore references
import 'package:social_media_app/data/models/comments.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:social_media_app/data/models/user.dart';
import 'package:social_media_app/domain/services/post_service.dart';
import 'package:social_media_app/presentation/components/stream_comments_wrapper.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media_app/presentation/screens/view_image.dart'; // Adjust the path if necessary

class CommentsScreen extends StatefulWidget {
  final PostModel post;

  const CommentsScreen({Key? key, required this.post}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  UserModel? user;
  final PostService services = PostService();
  final TextEditingController commentsTEC = TextEditingController();

  String currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        title: const Text('Comments'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildPostHeader(context),
                  const Divider(thickness: 1.5),
                  buildCommentsList(),
                ],
              ),
            ),
          ),
          buildCommentInput(context),
        ],
      ),
    );
  }

  Widget buildPostHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://via.placeholder.com/50'), // Replace with actual user image
              ),
              const SizedBox(width: 10),
              Text(
                widget.post.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Post image
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (_) => ViewImage(
                  mediaUrl: widget.post.mediaUrls[0],
                  post: widget.post,
                ),
              ));
            },
            child: CachedNetworkImage(
              imageUrl: widget.post.mediaUrls[0],
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
          ),

          const SizedBox(height: 10),

          // Post description
          if (widget.post.description != null && widget.post.description!.isNotEmpty) Text(widget.post.description!),

          const SizedBox(height: 10),

          // Likes and timestamp
          Row(
            children: [
              buildLikeButton(),
              const SizedBox(width: 10),
              Text(
                timeago.format(widget.post.timestamp.toDate()),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCommentsList() {
    return CommentsStreamWrapper(
      shrinkWrap: true,
      stream:
          commentRef.doc(widget.post.postId).collection('comments').orderBy('timestamp', descending: true).snapshots(),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, DocumentSnapshot snapshot) {
        CommentModel comment = CommentModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return buildCommentItem(comment);
      },
    );
  }

  Widget buildCommentItem(CommentModel comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: CachedNetworkImageProvider(comment.userDp!),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.username!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(comment.comment!),
                const SizedBox(height: 5),
                Text(
                  timeago.format(comment.timestamp!.toDate()),
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentsTEC,
              decoration: const InputDecoration(
                hintText: 'Add a comment...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await services.uploadComment(
                currentUserId(),
                commentsTEC.text,
                widget.post.postId,
                widget.post.ownerId,
                widget.post.mediaUrls[0],
              );
              commentsTEC.clear();
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

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
              removeLikeFromNotification();
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
                color: docs.isEmpty ? Colors.grey : Colors.red,
                size: 25,
              );
            },
          );
        }
        return Container();
      },
    );
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

  addLikesToNotification() async {
    bool isNotMe = currentUserId() != widget.post.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notificationRef.doc(widget.post.ownerId).collection('notifications').doc(widget.post.postId).set({
        "type": "like",
        "username": user!.username!,
        "userId": currentUserId(),
        "userDp": user!.photoUrl!,
        "postId": widget.post.postId,
        "mediaUrl": widget.post.mediaUrls[0], // Pass the first image URL
        "timestamp": Timestamp.now(),
      });
    }
  }

  removeLikeFromNotification() {
    bool isNotMe = currentUserId() != widget.post.ownerId;

    if (isNotMe) {
      notificationRef.doc(widget.post.ownerId).collection('notifications').doc(widget.post.postId).get().then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    }
  }
}
