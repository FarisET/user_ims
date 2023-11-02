// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;
import 'package:user_ims/models/%20sub_location.dart';
import 'package:user_ims/models/incident_types.dart';
import 'package:user_ims/models/location.dart';
import 'package:user_ims/models/user.dart';
import 'package:user_ims/providers/sub_location_provider.dart';
import 'package:user_ims/services/ReportServices.dart';
import 'package:provider/provider.dart';

import '../models/incident_sub_type.dart';
import '../providers/incident_subtype_provider.dart';
import '../providers/incident_type_provider.dart';
import '../models/report.dart';
import 'package:http/http.dart' as http;

import '../providers/location_provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  int selectedChipIndex = -1;
  List<bool> isSelected = [false, false, false];
  List<String> chipLabels = ['Minor', 'Serious', 'Critical'];
  List<String> chipLabelsid = ['CRT1', 'CRT2', 'CRT3'];
  String incidentType = '';
  String incidentSubType = '';
  List<String> dropdownMenuEntries = [];

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

  int id = 0; // auto-generated
  //String location = '';
  String description = '';
  DateTime date = DateTime.now();
  bool status = false; // how to update, initially false, will be changed by admin.
  String risklevel = '';
  File? selectedImage; // Declare selectedImage as nullable
  String title = "PPE Violation";
  String? SelectedIncidentType;
  String? SelectedLocationType;
  String SelectedSubLocationType='';

  DropdownMenuItem<String> buildMenuItem(IncidentType type) {
    return DropdownMenuItem<String>(
      value: type.Incident_Type_ID,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Icon(Icons.health_and_safety, color: Colors.blue),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                type.Incident_Type_Description,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildSubMenuItem(IncidentSubType type) {
    return DropdownMenuItem<String>(
      value: type.Incident_SubType_ID,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Icon(Icons.health_and_safety, color: Colors.blue),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                type.Incident_SubType_Description,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }


  DropdownMenuItem<String> buildLocationMenuItem(Location type) {
    return DropdownMenuItem<String>(
      value: type.Location_ID,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Icon(Icons.health_and_safety, color: Colors.blue),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                type.Location_Name,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

    DropdownMenuItem<String> buildSubLocationMenuItem(SubLocation type) {
    return DropdownMenuItem<String>(
      value: type.Sub_Location_ID,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Icon(Icons.health_and_safety, color: Colors.blue),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                type.Sub_Location_Name,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<IncidentProviderClass>(context, listen: false).getIncidentPostData();
      if (SelectedIncidentType != null) {
    Provider.of<SubIncidentProviderClass>(context, listen: false).getSubIncidentPostData(SelectedIncidentType!);
      }

      Provider.of<LocationProviderClass>(context, listen: false).getLocationPostData();
      if (SelectedIncidentType != null) {
    Provider.of<SubLocationProviderClass>(context, listen: false).getSubLocationPostData(SelectedLocationType!);
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report an Incident'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _pickImageFromCamera();
                                              },
                                              icon: Icon(Icons.camera),
                                              iconSize: 50,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _pickImageFromGallery();
                                              },
                                              icon: Icon(Icons.browse_gallery),
                                              iconSize: 50,
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(selectedImage != null ? 'Image Added\n${selectedImage!.path}' : 'Add Image'),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 30.0),
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //       labelText: 'Location',
                      //       hintText: 'Name the location, area, or site',
                      //       prefixIcon: Icon(Icons.location_pin, color: Colors.blue),
                      //       fillColor: Colors.blue,
                      //       labelStyle: TextStyle(
                      //         color: Colors.blue,
                      //         fontWeight: FontWeight.normal,
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.blue),
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Colors.green),
                      //         borderRadius: BorderRadius.circular(10.0),
                      //       ),
                      //     ),
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return 'Enter Something';
                      //       }
                      //       return null;
                      //     },
                      //     onChanged: (value) => setState(() => location = value),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                'Select Location',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Consumer<LocationProviderClass>(
                              builder: (context, selectedVal, child) {
                                if (selectedVal.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(), // Display a loading indicator
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return DropdownButton<String>(
                                            value: selectedVal.selectedLocation,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            isExpanded: true,
                                            icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                                            underline: Container(),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: null, // Placeholder value
                                                child: Text('Select Location'),
                                              ),
                                              if (selectedVal != null && selectedVal.LocationPost != null)
                                                ...selectedVal.LocationPost!.map((type) {
                                                  return buildLocationMenuItem(type);
                                                }).toList(),
                                              ],
                                            onChanged: (v) {
                                              print('Selected location: $v');
                                              selectedVal.setLocation(v);
                                          //    incidentType = v!;
                                              SelectedLocationType = v!;
                                              print('selected location:$SelectedLocationType');
                                            Provider.of<SubLocationProviderClass>(context, listen: false).selectedSubLocation = null;
                                            Provider.of<SubLocationProviderClass>(context, listen: false).getSubLocationPostData(v!);

                                            },
                                          );

                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Consumer<SubLocationProviderClass>(
                              builder: (context, selectedValue, child) {
                           //   final incidentSubTypes = selectedValue.filteredIncidentSubTypes;                                
                                if (selectedValue.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(), // Display a loading indicator
                                  );
                                } 
                               // else if (SelectedIncidentType != null){                                   
                                   return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return DropdownButton<String>(
                                            value: selectedValue.selectedSubLocation,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            isExpanded: true,
                                            icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                                            underline: Container(),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: null, // Placeholder value
                                                child: Text('Select Location Sub Type'),
                                              ),
                                              if (selectedValue!= null && selectedValue.subLocationtPost != null)
                                                ...selectedValue.subLocationtPost!.map((type) {
                                                  return buildSubLocationMenuItem(type);
                                                }).toList(),                                               
                                              ],
                                            onChanged: (v) {
                                              selectedValue.setSubLocationType(v!);
                                              SelectedSubLocationType = v!;
                                              print('Selected Sub Location: $SelectedSubLocationType');


                                            },
                                          );

                                      },
                                    ),
                                  );
                                  } 
                                  // else {
                                  //   return Text('Please select an Incident Type first');
                                  
                                
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                'Select Incident Type',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Consumer<IncidentProviderClass>(
                              builder: (context, selectedVal, child) {
                                if (selectedVal.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(), // Display a loading indicator
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return DropdownButton<String>(
                                            value: selectedVal.selectedIncident,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            isExpanded: true,
                                            icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                                            underline: Container(),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: null, // Placeholder value
                                                child: Text('Select Incident Type'),
                                              ),
                                              if (selectedVal != null && selectedVal.incidentPost != null)
                                                ...selectedVal.incidentPost!.map((type) {
                                                  return buildMenuItem(type);
                                                }).toList(),
                                              ],
                                            onChanged: (v) {
                                              print('Selected Incident: $v');
                                              selectedVal.setIncidentType(v);
                                              incidentType = v!;
                                              SelectedIncidentType = v;
                                            Provider.of<SubIncidentProviderClass>(context, listen: false).selectedSubIncident = null;
                                            Provider.of<SubIncidentProviderClass>(context, listen: false).getSubIncidentPostData(v);

                                            },
                                          );

                                      },
                                    ),
                                  );
                                }
                              },
                            ),

                            SizedBox(
                              height: 30,
                            ),
                            Consumer<SubIncidentProviderClass>(
                              builder: (context, selectedValue, child) {
                         //     final incidentSubTypes = selectedValue.filteredIncidentSubTypes;                                
                                if (selectedValue.loading) {
                                  return Center(
                                    child: CircularProgressIndicator(), // Display a loading indicator
                                  );
                                } 
                               // else if (SelectedIncidentType != null){                                   
                                   return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.blue),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> state) {
                                        return DropdownButton<String>(
                                            value: selectedValue.selectedSubIncident,
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            isExpanded: true,
                                            icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                                            underline: Container(),
                                            items: [
                                              DropdownMenuItem<String>(
                                                value: null, // Placeholder value
                                                child: Text('Select Incident Sub Type'),
                                              ),
                                              if (selectedValue!= null && selectedValue.subIncidentPost != null)
                                                ...selectedValue.subIncidentPost!.map((type) {
                                                  return buildSubMenuItem(type);
                                                }).toList(),                                               
                                              ],
                                            onChanged: (v) {
                                              print('Selected Sub Incident: $v');
                                              selectedValue.setSubIncidentType(v);
                                              incidentSubType = v!;



                                            },
                                          );

                                      },
                                    ),
                                  );
                                  } 
                                  // else {
                                  //   return Text('Please select an Incident Type first');
                                  
                                
                            ),


                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Describe the incident in a few words',
                            prefixIcon: Icon(Icons.description, color: Colors.blue),
                            fillColor: Colors.blue,
                            labelStyle: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Something';
                            }
                            return null;
                          },
                          onChanged: (value) => setState(() => description = value),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(chipLabels.length, (index) {
                          return ChoiceChip(
                            disabledColor: Colors.blue,
                            label: Text(chipLabels[index]),
                            selected: isSelected[index],
                            selectedColor: _getSelectedColor(index),
                            onSelected: (bool selected) {
                              setState(() {
                                for (int i = 0; i < isSelected.length; i++) {
                                  isSelected[i] = i == index ? selected : false;
                                  risklevel = chipLabelsid[index];
                                  print('crit level: $risklevel');
                                }
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleReportSubmitted(context, this);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Report Submitted'),
                          ),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        selectedImage = File(returnedImage.path);
      });
      Fluttertoast.showToast(msg: 'Image selected');
    }
  }

  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage != null) {
      setState(() {
        selectedImage = File(returnedImage.path);
      });
      Fluttertoast.showToast(msg: 'Image captured');
    }
  }
}

void handleReportSubmitted(BuildContext context, _UserFormState userFormState) async {
  ReportServices reportServices = ReportServices(context);
  final loginSuccessful = await reportServices.postReport(
    userFormState.selectedImage!.toString(),
  //  userFormState.id,
    userFormState.incidentSubType,
    userFormState.SelectedSubLocationType,
    userFormState.description,
    userFormState.date,
    userFormState.risklevel,

   // userFormState.status,
  );

  if (loginSuccessful) {
    Fluttertoast.showToast(msg: "Report Submitted");
  } else {
    Fluttertoast.showToast(msg: "Unable to Submit Report");
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
