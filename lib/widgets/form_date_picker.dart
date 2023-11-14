import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Date: ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    intl.DateFormat.yMd().format(widget.date),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    ', Time: ',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    intl.DateFormat.Hm().format(widget.date),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        TextButton(
          child: const Text('Edit'),
          onPressed: () async {
            var newDateTime = await showDatePicker(
              context: context,
              initialDate: widget.date,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );

            if (newDateTime == null) {
              return;
            }

            final newTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(widget.date),
            );

            if (newTimeOfDay == null) {
              return;
            }

            final combinedDateTime = DateTime(
              newDateTime.year,
              newDateTime.month,
              newDateTime.day,
              newTimeOfDay.hour,
              newTimeOfDay.minute,
            );

            widget.onChanged(combinedDateTime);
          },
        )
      ],
    );
  }
  }

