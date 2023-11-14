// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_ims/User%20Module/pages/home_page.dart';
import 'package:user_ims/models/%20sub_location.dart';
import 'package:user_ims/models/location.dart';
import 'package:user_ims/User%20Module/providers/sub_location_provider.dart';
import 'package:user_ims/User%20Module/services/ReportServices.dart';
import 'package:provider/provider.dart';

import '../../models/incident_sub_type.dart';
import '../../models/incident_types.dart';
import '../../widgets/build_dropdown_menu_util.dart';
import '../../widgets/form_date_picker.dart';
import '../providers/incident_subtype_provider.dart';

import '../providers/incident_type_provider.dart';
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
  final TextEditingController _textFieldController = TextEditingController();
  bool _confirmedExit = false;

    void _processData() {
    // Process your data and upload to server
    _formKey.currentState?.reset();
  }

  

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

DropdownMenuItem<String> buildIncidentMenuItem(IncidentType type) {
  return DropdownMenuItemUtil.buildDropdownMenuItem<IncidentType>(
    type,
    type.Incident_Type_ID,
    type.Incident_Type_Description
    // Add the condition to check if it's selected based on your logic
  );
}

DropdownMenuItem<String> buildSubIncidentMenuItem(IncidentSubType type) {
  return DropdownMenuItemUtil.buildDropdownMenuItem<IncidentSubType>(
    type,
    type.Incident_SubType_ID,
    type.Incident_SubType_Description
    // Add the condition to check if it's selected based on your logic
  );
}

DropdownMenuItem<String> buildLocationMenuItem(Location type) {
  return DropdownMenuItemUtil.buildDropdownMenuItem<Location>(
    type,
    type.Location_ID,
    type.Location_Name
    // Add the condition to check if it's selected based on your logic
  );
}

