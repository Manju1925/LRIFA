import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gkvk/shared/components/CustomAlertDialog.dart';
import 'package:gkvk/shared/components/CustomTextButton.dart';
import 'package:gkvk/shared/components/CustomTextFormField.dart';
import 'package:gkvk/shared/components/SelectionButton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../../database/dealer_db.dart';
import '../Surveypages/Surveypages1.dart';

class GenerateDealersIdPage extends StatelessWidget {
  final int waterShedId;
// Add form key for validation

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _aadharController = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rskController = TextEditingController();
  final TextEditingController _fertilizerdealerController = TextEditingController();
  final TextEditingController _fertilizerdealerplaceController = TextEditingController();

  final Rxn<File> _selectedImage = Rxn<File>();
  final RxString _selectedGender = ''.obs;
  final RxString _selectedEducation = ''.obs;
  final RxString _selectedPIACadre = ''.obs;
  final RxString _selectedDurationWithReward = ''.obs;
  final RxString _rskstaffcadre = ''.obs;
  final RxString _selectedDurationExperience = ''.obs;
  final _formKey = GlobalKey<FormState>();

  GenerateDealersIdPage(
      {required this.waterShedId, super.key, int? aadharNumber});

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    if (source == ImageSource.camera) {
      await _pickImageFromCamera(context);
    } else if (source == ImageSource.gallery) {
      await _pickImageFromGallery(context);
    } else {
      throw Exception('Unknown image source: $source');
    }
  }

  Future<void> _pickImageFromCamera(BuildContext context) async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        _selectedImage.value = File(pickedFile.path);
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Error',
            content: "No image selected.",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Permission Required',
          content:
          "You have permanently denied the camera permission. Please enable it in the app settings.",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
      // _showDialog(
      //   context,
      //   'Permission Required',
      //   'You have permanently denied the camera permission. Please enable it in the app settings.',
      //   openAppSettings,
      // );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Permission Required',
          content: "Please grant the camera permission to take a photo.",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      final pickedFile =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _selectedImage.value = File(pickedFile.path);
      } else {
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Error',
            content: "No image selected.",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      }
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Permission Required',
          content:
          "You have permanently denied the storage permission. Please enable it in the app settings.",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomAlertDialog(
          title: 'Permission Required',
          content: "Please grant the storage permission to select a photo.",
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  Future<void> _uploadData(BuildContext context) async {
    final DealerDb dealerDb = DealerDb();
    try {
      // Validate form
      if (!_formKey.currentState!.validate()) {
        return;
      }

      // Check if the dealer profile already exists
      final existingProfile =
      await dealerDb.read(int.parse(_aadharController.text));

      if (existingProfile != null) {
        // Update the existing profile
        await dealerDb.update(
          pincode: _pincodeController.text,
          dealerName: _nameController.text,
          fatherName: _fatherNameController.text,
          gender: _selectedGender.value,
          educationStatus: _selectedEducation.value,
          PIACadre: _selectedPIACadre.value,
          durationReward: _selectedDurationWithReward.value,
          rskStaffCadre: _rskstaffcadre.value,
          RSKname: _rskController.text,
          FertilizerDealer: _fertilizerdealerController.text,
          DurationSales: _selectedDurationExperience.value,
          DealerPlace: _fertilizerdealerplaceController.text,
          aadharNumber: int.parse(_aadharController.text),
          phonenumber: int.parse(phonenumbercontroller.text),
          watershedId: waterShedId,
          image: _selectedImage.value?.path ?? '',
          email: _emailController.text,
        );
      } else {
        // Create a new profile
        await dealerDb.create(
          dealerName: _nameController.text,
          fatherName: _fatherNameController.text,
          gender: _selectedGender.value,
          educationStatus: _selectedEducation.value,
          PIACadre: _selectedPIACadre.value,
          durationReward: _selectedDurationWithReward.value,
          rskStaffCadre: _rskstaffcadre.value,
          RSKname: _rskController.text,
          email: _emailController.text, // Include email field
          FertilizerDealer: _fertilizerdealerController.text,
          DurationSales: _selectedDurationExperience.value,
          DealerPlace: _fertilizerdealerplaceController.text,
          pincode: _pincodeController.text, // Include pincode field
          aadharNumber: int.parse(_aadharController.text),
          phonenumber: int.parse(phonenumbercontroller.text),
          watershedId: waterShedId,
          image: _selectedImage.value?.path ?? '',
        );
      }

      //Navigate to the next page after successful upload
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SurveyPage1(aadharId: int.parse(_aadharController.text))),
      );
    } catch (e) {
      // Show error dialog if upload fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to upload data: $e'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  bool _validateform() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    if (_selectedGender.value.isEmpty ||
        _selectedEducation.value.isEmpty ||
        _selectedPIACadre.value.isEmpty ||
        _selectedDurationWithReward.value.isEmpty ||
        _rskstaffcadre.value.isEmpty ||
        _selectedDurationExperience.value.isEmpty) {
      return false;
    }
    return true;
  }

  bool _validateFarmerControllers(BuildContext context) {
    List<String> emptyFields = [];
    // Check if all farmer-related controllers have non-empty values
    if (_nameController.text.isEmpty) {
      emptyFields.add('Farmer Name');
    }
    if (_fatherNameController.text.isEmpty) {
      emptyFields.add('Father Name');
    }
    if (_aadharController.text.isEmpty) {
      emptyFields.add('Aadhar Number');
    }
    if (_aadharController.text.length != 12) {
      emptyFields.add('Aadhar Number should be 12 digits only');
    }
    if (phonenumbercontroller.text.isEmpty) {
      emptyFields.add('Phone Number');
    }
    if (phonenumbercontroller.text.length != 10) {
      emptyFields.add('Phone Number should be 10 digits only');
    }
    if (_emailController.text.isEmpty) {
      emptyFields.add('Email');
    } else {
      String pattern =
          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(_emailController.text)) {
        emptyFields.add('Enter a valid email address');
      }
    }

    if (_pincodeController.text.isEmpty) {
      emptyFields.add('Pincode');
    }
    if (_pincodeController.text.length != 6) {
      emptyFields.add('Pincode must be 6 digits only');
    }
    if (_rskController.text.isEmpty) {
      emptyFields.add('RSK Name');
    }
    if (_fertilizerdealerController.text.isEmpty) {
      emptyFields.add('Fertilizer Dealer');
    }
    if (_fertilizerdealerplaceController.text.isEmpty) {
      emptyFields.add('Fertilizer Dealer\'s Place');
    }
    if (_selectedImage.value == null) {
      emptyFields.add('Add Image');
    }
    // Check if any field is empty, if yes, show alert and return false
    if (emptyFields.isNotEmpty) {
      _showEmptyFieldsAlert(context, emptyFields);
      // print('Empty fields: $emptyFields');
      return false;
    }

    return true;
  }

  void _showEmptyFieldsAlert(BuildContext context, List<String> emptyFields) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: const Color(0xFFFEF8E0),
          title: const Text(
            'Alert',
            style: TextStyle(
              color: Color(0xFFFB812C),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'The following fields must be filled:\n${emptyFields.join('\n')}',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFFB812C),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFEF8E0),
          centerTitle: true,
          title: const Text(
            'DEALER DETAILS',
            style: TextStyle(
              color: Color(0xFFFB812C),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xFFFB812C)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Add form key
              child: Container(
                color: const Color(0xFFFEF8E0),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: "Name",
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide details";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Obx(() => SelectionButton(
                      label: "Gender",
                      options: const ['Male', 'Female', 'Other'],
                      selectedOption: _selectedGender.value.isEmpty
                          ? null
                          : _selectedGender.value,
                      onPressed: (option) {
                        _selectedGender.value = option;
                      },
                      errorMessage: _selectedGender.value.isEmpty
                          ? 'Please select gender'
                          : null,
                    )),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: "Father's/Husband Name",
                      controller: _fatherNameController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide details";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Pincode",
                            controller: _pincodeController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please provide details";
                              }
                              if (value.length != 6) {
                                return "6 digits only";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: CustomTextFormField(
                            labelText: "Phone Number",
                            controller: phonenumbercontroller,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please provide details";
                              }
                              if (value.length != 10) {
                                return "10 digits only";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: "Email ID",
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide an email";
                        }
                        String pattern =
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: "Aadhar Number",
                      controller: _aadharController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide details";
                        }
                        if (value.length != 12) {
                          return "12 digits only";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Obx(() => SelectionButton(
                      label: "Educational Status",
                      options: const ['SSLC', 'Intermediate', 'Diploma', 'Degree', 'Post Graduate', 'Doctorate'],
                      selectedOption: _selectedEducation.value.isEmpty
                          ? null
                          : _selectedEducation.value,
                      onPressed: (option) {
                        _selectedEducation.value = option;
                      },
                      errorMessage: _selectedEducation.value.isEmpty
                          ? 'Please select an educational status'
                          : null,
                    )),
                    const SizedBox(height: 10.0),
                    Obx(() => SelectionButton(
                      label: "PIA Cadre",
                      options: const ['ADA', 'AO', 'AAO', 'AHO', 'RFO', 'DPC', 'WA', 'LRI-EM', 'TL-FNGO', 'FNGO-TC', 'WM'],
                      selectedOption: _selectedPIACadre.value.isEmpty
                          ? null
                          : _selectedPIACadre.value,
                      onPressed: (option) {
                        _selectedPIACadre.value = option;
                      },
                      errorMessage: _selectedPIACadre.value.isEmpty
                          ? 'Please select a PIA cadre'
                          : null,
                    )),
                    const SizedBox(height: 10.0),
                    Obx(() => SelectionButton(
                      label: "Duration with REWARD",
                      options: const [
                        '< 6 Months',
                        '1 Year',
                        '1.5 Years',
                        '2 Years',
                        'Above 2 Years'
                      ],
                      selectedOption: _selectedDurationWithReward.value.isEmpty
                          ? null
                          : _selectedDurationWithReward.value,
                      onPressed: (option) {
                        _selectedDurationWithReward.value = option;
                      },
                      errorMessage: _selectedDurationWithReward.value.isEmpty
                          ? 'Please specify the duration with REWARD'
                          : null,
                    )),
                    const SizedBox(height: 10.0),
                    Obx(() => SelectionButton(
                      label: "RSK staff cadre",
                      options: const [
                        'AO',
                        'AAO',
                      ],
                      selectedOption: _rskstaffcadre.value.isEmpty
                          ? null
                          : _rskstaffcadre.value,
                      onPressed: (option) {
                        _rskstaffcadre.value = option;
                      },
                      errorMessage: _rskstaffcadre.value.isEmpty
                          ? 'Please specify the RSK staff cadre'
                          : null,
                    )),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: "RSK Name",
                      controller: _rskController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide details";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: "Fertilizer dealer",
                      controller: _fertilizerdealerController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide details";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Obx(() => SelectionButton(
                      label: "Duration of Fertilizer sales",
                      options: const [
                        '< 2 Years',
                        '2-5 Years',
                        'above 5 Years',
                      ],
                      selectedOption: _selectedDurationExperience.value.isEmpty
                          ? null
                          : _selectedDurationExperience.value,
                      onPressed: (option) {
                        _selectedDurationExperience.value = option;
                      },
                      errorMessage: _selectedDurationExperience.value.isEmpty
                          ? 'Please specify the duration'
                          : null,
                    )),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      labelText: "Fertilizer dealer's place",
                      controller: _fertilizerdealerplaceController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide details";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Obx(() => _selectedImage.value == null
                        ? const Text('No image selected.')
                        : Image.file(_selectedImage.value!,
                        height: 100, width: 100)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.camera),
                          onPressed: () {
                            _pickImage(context, ImageSource.camera);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.photo),
                          onPressed: () {
                            _pickImage(context, ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 75,
          color: const Color(0xFFFEF8E0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextButton(
                text: 'NEXT',
                buttonColor: const Color(0xFFFB812C),
                onPressed: () {
                  bool isFormValid = _validateform();
                  bool areControllersValid =
                  _validateFarmerControllers(context);
                  if (isFormValid && areControllersValid) {
                    try {
                      _uploadData(context);
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            backgroundColor: const Color(0xFFFEF8E0),
                            title: const Text(
                              'Error',
                              style: TextStyle(
                                color: Color(0xFFFB812C),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              'Failed to upload data. Please check your input and try again.',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Color(0xFFFB812C),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else if (!areControllersValid) {
                    // The alert for invalid controllers will already have been shown, so do nothing here
                  } else {
                    // If form is invalid, show a generic alert
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          backgroundColor: const Color(0xFFFEF8E0),
                          title: const Text(
                            'Alert',
                            style: TextStyle(
                              color: Color(0xFFFB812C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: const Text(
                            'All the details must be filled.',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Color(0xFFFB812C),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
