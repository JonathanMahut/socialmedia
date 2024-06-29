import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/data/models/comments.dart';

class PostModel {
  final String id;
  final String postId;
  final String ownerId;
  final String username;
  final String? location;
  final String? description;
  final List<String> mediaUrls; // Support for multiple images/videos
  final bool isFlashDispo;
  final Timestamp timestamp;
  final int likesCount;
  final List<String> likedBy; // Users who liked the post
  final List<CommentModel> comments; // Nested comments
  final String? postType; // To differentiate between text, polls, etc.
  final List<String> hashtags; // For discoverability

  PostModel({
    required this.id,
    required this.postId,
    required this.ownerId,
    required this.username,
    this.location,
    this.description,
    required this.mediaUrls,
    required this.isFlashDispo,
    required this.timestamp,
    this.likesCount = 0,
    this.likedBy = const [],
    this.comments = const [],
    this.postType,
    this.hashtags = const [],
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      postId: json['postId'] as String,
      ownerId: json['ownerId'] as String,
      username: json['username'] as String,
      location: json['location'] as String?,
      description: json['description'] as String?,
      mediaUrls: (json['mediaUrls'] as List?)?.cast<String>() ?? [],
      isFlashDispo: json['isFlashDispo'] as bool? ?? false,
      timestamp: json['timestamp'] as Timestamp,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      likedBy: (json['likedBy'] as List?)?.cast<String>() ?? [],
      comments: (json['comments'] as List?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      postType: json['postType'] as String?,
      hashtags: (json['hashtags'] as List?)?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'ownerId': ownerId,
      'username': username,
      'location': location,
      'description': description,
      'mediaUrls': mediaUrls,
      'isFlashDispo': isFlashDispo,
      'timestamp': timestamp,
      'likesCount': likesCount,
      'likedBy': likedBy,
      'comments': comments.map((e) => e.toJson()).toList(),
      'postType': postType,
      'hashtags': hashtags,
    };
  }
}
/*
// Model for comments (you'll need to create this class)
class CommentModel {
  final String commentId;
  final String userId;
  final String username;
  final String commentText;
  final Timestamp timestamp;

  CommentModel({
    required this.commentId,
    required this.userId,
    required this.username,
    required this.commentText,
    required this.timestamp,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'] as String,
      userId: json['userId'] as String,
      username: json['username'] as String,
      commentText: json['commentText'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'userId': userId,
      'username': username,
      'commentText': commentText,
      'timestamp': timestamp,
    };
  }
}
*/
