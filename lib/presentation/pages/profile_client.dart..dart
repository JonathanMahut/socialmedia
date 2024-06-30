import 'package:flutter/material.dart';

class ProfileClient extends StatefulWidget {
  final String profileId;

  const ProfileClient({super.key, required this.profileId});

  @override
  _ProfileClientState createState() => _ProfileClientState();
}

class _ProfileClientState extends State<ProfileClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Profile'),
      ),
      body: Center(
        child: Text('Profile of client with ID: ${widget.profileId}'),
      ),
    );
  }
}
