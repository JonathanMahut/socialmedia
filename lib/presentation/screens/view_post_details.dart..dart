import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post.dart';

class ViewPostDetails extends StatelessWidget {
  final PostModel post;

  const ViewPostDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: Center(
        // Replace with your desired layout
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Post ID: ${post.postId}'),
            // Add more widgets to display post details as needed
          ],
        ),
      ),
    );
  }
}
