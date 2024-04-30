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
      type = MessageType.TEXT;
    } else if (json['type'] == 'image') {
      type = MessageType.IMAGE;
    } else if (json['type'] == 'video') {
      type = MessageType.VIDEO;
    } else if (json['type'] == 'audio') {
      type = MessageType.AUDIO;
    }
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['caption'] = caption;
    data['statusId'] = statusId;
    data['viewers'] = viewers;
    data['url'] = url;
    if (type == MessageType.TEXT) {
      data['type'] = 'text';
    } else if (type == MessageType.VIDEO) {
      data['type'] = 'image';
    } else if (type == MessageType.VIDEO) {
      data['type'] = 'video';
    } else if (type == MessageType.AUDIO) {
      data['type'] = 'audio';
    }
    data['time'] = time;
    return data;
  }
}
