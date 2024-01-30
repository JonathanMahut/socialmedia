import 'package:cloud_firestore/cloud_firestore.dart';

class FlashModel {
  String? id;
  String? postId;
  String? ownerId;
  String? username;
  String? location;
  String? description;
  String? mediaUrl;
  bool? isFlashDispo;
  Timestamp? timestamp;
  String? city;
  String? ownerEmail;
  String? ownerPhone;

  FlashModel(
      {this.id,
      this.postId,
      this.ownerId,
      this.location,
      this.description,
      this.mediaUrl,
      this.username,
      this.timestamp,
      this.isFlashDispo,
      this.city,
      this.ownerEmail,
      this.ownerPhone});
  FlashModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['postId'];
    ownerId = json['ownerId'];
    location = json['location'];
    username = json['username'];
    description = json['description'];
    mediaUrl = json['mediaUrl'];
    isFlashDispo = json['isFlashDispo'];
    timestamp = json['timestamp'];
    city = json['city'];
    ownerEmail = json['ownerEmail'];
    ownerPhone = json['ownerPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['postId'] = this.postId;
    data['ownerId'] = this.ownerId;
    data['location'] = this.location;
    data['description'] = this.description;
    data['mediaUrl'] = this.mediaUrl;
    data['isFlashDispo'] = this.isFlashDispo;
    data['timestamp'] = this.timestamp;
    data['username'] = this.username;
    data['city'] = this.city;
    data['ownerEmail'] = this.ownerEmail;
    data['ownerPhone'] = this.ownerPhone;
    return data;
  }
}
