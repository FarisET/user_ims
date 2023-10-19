// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:user_ims/widgets/incident_menu.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();

  
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  //select for risk level

  int selectedChipIndex = -1;
  List<bool> isSelected = [false, false, false];
  List<String> chipLabels = ['Minor', 'Serious', 'Critical'];

  Color? _getSelectedColor(int index) {
      if (isSelected[index]) {
        if (index == 0) {
          return Colors.greenAccent;
        } else if (index == 1) {
          return Colors.orangeAccent;
        } else if (index == 2) {
          return Colors.redAccent;
        }
      }
      return null;
    }  

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  //final String title='';
  final String incidentType='';
  final int id=0;
  String location = '';
  String description = '';
  DateTime date = DateTime.now();
  bool? status = false;
  String risklevel='';

  //TODO: attach image var
  //TODO: incident tpye var
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report an Incident'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key:_formKey,
          child: SafeArea(

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
             //     IncidentMenu(),

                   Padding(
                    padding: const EdgeInsets.only(bottom:30.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Location',
                        hintText: 'Name the location, area or site',
                        prefixIcon: Icon(Icons.location_pin,color: Colors.blue),
                        fillColor: Colors.blue,
                         labelStyle: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal), // Color of the label text
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue), // Color of the border when not focused
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green), // Color of the border when focused
                          borderRadius: BorderRadius.circular(10.0),
                          
                        ),
                      
                        
                      ),
                      validator: (value) {
                        if (value != null || value!.isEmpty) {
                          return 'Enter Something';
                        } return null;
                      },
                      onChanged: (value) {
                        location = value;
                      },
                        
                    ),
                  ),

                  
                      
                //TODO:Incident Type

                Padding(
                  padding: const EdgeInsets.only(bottom:20.0),
                  child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Describe the incident in a few words',
                          prefixIcon: Icon(Icons.description,color: Colors.blue),
                          fillColor: Colors.blue,
                           labelStyle: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.normal), // Color of the label text
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue), // Color of the border when not focused
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green), // Color of the border when focused
                            borderRadius: BorderRadius.circular(10.0),
                            
                          ),
                        
                          
                        ),
                        validator: (value) {
                          if (value != null || value!.isEmpty) {
                            return 'Enter Something';
                          } return null;
                        },
                        onChanged: (value) {
                          description = value;
                        },
                        maxLines: 5,
                      ),
                ),

                  
                      
              _FormDatePicker(
                  date: date,
                  onChanged: (value) {
                    setState(() {
                      date = value;
                    });
                  },
                ),

             SizedBox(
              height: 20,
             ),

            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //  ChoiceChip(
            //   label: Text('Minor'), 
            //   selected: isSelected1,
            //   selectedColor: Colors.greenAccent,
            //   onSelected: (newState){
            //     setState(() {
            //       if (!isSelected2 && !isSelected3) {
            //       isSelected1 = newState;
            //       }
            //     });
            //   }),

            //   ChoiceChip(
            //   label: Text('Serious'), 
            //   selected: isSelected2,
            //   selectedColor: Colors.orangeAccent,
            //   onSelected: (newState){
            //     setState(() {
            //       if (!isSelected1 && !isSelected3) {
            //       isSelected2 = newState;
            //       }
            //     });
            //   }),
            //                ChoiceChip(
            //   label: Text('Critical'), 
            //   selected: isSelected3,
            //   selectedColor: Colors.redAccent,
            //   onSelected: (newState){
            //     setState(() {
            //       if (!isSelected2 && !isSelected1) {
            //       isSelected3 = newState;
            //       }
            //     });
            //   })


            //   ]),
              Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(chipLabels.length, (index) {
          return ChoiceChip(
            disabledColor: Colors.blue,
            label: Text(chipLabels[index]),
            selected: isSelected[index],
            selectedColor: _getSelectedColor(index),
            onSelected: (isSelected) {
              setState(() {
                for (int i = 0; i < this.isSelected.length; i++) {
                  this.isSelected[i] = i == index ? isSelected : false;
                }
              });
            },
          );
        }),
      ),
      SizedBox(height: 20,),
      SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: ElevatedButton(
           style: FilledButton.styleFrom(
           backgroundColor: Colors.blue[400],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
              ),

                  ), 

          
          onPressed: (){
            if(_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Report Submitted'))
              );
            }
          }, child: Text('Submit')),
      )

                
              ],),
            ),
          )
             ),
      ),

    );
  }
}

class _FormDatePicker extends StatefulWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  const _FormDatePicker({
    required this.date,
    required this.onChanged,
  });

  @override
  State<_FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<_FormDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Container(
             decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(12) 
                  ),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                       Text(
                          'Date: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),
                    
                  Text(
                    intl.DateFormat.yMd().format(widget.date),
                    style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                    
                    
                  ),

                  Text(', Time: ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
                        ),

                    
                  Text(
                    intl.DateFormat.Hm().format(widget.date),
                    style: TextStyle(
                            fontSize: 16,
                            color: Colors.white
                          ),
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

            // Don't change the date if the date picker returns null.
            if (newDateTime == null) {
              return;
            }

             // Show time picker
            final newTimeOfDay = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(widget.date),
            );

            if (newTimeOfDay == null) {
              return;
            }

            // Combine the selected date and time into a new DateTime
            final combinedDateTime = DateTime(
              newDateTime.year,
              newDateTime.month,
              newDateTime.day,
              newTimeOfDay.hour,
              newTimeOfDay.minute,
            );

            widget.onChanged(combinedDateTime);

           // widget.onChanged(newDate);
          },
        )
      ],
    );

  }
}

// class RiskLevel extends StatefulWidget {
//   const RiskLevel({Key? key}) : super(key: key);

//   @override
//   _RiskLevelState createState() => _RiskLevelState();
// }

// class _RiskLevelState extends State<RiskLevel> {
//   String? _selectedRiskLevel;

//   @override
//   Widget build(BuildContext context) {
//         return ListView(
//           children: [
//             RadioListTile<String>(
//               title: const Text('Minor'),
//               value: 'Minor',
//               groupValue: _selectedRiskLevel,
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedRiskLevel = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Serious'),
//               value: 'Serious',
//               groupValue: _selectedRiskLevel,
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedRiskLevel = value;
//                 });
//               },
//             ),
//             RadioListTile<String>(
//               title: const Text('Fatal'),
//               value: 'Fatal',
//               groupValue: _selectedRiskLevel,
//               onChanged: (String? value) {
//                 setState(() {
//                   _selectedRiskLevel = value;
//                 });
//               },
//             ),
//           ],
//         );
       
    
//   }
// }