DropdownMenuItem<String> buildSubLocationMenuItem(SubLocation type) {
  return DropdownMenuItemUtil.buildDropdownMenuItem<SubLocation>(
    type,
    type.Sub_Location_ID,
    type.Sub_Location_Name
    // Add the condition to check if it's selected based on your logic
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
return WillPopScope(
  onWillPop: () async {
    if (_confirmedExit) {
      // If the exit is confirmed, replace the current route with the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      return false; // Prevent the user from going back
    } else {
      // Show the confirmation dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Exit'),
          content: Text('Do you want to leave this page? Any unsaved changes will be lost.'),
          actions: [
            TextButton(
              onPressed: () {
                // If the user confirms, set _confirmedExit to true and pop the dialog
                setState(() {
                  _confirmedExit = true;
                });
                
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                   );

              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // If the user cancels, do nothing and pop the dialog
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
          ],
        ),
      );
      return false;
    }
  },  
   child: Scaffold(
        backgroundColor: Colors.blue[300],
        appBar: AppBar(
          title: const Text('Report an Incident'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                    
                  ),
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
                              child: Text(selectedImage != null ? 'Image Added' : 'Add Image'),
                            ),
                            

                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
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
                                            borderRadius: BorderRadius.circular(5),
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
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:8.0),
                                                        child: Text('Select Location'),
                                                      ),
                                                    ),
                                                    if (selectedVal != null && selectedVal.LocationPost != null)
                                                      ...selectedVal.LocationPost!.map((type) {
                                                        return buildLocationMenuItem(type);
                                                      }).toList(),
                                                    ],
                                                  onChanged: (v) {
                                                    selectedVal.setLocation(v);
                                                //    incidentType = v!;
                                                    SelectedLocationType = v!;
                                                  Provider.of<SubLocationProviderClass>(context, listen: false).selectedSubLocation = null;
                                                  Provider.of<SubLocationProviderClass>(context, listen: false).getSubLocationPostData(v);
                  
                                                  },
                                                );
                  
                                            },
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Consumer<SubLocationProviderClass>(
                                    builder: (context, selectedValue, child) {
                                      if (SelectedLocationType !=null){
      
                                      if (selectedValue.loading) {
                                        return Center(
                                          child: CircularProgressIndicator(), // Display a loading indicator
                                        );
                                      } else {                                
                                         return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.blue),
                                            borderRadius: BorderRadius.circular(5),
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
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:8.0),
                                                        child: Text('Select location sub type'),
                                                      ),
                                                    ),
                                                    if (selectedValue!= null && selectedValue.subLocationtPost != null)
                                                      ...selectedValue.subLocationtPost!.map((type) {
                                                        return buildSubLocationMenuItem(type);
                                                      }).toList(),                                               
                                                    ],
                                                  onChanged: (v) {
                                                    selectedValue.setSubLocationType(v);
                                                    SelectedSubLocationType = v!;
                  
                  
                                                  },
                                                );
                  
                                            },
                                          ),
                                        );
                                        } 
                                      }
                                         else {
                                           return Container(
                                            width: double.infinity,
                                          decoration: BoxDecoration(
                                            color:Colors.grey[100],
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:5.0,vertical: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: const [
                                                Text('Please select a location first',
                                                style: TextStyle(color: Colors.grey,)),
                                                Icon(Icons.arrow_drop_down, color: Colors.grey)
                                              ],
                                            ),
                                          )
                                          
                                   );
                                   
                                    } 
                                    }  
                                      
                                  ),
                  
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
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
                                            borderRadius: BorderRadius.circular(5),
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
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:8.0),
                                                        child: Text('Select incident type'),
                                                      ),
                                                    ),
                                                    if (selectedVal != null && selectedVal.incidentPost != null)
                                                      ...selectedVal.incidentPost!.map((type) {
                                                        return buildIncidentMenuItem(type);
                                                      }).toList(),
                                                    ],
                                                  onChanged: (v) {
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
                                    height: 10,
                                  ),
                                  Consumer<SubIncidentProviderClass>(
                                    builder: (context, selectedValue, child) {
                                      if (SelectedIncidentType != null){ 
                                      if (selectedValue.loading) {
                                        return Center(
                                          child: CircularProgressIndicator(), // Display a loading indicator
                                        );
                                      } 
                                     else  {                                 
                                         return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.blue),
                                            borderRadius: BorderRadius.circular(5),
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
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left:8.0),
                                                        child: Text('Select incident sub type'),
                                                      ),
                                                    ),
                                                    if (selectedValue!= null && selectedValue.subIncidentPost != null)
                                                      ...selectedValue.subIncidentPost!.map((type) {
                                                        return buildSubIncidentMenuItem(type);
                                                      }).toList(),                                               
                                                    ],
                                                  onChanged: (v) {
                                                    selectedValue.setSubIncidentType(v);
                                                    incidentSubType = v!;
                  
                  
                  
                                                  },
                                                );
                  
                                            },
                                          ),
                                        );
                                        }
                                      } 
                                        else {
                                           return Container(
                                            width: double.infinity,
                                          decoration: BoxDecoration(
                                            color:Colors.grey[100],
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.symmetric(horizontal:5.0,vertical: 12),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: const [
                                                Text('Please select a incident first',
                                                style: TextStyle(color: Colors.grey,)),
                                                Icon(Icons.arrow_drop_down, color: Colors.grey)
                                              ],
                                            ),
                                          )
                                          
                                   );
                                        
                                        }
                                        }
                                  ),
                  
                  
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: TextFormField(
                                controller: _textFieldController,          
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
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                               onChanged: (value) => setState(() => description = value),
                                maxLines: 3,
                              ),
                            ),
                            FormDatePicker(
                                      date: date,
                                      onChanged: (newDateTime) {
                                        // Handle the updated date
                                        setState(() {
                                          date = newDateTime;
                                        });
                                      },
                                    ),                           SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(chipLabels.length, (index) {
                                return ChoiceChip(
                                  backgroundColor: isSelected[index] ? null : Colors.blue,
                                  label: Text(chipLabels[index],
                                  style: TextStyle(color: Colors.white),),
                                  selected: isSelected[index],
                                  selectedColor: _getSelectedColor(index),
                                  onSelected: (bool selected) {
                                    setState(() {
                                      for (int i = 0; i < isSelected.length; i++) {
                                        isSelected[i] = i == index ? selected : false;
                                        risklevel = chipLabelsid[index];
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
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              handleReportSubmitted(context, this);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text('Report Submitted'),
                                ),
                              );
                              _processData();
                                setState(() {
                                  selectedImage = null;
                                   Provider.of<IncidentProviderClass>(context, listen: false).selectedIncident = null;
                                   Provider.of<LocationProviderClass>(context, listen: false).selectedLocation = null;
                                });                            
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
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
        print('---selectedImage: ${selectedImage}');

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
   await reportServices.postReport(
    userFormState.selectedImage.toString(),
  //  userFormState.id,
    userFormState.incidentSubType,
    userFormState.SelectedSubLocationType,
    userFormState.description,
    userFormState.date,
    userFormState.risklevel,

   // userFormState.status,
  );

}

