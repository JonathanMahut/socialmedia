import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:social_media_app/data/models/notification.dart';
import 'package:social_media_app/presentation/pages/profile.dart';
import 'package:social_media_app/presentation/widgets/indicators.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewActivityDetails extends StatefulWidget {
  final ActivityModel? activity;

  const ViewActivityDetails({super.key, this.activity});

  @override
  _ViewActivityDetailsState createState() => _ViewActivityDetailsState();
}

class _ViewActivityDetailsState extends State<ViewActivityDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.keyboard_backspace),
        ),
      ),
      body: ListView(
        children: [
          buildImage(context),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            leading: GestureDetector(
              onTap: () {
                if (widget.activity!.userId != null) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => Profile(profileId: widget.activity!.userId!), // Now it's safe
                      ));
                } else {
                  // Handle the case where userId is null, maybe show a snackbar or log an error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("User information is not available."),
                    ),
                  );
                }
              },
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(widget.activity!.userDp!),
              ),
            ),
            title: Text(
              widget.activity!.username!,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            subtitle: Row(
              children: [
                const Icon(Ionicons.alarm_outline, size: 13.0),
                const SizedBox(width: 3.0),
                Text(
                  timeago.format(widget.activity!.timestamp!.toDate()),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              widget.activity?.commentData ?? "",
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: CachedNetworkImage(
          imageUrl: widget.activity!.mediaUrl!,
          placeholder: (context, url) {
            return circularProgress(context);
          },
          errorWidget: (context, url, error) {
            return const Icon(Icons.error);
          },
          height: 400.0,
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
