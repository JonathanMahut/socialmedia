import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/data/models/post.dart';
import 'package:social_media_app/presentation/screens/view_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;

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
          // User info (using ListTile for better structure)
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://via.placeholder.com/50'),
            ),
            title: Text(
              post.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: post.location != null
                ? Text(
                    post.location!,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  )
                : null,
            trailing: IconButton(
              onPressed: () {
                // Handle more options
              },
              icon: const Icon(Icons.more_horiz),
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
                // Handle page changes
              },
            ),
            items: post.mediaUrls.map((mediaUrl) {
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
                // Likes, comments, share icons (using Row with Expanded for responsiveness)
                Row(
                  children: [
                    Expanded(
                      child: Row(
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
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle save action
                      },
                      icon: const Icon(Icons.bookmark_border),
                    ),
                  ],
                ),

                // Likes count
                const Text(
                  '123 likes', // Replace with actual likes count
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                // Description (using Expanded to prevent overflow)
                if (post.description != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      // <-- Use a Row to wrap the Text widget
                      children: [
                        Expanded(
                          // <-- Now Expanded is a direct child of Row
                          child: Text(
                            post.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Hashtags (using Wrap to handle overflow)
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

                // Timestamp
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    timeago.format(post.timestamp.toDate()),
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
