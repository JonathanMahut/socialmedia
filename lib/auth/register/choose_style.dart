import 'package:flutter/material.dart';
import 'package:social_media_app/models/enum/tatoo_style.dart';

class TatooSelectionPage extends StatefulWidget {
  const TatooSelectionPage({super.key});

  @override
  _TatooSelectionPageState createState() => _TatooSelectionPageState();
}

class _TatooSelectionPageState extends State<TatooSelectionPage> {
  List<TattooArtistSpecialty> selectedTatooStyles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Tatoo Styles'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: TattooArtistSpecialty.values.map((style) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (selectedTatooStyles.contains(style)) {
                    selectedTatooStyles.remove(style);
                  } else {
                    selectedTatooStyles.add(style);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedTatooStyles.contains(style)
                    ? Colors.blue
                    : Colors.grey,
              ),
              child: Text(style.toString().split('.').last),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Valider'),
        ),
      ),
    );
  }
}
