import 'package:flutter/material.dart';

class MesSelector extends StatefulWidget {
  const MesSelector({super.key});

  @override
  _MesSelectorState createState() => _MesSelectorState();
}

class _MesSelectorState extends State<MesSelector> {
  String selectedValue = 'Janeiro';
  List<String> options = ['Janeiro', 'Fevereiro', 'Marco', 'Abril'];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 50,
      child: DropdownButton<String>(
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: options.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
