import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/firebase.dart';
import 'package:social_media_app/data/models/notification.dart';
import 'package:social_media_app/presentation/pages/profile.dart';
import 'package:social_media_app/presentation/widgets/indicators.dart';
import 'package:social_media_app/presentation/widgets/view_notification_details.dart';
import 'package:timeago/timeago.dart' as timeago;

class ActivityItems extends StatefulWidget {
  final ActivityModel? activity;

  const ActivityItems({super.key, this.activity});

  @override
  _ActivityItemsState createState() => _ActivityItemsState();
}

class _ActivityItemsState extends State<ActivityItems> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey("${widget.activity}"),
      background: stackBehindDismiss(),
      direction: DismissDirection.endToStart,
      onDismissed: (v) {
        delete();
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        onTap: () {
          if (widget.activity!.userId != null) {
            // Add null check for userId
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (_) => widget.activity!.type == "follow"
                    ? Profile(profileId: widget.activity!.userId!) // Now safe to use !
                    : ViewActivityDetails(activity: widget.activity!),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("User information is not available."),
              ),
            );
          }
        },
        leading: widget.activity!.userDp!.isEmpty
            ? CircleAvatar(
                radius: 20.0,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                child: Center(
                  child: Text(
                    widget.activity!.username![0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : CircleAvatar(
                radius: 20.0,
                backgroundImage: CachedNetworkImageProvider(
                  widget.activity!.userDp!,
                ),
              ),
        title: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14.0,
            ),
            children: [
              TextSpan(
                text: '${widget.activity!.username!} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
              TextSpan(
                text: buildTextConfiguration(),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(
          timeago.format(widget.activity!.timestamp!.toDate()),
        ),
        trailing: previewConfiguration(),
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: Theme.of(context).colorScheme.secondary,
      child: const Icon(
        CupertinoIcons.delete,
        color: Colors.white,
      ),
    );
  }

  delete() {
    notificationRef
        .doc(firebaseAuth.currentUser!.uid)
        .collection('notifications')
        .doc(widget.activity!.postId)
        .get()
        .then((doc) => {
              if (doc.exists)
                {
                  doc.reference.delete(),
                }
            });
  }

  previewConfiguration() {
    if (widget.activity!.type == "like" || widget.activity!.type == "comment") {
      return buildPreviewImage();
    } else {
      return const Text('');
    }
  }

  buildTextConfiguration() {
    if (widget.activity!.type == "like") {
      return "liked your post";
    } else if (widget.activity!.type == "follow") {
      return "is following you";
    } else if (widget.activity!.type == "comment") {
      return "commented '${widget.activity!.commentData}'";
    } else {
      return "Error: Unknown type '${widget.activity!.type}'";
    }
  }

  buildPreviewImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5.0),
      child: CachedNetworkImage(
        imageUrl: widget.activity!.mediaUrl!,
        placeholder: (context, url) {
          return circularProgress(context);
        },
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
        height: 40.0,
        fit: BoxFit.cover,
        width: 40.0,
      ),
    );
  }
}
