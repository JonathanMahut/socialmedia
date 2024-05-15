import 'package:flutter/material.dart';
import 'package:social_media_app/models/enum/user_type.dart';

class UserTypeDDWidget extends StatefulWidget {
  final Function(UserType) onItemChange;
  final UserType initial;

  const UserTypeDDWidget(
      {Key? key, required this.onItemChange, required this.initial})
      : super(key: key);

  @override
  _UserTypeDDWidgetState createState() => _UserTypeDDWidgetState(initial);
}

class _UserTypeDDWidgetState extends State<UserTypeDDWidget> {
  UserType dropdownValue;

  _UserTypeDDWidgetState(this.dropdownValue);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<UserType>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      hint: const Text('How are you ?'),
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
      items: UserType.values
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
