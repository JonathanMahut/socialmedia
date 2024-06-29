import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:social_media_app/presentation/screens/view_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago; // For timestamp formatting

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('https://via.placeholder.com/50'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (post.location != null)
                      Text(
                        post.location!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Handle more options (e.g., report, hide, etc.)
                  },
                  icon: const Icon(Icons.more_horiz),
                ),
              ],
            ),
          ),

          // Image/Video Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: post.mediaUrls.length > 1,
              onPageChanged: (index, reason) {
                // Handle page changes if needed
              },
            ),
            items: post.mediaUrls.asMap().entries.map((entry) {
              int index = entry.key;
              String mediaUrl = entry.value;
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (_) => ViewImage(
                          mediaUrl: mediaUrl,
                          post: post,
                        ),
                      ));
                    },
                    child: CachedNetworkImage(
                      imageUrl: mediaUrl,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),

          // Post details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Likes, comments, share icons (implement functionality)
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle like action
                      },
                      icon: const Icon(Icons.favorite_border),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle comment action
                      },
                      icon: const Icon(Icons.chat_bubble_outline),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle share action
                      },
                      icon: const Icon(Icons.send),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        // Handle save action
                      },
                      icon: const Icon(Icons.bookmark_border),
                    ),
                  ],
                ),

                // Likes count (fetch and display actual count)
                const Text(
                  '123 likes', // Replace with actual likes count
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                // Description
                if (post.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(post.description!),
                  ),

                // Hashtags
                if (post.hashtags.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Wrap(
                      spacing: 8,
                      children: post.hashtags.map((hashtag) {
                        return Text(
                          '#$hashtag',
                          style: TextStyle(color: Colors.blue),
                        );
                      }).toList(),
                    ),
                  ),

                // Timestamp (formatted)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    timeago.format(post.timestamp.toDate()), // Formatted timestamp
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
