import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/models/enum/message_type.dart';

class Message {
  String? content;
  String? senderUid;
  String? messageId;
  MessageType? type;
  Timestamp? time;

  Message({this.content, this.senderUid, this.messageId, this.type, this.time});

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderUid = json['senderUid'];
    messageId = json['messageId'];
    if (json['type'] == 'text') {
      type = MessageType.text;
    } else {
      type = MessageType.image;
    }
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['senderUid'] = senderUid;
    data['messageId'] = messageId;
    if (type == MessageType.text) {
      data['type'] = 'text';
    } else {
      data['type'] = 'image';
    }
    data['time'] = time;
    return data;
  }
}
