import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? username;
  String? comment;
  Timestamp? timestamp;
  String? userDp;
  String? userId;

  CommentModel({
    this.username,
    this.comment,
    this.timestamp,
    this.userDp,
    this.userId,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    comment = json['comment'];
    timestamp = json['timestamp'];
    userDp = json['userDp'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['comment'] = comment;
    data['timestamp'] = timestamp;
    data['userDp'] = userDp;
    data['userId'] = userId;
    return data;
  }

// FromMap constructor
  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      username: map['username'],
      comment: map['comment'],
      timestamp: map['timestamp'],
      userDp: map['userDp'],
      userId: map['userId'],
    );
  }

  // ToMap method
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'comment': comment,
      'timestamp': timestamp,
      'userDp': userDp,
      'userId': userId,
    };
  }
}
