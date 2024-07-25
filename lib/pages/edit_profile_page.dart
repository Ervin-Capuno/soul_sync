import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_clone/data/account_json.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _age;
  late String _location;
  File? _profilePicture;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    _name = account_json[0]['name'] ?? '';
    _age = int.tryParse(account_json[0]['age'] ?? '0') ?? 0;
    _location = account_json[0]['location'] ?? '';
    _profilePicture = account_json[0]['img'] != null
        ? File(account_json[0]['img']!)
        : null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 36.0,
                          fontFamily: 'GreatVibes-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Edit ',
                            style: TextStyle(color: Colors.blue),
                          ),
                          TextSpan(
                            text: 'Profile',
                            style: TextStyle(color: Colors.purple),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80, 
                            backgroundImage: _profilePicture != null
                                ? FileImage(_profilePicture!)
                                : AssetImage('assets/images/default_profile.png') as ImageProvider,
                            backgroundColor: Color.fromARGB(255, 150, 120, 203),
                          ),
                          CircleAvatar(
                            radius: 20, 
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.add, color: Colors.white, size: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          initialValue: _name,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value ?? '';
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          initialValue: _age.toString(),
                          decoration: InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            final intValue = int.tryParse(value);
                            if (intValue == null || intValue <= 0) {
                              return 'Please enter a valid age';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _age = int.tryParse(value ?? '0') ?? 0;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          initialValue: _location,
                          decoration: InputDecoration(
                            labelText: 'Location',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your location';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _location = value ?? '';
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _formKey.currentState?.save();
                              
                              setState(() {
                                account_json[0]['name'] = _name;
                                account_json[0]['age'] = _age.toString();
                                account_json[0]['location'] = _location;
                                account_json[0]['img'] = _profilePicture?.path ?? '';
                              });
                             
                              Navigator.pop(context, true); 
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 5,
                          ),
                          child: Text('Save Changes'),
                        ),
                        SizedBox(height: 10), 
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false); 
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
