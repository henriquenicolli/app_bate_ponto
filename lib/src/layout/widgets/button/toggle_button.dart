import 'package:flutter/material.dart';
import 'package:flutter_app_bate_ponto/src/configuration/app_layout_defaults.dart';

class CustomToggleButtons extends StatelessWidget {
  final ValueChanged<int> onToggle;
  final ValueNotifier<int> selectedButtonIndex;

  const CustomToggleButtons({Key? key, required this.onToggle, required this.selectedButtonIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ToggleButtons(
      title: 'Ponto eletrônico',
      onToggle: onToggle,
      selectedButtonIndex: selectedButtonIndex,
    );
  }
}

class _ToggleButtons extends StatefulWidget {
  final ValueChanged<int> onToggle;
  final ValueNotifier<int> selectedButtonIndex;

  const _ToggleButtons({Key? key, required this.title, required this.onToggle, required this.selectedButtonIndex})
      : super(key: key);

  final String title;

  @override
  State<_ToggleButtons> createState() => _ToggleButtonsState();
}

class _ToggleButtonsState extends State<_ToggleButtons> {
  final List<bool> _selectedState = <bool>[false, true];

  List<bool> getSelectedState() {
    return List<bool>.generate(_selectedState.length, (index) => index == widget.selectedButtonIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  widget.selectedButtonIndex.value = index;
                });
                widget.selectedButtonIndex.value = index;
                widget.onToggle(index);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: AppLayoutDefaults.secondaryColor,
              selectedColor: AppLayoutDefaults.backgroundColor,
              fillColor: AppLayoutDefaults.secondaryColor,
              color: AppLayoutDefaults.secondaryColor,
              isSelected: getSelectedState(),
              children: texts,
            )
          ],
        ),
      ),
    );
  }
}

const List<Widget> texts = <Widget>[
  Padding(
    padding: EdgeInsets.all(10.0),
    child: Text('Ponto de ontem'),
  ),
  Padding(
    padding: EdgeInsets.all(10.0),
    child: Text('Ponto de hoje'),
  ),
];
