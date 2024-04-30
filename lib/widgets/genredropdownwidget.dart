import 'package:flutter/material.dart';
import 'package:social_media_app/models/enum/gender_type.dart';

class GenreDDWidget extends StatefulWidget {
  final Function(GenderType) onItemChange;
  final GenderType initial;

  const GenreDDWidget(
      {Key? key, required this.onItemChange, required this.initial})
      : super(key: key);

  @override
  _GenreDDWidgetState createState() => _GenreDDWidgetState(initial);
}

class _GenreDDWidgetState extends State<GenreDDWidget> {
  GenderType dropdownValue;

  _GenreDDWidgetState(this.dropdownValue);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<GenderType>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      hint: const Text('Choose your gender'),
      style: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      isExpanded: true,
      onChanged: (value) {
        setState(() => dropdownValue = value!);
        widget.onItemChange(value!);
      },
      items: GenderType.values
          .map(
            (value) => DropdownMenuItem(
              value: value,
              child: Text(value.name),
            ),
          )
          .toList(),
    );
  }
}
