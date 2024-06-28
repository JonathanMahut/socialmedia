import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/data/models/enum/event_type.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String location;
  final String organizerId;
  final EventType eventType;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> participantIds;
  final List<String> invitedUserIds;
  final List<String> productIds;
  final List<String> tattooArtistIds;
  final bool isPublished;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String visibility;
  final String eventCategory;
  final double? registrationFee;
  final String? paymentStatus;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.location,
    required this.organizerId,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    this.participantIds = const [],
    this.invitedUserIds = const [],
    this.productIds = const [],
    this.tattooArtistIds = const [],
    this.isPublished = false,
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
    required this.visibility,
    required this.eventCategory,
    this.registrationFee,
    this.paymentStatus,
  })  : assert(title.isNotEmpty),
        assert(description.isNotEmpty),
        assert(location.isNotEmpty),
        assert(endDate.isAfter(startDate));

  EventModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        imageUrl = json['imageUrl'],
        location = json['location'],
        organizerId = json['organizerId'],
        eventType = _eventTypeFromString(json['eventType']),
        startDate = (json['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
        endDate = (json['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
        participantIds = List<String>.from(json['participants'] ?? []),
        invitedUserIds = List<String>.from(json['invitedUsers'] ?? []),
        productIds = List<String>.from(json['products'] ?? []),
        tattooArtistIds = List<String>.from(json['tattooArtists'] ?? []),
        isPublished = json['isPublished'] ?? false,
        isCompleted = json['isCompleted'] ?? false,
        createdAt = (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        updatedAt = (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        visibility = json['visibility'] ?? 'public', // Provide default visibility
        eventCategory = json['eventCategory'] ?? 'other', // Provide default category
        registrationFee = json['registrationFee']?.toDouble(),
        paymentStatus = json['paymentStatus'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['location'] = location;
    data['organizerId'] = organizerId;
    data['eventType'] = eventType.name;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['participants'] = participantIds;
    data['invitedUsers'] = invitedUserIds;
    data['products'] = productIds;
    data['tattooArtists'] = tattooArtistIds;
    data['isPublished'] = isPublished;
    data['isCompleted'] = isCompleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['visibility'] = visibility;
    data['eventCategory'] = eventCategory;
    data['registrationFee'] = registrationFee;
    data['paymentStatus'] = paymentStatus;
    return data;
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? location,
    String? organizerId,
    EventType? eventType,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? participantIds,
    List<String>? invitedUserIds,
    List<String>? productIds,
    List<String>? tattooArtistIds,
    bool? isPublished,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? visibility,
    String? eventCategory,
    double? registrationFee,
    String? paymentStatus,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      organizerId: organizerId ?? this.organizerId,
      eventType: eventType ?? this.eventType,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      participantIds: participantIds ?? this.participantIds,
      invitedUserIds: invitedUserIds ?? this.invitedUserIds,
      productIds: productIds ?? this.productIds,
      tattooArtistIds: tattooArtistIds ?? this.tattooArtistIds,
      isPublished: isPublished ?? this.isPublished,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      visibility: visibility ?? this.visibility,
      eventCategory: eventCategory ?? this.eventCategory,
      registrationFee: registrationFee ?? this.registrationFee,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  // Helper method to convert string to EventType (updated to throw exception)
  static EventType _eventTypeFromString(String? eventTypeString) {
    if (eventTypeString != null) {
      try {
        return EventType.values.byName(eventTypeString);
      } catch (e) {
        throw ArgumentError('Invalid EventType: $eventTypeString');
      }
    }
    return EventType.tattooConvention; // Default value
  }
}
