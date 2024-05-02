import 'package:cloud_firestore/cloud_firestore.dart';

class FlashModel {
  String? id;
  String? postId; //post de l'artiste
  String? ownerId; //id de l'artiste'
  String? username; // nom de l'artiste
  String? location; //location de l'artiste
  String? description; //description du flash
  String? mediaUrl; //Image du flash
  bool? isFlashDispo; //est-il dispo
  Timestamp? timestamp;
  String? city;
  String? ownerEmail;
  String? ownerPhone;
  String? profilPic;
  int? nbLikes;

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
      this.ownerPhone,
      this.nbLikes,
      this.profilPic});
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
    profilPic = json['profilPic'];
    nbLikes = int.parse(json['nbLikes']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['postId'] = postId;
    data['ownerId'] = ownerId;
    data['location'] = location;
    data['description'] = description;
    data['mediaUrl'] = mediaUrl;
    data['isFlashDispo'] = isFlashDispo;
    data['timestamp'] = timestamp;
    data['username'] = username;
    data['city'] = city;
    data['ownerEmail'] = ownerEmail;
    data['ownerPhone'] = ownerPhone;
    data['profilPic'] = profilPic;
    data['nbLikes'] = nbLikes;
    return data;
  }
}
