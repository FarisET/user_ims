import 'package:flutter/material.dart';

class DropdownMenuItemUtil {
  static DropdownMenuItem<String> buildDropdownMenuItem<T>(
    T item,
    String value,
    String description,
  ) {
    return DropdownMenuItem<String>(
      value: value,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                description,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}