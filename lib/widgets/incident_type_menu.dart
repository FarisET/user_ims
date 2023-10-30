import 'package:flutter/material.dart';

class IncidentTypeMenu extends StatefulWidget {
  const IncidentTypeMenu({super.key});

  @override
  State<IncidentTypeMenu> createState() => _IncidentTypeMenuState();
}

class _IncidentTypeMenuState extends State<IncidentTypeMenu> {
    
    List<String> dropdownMenuEntries = ["Safety", "Security", "Code of Conduct Violation", "Maintenance"];


    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Icon(Icons.health_and_safety, color: Colors.blue),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  item,
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}