class SocialMediaLink {
  final String platform; // "instagram", "facebook", "tiktok"
  final String url;
  final String? username; // Optional username for display

  SocialMediaLink({
    required this.platform,
    required this.url,
    this.username,
  });

  factory SocialMediaLink.fromMapEntry(MapEntry<String, String> entry) {
    return SocialMediaLink(
      platform: entry.key,
      url: entry.value,
      username:
          null, // You might want to handle username extraction here if applicable
    );
  }

  String get displayName {
    switch (platform) {
      case 'instagram':
        return 'Instagram';
      case 'facebook':
        return 'Facebook';
      case 'tiktok':
        return 'TikTok';
      default:
        return platform;
    }
  }

  String get displayUrl {
    if (platform == 'instagram' && username != null) {
      return 'https://www.instagram.com/$username';
    } else {
      return url;
    }
  }

  @override
  String toString() {
    return 'SocialMediaLink{platform: $platform, url: $url, username: $username}';
  }

  // This method is used to create a SocialMediaLink object from a Map
  static SocialMediaLink fromMap(Map<String, dynamic> map) {
    return SocialMediaLink(
      platform: map['platform'] as String,
      url: map['url'] as String,
      username: map['username'] as String?,
    );
  }

  // This method is used to convert a SocialMediaLink object to a Map
  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
      'url': url,
      'username': username,
    };
  }

  // FromJson method to create a SocialMediaLink from a JSON map
  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      platform: json['platform'],
      url: json['url'],
      username: json['username'],
    );
  }

  // ToJson method to convert a SocialMediaLink to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'url': url,
      'username': username,
    };
  }
}
