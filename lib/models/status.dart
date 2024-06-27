import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/message_type.dart';

class StatusModel {
  String? caption;
  String? url;
  String? status;
  String? statusId;
  MessageType? type;
  List<dynamic>? viewers;
  Timestamp? time;

  StatusModel(
      {this.caption,
      this.url,
      this.statusId,
      this.time,
      this.type,
      this.viewers});

  StatusModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    caption = json['caption'];
    statusId = json['statusId'];
    viewers = json['viewers'];
    if (json['type'] == 'text') {
      type = MessageType.text;
    } else if (json['type'] == 'image') {
      type = MessageType.image;
    } else if (json['type'] == 'video') {
      type = MessageType.video;
    } else if (json['type'] == 'audio') {
      type = MessageType.audio;
    }
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caption'] = caption;
    data['statusId'] = statusId;
    data['viewers'] = viewers;
    data['url'] = url;
    if (type == MessageType.text) {
      data['type'] = 'text';
    } else if (type == MessageType.image) {
      data['type'] = 'image';
    } else if (type == MessageType.video) {
      data['type'] = 'video';
    } else if (type == MessageType.audio) {
      data['type'] = 'audio';
    }
    data['time'] = time;
    return data;
  }
}
