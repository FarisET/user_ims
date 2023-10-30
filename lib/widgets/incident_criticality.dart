import 'package:flutter/material.dart';

class SelectableContainer extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelect;

  const SelectableContainer({super.key, 
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  _SelectableContainerState createState() => _SelectableContainerState();
}

class _SelectableContainerState extends State<SelectableContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onSelect(!widget.isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.blue[400] : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue[400]!,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 18,
              color: widget.isSelected ? Colors.white : Colors.blue[400],
            ),
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int selectedContainer = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableContainer(
          label: 'Minor 1',
          isSelected: selectedContainer == 1,
          onSelect: (isSelected) {
            setState(() {
              selectedContainer = isSelected ? 1 : -1;
            });
          },
        ),
        SelectableContainer(
          label: 'Minor 2',
          isSelected: selectedContainer == 2,
          onSelect: (isSelected) {
            setState(() {
              selectedContainer = isSelected ? 2 : -1;
            });
          },
        ),
        SelectableContainer(
          label: 'Minor 3',
          isSelected: selectedContainer == 3,
          onSelect: (isSelected) {
            setState(() {
              selectedContainer = isSelected ? 3 : -1;
            });
          },
        ),
      ],
    );
  }
}



