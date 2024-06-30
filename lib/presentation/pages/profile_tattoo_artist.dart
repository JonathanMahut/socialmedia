import 'package:flutter/material.dart';

class ProfileTatooArtist extends StatefulWidget {
  final String profileId;

  const ProfileTatooArtist({super.key, required this.profileId});

  @override
  _ProfileTatooArtistState createState() => _ProfileTatooArtistState();
}

class _ProfileTatooArtistState extends State<ProfileTatooArtist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tattoo Artist Profile'),
      ),
      body: Center(
        child: Text('Profile of tattoo artist with ID: ${widget.profileId}'),
      ),
    );
  }
}
