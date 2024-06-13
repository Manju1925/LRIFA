import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gkvk/shared/components/CustomTextFormField.dart';
import 'package:gkvk/shared/components/SelectionButton.dart';
import 'package:gkvk/database/cropdetails_db.dart';
import 'package:gkvk/views/Generate_id/detailsofCrops/Surveypages/Surveypages1.dart';

class Cropdetails extends StatefulWidget {
  final int aadharId;
  const Cropdetails({required this.aadharId, super.key});

  @override
  _CropdetailsState createState() => _CropdetailsState();
}

class _CropdetailsState extends State<Cropdetails> {
  final _cropNameController = TextEditingController();
  final _areaController = TextEditingController();
  final _surveyHissaController = TextEditingController();
  final _varietyController = TextEditingController();
  final _durationController = TextEditingController();
  final _costController = TextEditingController();
  final _rdfNitrogenController = TextEditingController();
  final _rdfPhosphorousController = TextEditingController();
  final _rdfPotassiumController = TextEditingController();
  final _adjustedrdfNitrogenController = TextEditingController();
  final _adjustedrdfPhosphorousController = TextEditingController();
  final _adjustedrdfPotassiumController = TextEditingController();

  final _organicManureNameController = TextEditingController();
  final _organicManureQuantityController = TextEditingController();
  final _organicManureCostController = TextEditingController();

  final _bioFertilizerNameController = TextEditingController();
  final _bioFertilizerQuantityController = TextEditingController();
  final _bioFertilizerCostController = TextEditingController();

  final TextEditingController _plantProtectionCostController =
      TextEditingController();
  final TextEditingController _ownLabourNumberController =
      TextEditingController();
  final TextEditingController _ownLabourCostController =
      TextEditingController();
  final TextEditingController _hiredLabourNumberController =
      TextEditingController();
  final TextEditingController _hiredLabourCostController =
      TextEditingController();
  final TextEditingController _animalDrawnCostController =
      TextEditingController();
  final TextEditingController _animalMechanizedCostController =
      TextEditingController();
  final TextEditingController _irrigationCostController =
      TextEditingController();

  final TextEditingController _mainProductQuantityController =
      TextEditingController();
  final TextEditingController _mainProductPriceController =
      TextEditingController();
  final TextEditingController _mainProductAmountController =
      TextEditingController();
  final TextEditingController _byProductQuantityController =
      TextEditingController();
  final TextEditingController _byProductPriceController =
      TextEditingController();
  final TextEditingController _byProductAmountController =
      TextEditingController();
  final TextEditingController _totalByProductAmountController1 =
      TextEditingController();
  final TextEditingController _totalByProductAmountController2 =
      TextEditingController();
  final TextEditingController _totalByProductAmountController3 =
      TextEditingController();

  final RxString _selectedTypeOfLand = ''.obs;
  final RxString _selectedSeason = ''.obs;
  final RxString _selectedSourceOfIrrigation = ''.obs;
  final RxString _selectedNitrogen = ''.obs;
  final RxString _selectedPhosphorous = ''.obs;
  final RxString _selectedPotassium = ''.obs;
  final RxString _Methodsoffertilizer = ''.obs;

  final List<Map<String, TextEditingController>> chemicalFertilizers = [];

  @override
  void initState() {
    super.initState();
    addNewFertilizer();
  }

  void addNewFertilizer() {
    setState(() {
      chemicalFertilizers.add({
        "name": TextEditingController(),
        "basal": TextEditingController(),
        "topDress": TextEditingController(),
        "totalQuantity": TextEditingController(),
        "totalCost": TextEditingController(),
      });
    });
  }

  Future<void> _submitData(BuildContext context) async {
    final cropDetailsDB = CropdetailsDB();

    Map<String, dynamic> data = {
      'aadharId': widget.aadharId,
      'cropName': _cropNameController.text,
      'area': double.tryParse(_areaController.text),
      'surveyHissa': _surveyHissaController.text,
      'variety': _varietyController.text,
      'duration': int.tryParse(_durationController.text),
      'season': _selectedSeason.value,
      'typeOfLand': _selectedTypeOfLand.value,
      'sourceOfIrrigation': _selectedSourceOfIrrigation.value,
      'cost': int.tryParse(_costController.text),
      'nitrogen': _selectedNitrogen.value,
      'phosphorous': _selectedPhosphorous.value,
      'potassium': _selectedPotassium.value,
      'rdfNitrogen': _rdfNitrogenController.text,
      'rdfPhosphorous': _rdfPhosphorousController.text,
      'rdfPotassium': _rdfPotassiumController.text,
      'adjustedrdfNitrogen': _adjustedrdfNitrogenController.text,
      'adjustedrdfPhosphorous': _adjustedrdfPhosphorousController.text,
      'adjustedrdfPotassium': _adjustedrdfPotassiumController.text,
      'organicManureName': _organicManureNameController.text,
      'organicManureQuantity':
          double.tryParse(_organicManureQuantityController.text),
      'organicManureCost': double.tryParse(_organicManureCostController.text),
      'bioFertilizerName': _bioFertilizerNameController.text,
      'bioFertilizerQuantity':
          double.tryParse(_bioFertilizerQuantityController.text),
      'bioFertilizerCost': double.tryParse(_bioFertilizerCostController.text),
      'plantProtectionCost':
          double.tryParse(_plantProtectionCostController.text),
      'ownLabourNumber': int.tryParse(_ownLabourNumberController.text),
      'ownLabourCost': double.tryParse(_ownLabourCostController.text),
      'hiredLabourNumber': int.tryParse(_hiredLabourNumberController.text),
      'hiredLabourCost': double.tryParse(_hiredLabourCostController.text),
      'animalDrawnCost': double.tryParse(_animalDrawnCostController.text),
      'animalMechanizedCost':
          double.tryParse(_animalMechanizedCostController.text),
      'irrigationCost': double.tryParse(_irrigationCostController.text),
      'mainProductQuantity':
          double.tryParse(_mainProductQuantityController.text),
      'mainProductPrice': double.tryParse(_mainProductPriceController.text),
      'mainProductAmount': double.tryParse(_mainProductAmountController.text),
      'byProductQuantity': double.tryParse(_byProductQuantityController.text),
      'byProductPrice': double.tryParse(_byProductPriceController.text),
      'byProductAmount': double.tryParse(_byProductAmountController.text),
      'totalByProductAmount1':
          double.tryParse(_totalByProductAmountController1.text),
      'totalByProductAmount2':
          double.tryParse(_totalByProductAmountController2.text),
      'totalByProductAmount3':
          double.tryParse(_totalByProductAmountController3.text),
      'methodsoffertilizer': _Methodsoffertilizer.value,
    };

    // Add chemical fertilizers details
    for (var i = 0; i < chemicalFertilizers.length; i++) {
      data['chemicalFertilizerName$i'] = chemicalFertilizers[i]['name']!.text;
      data['chemicalFertilizerBasal$i'] = chemicalFertilizers[i]['basal']!.text;
      data['chemicalFertilizerTopDress$i'] =
          chemicalFertilizers[i]['topDress']!.text;
      data['chemicalFertilizerTotalQuantity$i'] =
          double.tryParse(chemicalFertilizers[i]['totalQuantity']!.text);
      data['chemicalFertilizerTotalCost$i'] =
          double.tryParse(chemicalFertilizers[i]['totalCost']!.text);
    }

    await cropDetailsDB.create(data);

    print('Data submitted successfully');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SurveyPage1(aadharId: widget.aadharId),
      ),
    );
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit'),
          content: const Text('Do you want to return to the home page?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Enter the Crop details',
            style: TextStyle(
              color: Color(0xFF8DB600),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xFF8DB600)),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: const Color(0xFFF3F3F3),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: "Crop Name",
                    controller: _cropNameController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Area in acres",
                    controller: _areaController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Survey and Hissa no.",
                    controller: _surveyHissaController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Variety of crop",
                    controller: _varietyController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Duration (in days)",
                    controller: _durationController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  Obx(() => SelectionButton(
                        label: "Season",
                        options: const ['Kharif', 'Rabi', 'Summer'],
                        selectedOption: _selectedSeason.value.isEmpty
                            ? null
                            : _selectedSeason.value,
                        onPressed: (option) {
                          _selectedSeason.value = option ?? '';
                        },
                      )),
                  const SizedBox(height: 20.0),
                  Obx(() => SelectionButton(
                        label: "Type of land",
                        options: const ['Rain-fed', 'Irrigated'],
                        selectedOption: _selectedTypeOfLand.value.isEmpty
                            ? null
                            : _selectedTypeOfLand.value,
                        onPressed: (option) {
                          _selectedTypeOfLand.value = option ?? '';
                        },
                      )),
                  const SizedBox(height: 20.0),
                  Obx(() => SelectionButton(
                        label: "Source of irrigation",
                        options: const ['Borewell', 'Tank', 'Canal', 'Others'],
                        selectedOption:
                            _selectedSourceOfIrrigation.value.isEmpty
                                ? null
                                : _selectedSourceOfIrrigation.value,
                        onPressed: (option) {
                          _selectedSourceOfIrrigation.value = option ?? '';
                        },
                      )),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Cost of seed (including own seed)(in Rs.)",
                    controller: _costController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Fertility status according to LRI card',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Nitrogen',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  Obx(() => SelectionButton(
                        label: '',
                        options: const [
                          'Very low',
                          'Low',
                          'Medium',
                          'High',
                          'Very high'
                        ],
                        selectedOption: _selectedNitrogen.value.isEmpty
                            ? null
                            : _selectedNitrogen.value,
                        onPressed: (option) {
                          _selectedNitrogen.value = option ?? '';
                        },
                      )),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Phosphorous',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  Obx(() => SelectionButton(
                        label: '',
                        options: const [
                          'Very low',
                          'Low',
                          'Medium',
                          'High',
                          'Very high'
                        ],
                        selectedOption: _selectedPhosphorous.value.isEmpty
                            ? null
                            : _selectedPhosphorous.value,
                        onPressed: (option) {
                          _selectedPhosphorous.value = option ?? '';
                        },
                      )),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Potassium',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  Obx(() => SelectionButton(
                        label: '',
                        options: const [
                          'Very low',
                          'Low',
                          'Medium',
                          'High',
                          'Very high'
                        ],
                        selectedOption: _selectedPotassium.value.isEmpty
                            ? null
                            : _selectedPotassium.value,
                        onPressed: (option) {
                          _selectedPotassium.value = option ?? '';
                        },
                      )),
                  const SizedBox(height: 20.0),
                  const Text(
                    'RDF of crop (kg/ac)',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Nitrogen",
                    controller: _rdfNitrogenController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Phosphorous",
                    controller: _rdfPhosphorousController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Potassium",
                    controller: _rdfPotassiumController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Adjusted RDF of crop according to LRI card (kg/ac)',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Nitrogen",
                    controller: _adjustedrdfNitrogenController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Phosphorous",
                    controller: _adjustedrdfPhosphorousController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Potassium",
                    controller: _adjustedrdfPotassiumController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Manures and fertilizers',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Organic manures',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Name",
                    controller: _organicManureNameController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Quantity (in tonnes)",
                    controller: _organicManureQuantityController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Cost (in Rs.)",
                    controller: _organicManureCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Bio-fertilizers',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Name",
                    controller: _bioFertilizerNameController,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Quantity (in kgs)",
                    controller: _bioFertilizerQuantityController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Cost (in Rs.)",
                    controller: _bioFertilizerCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Chemical fertilizers',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  ...chemicalFertilizers.map((fertilizer) {
                    return Column(
                      children: [
                        CustomTextFormField(
                          labelText: "Name",
                          controller: fertilizer['name']!,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextFormField(
                          labelText: "Basal dose (in kgs)",
                          controller: fertilizer['basal']!,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextFormField(
                          labelText: "Top dress (in kgs)",
                          controller: fertilizer['topDress']!,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextFormField(
                          labelText: "Total quantity (in kgs)",
                          controller: fertilizer['totalQuantity']!,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextFormField(
                          labelText: "Total cost (in Rs.)",
                          controller: fertilizer['totalCost']!,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    );
                  }).toList(),
                  ElevatedButton(
                    onPressed: addNewFertilizer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8DB600),
                    ),
                    child: const Text('Add new fertilizer'),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Method of application of fertilizers',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  ),
                  Obx(() => SelectionButton(
                        label: '',
                        options: const ['Broadcasting', 'line', 'band', 'spot'],
                        selectedOption: _Methodsoffertilizer.value.isEmpty
                            ? null
                            : _Methodsoffertilizer.value,
                        onPressed: (option) {
                          _Methodsoffertilizer.value = option ?? '';
                        },
                      )),

                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Plant Protection Cost (in Rs.)",
                    controller: _plantProtectionCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Labour Details',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  CustomTextFormField(
                    labelText: "Own Labour(number)",
                    controller: _ownLabourNumberController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Cost (in Rs.)",
                    controller: _ownLabourCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Hired Labour(number)",
                    controller: _hiredLabourNumberController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Cost (in Rs.)",
                    controller: _hiredLabourCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Cost of animal drawn work (Rs.)",
                    controller: _animalDrawnCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Cost of mechanized works (Rs.)",
                    controller: _animalMechanizedCostController,
                    keyboardType: TextInputType.number,
                  ),

                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Irrigation cost (in Rs.)",
                    controller: _irrigationCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Other production cost, if any (Rs.)",
                    controller: _irrigationCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Total cost of production",
                    controller: _irrigationCostController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Returns',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Quantity of main product",
                    controller: _mainProductQuantityController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Quantity of main product(in quintal)",
                    controller: _mainProductPriceController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Price/unit (in Rs.)",
                    controller: _mainProductAmountController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Total main product amount(in quintal)",
                    controller: _byProductQuantityController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Quantity of By-products(in tons)",
                    controller: _byProductPriceController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Price/unit (in Rs.)",
                    controller: _byProductAmountController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Total By- product amount(in Rs.)",
                    controller: _totalByProductAmountController1,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    labelText: "Total returns (main and by product) (Rs.)",
                    controller: _totalByProductAmountController2,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20.0),
                  // New section ends here
                  ElevatedButton(
                    onPressed: () => _submitData(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8DB600),
                    ),
                    child: const Text('Submit'),
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
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gkvk/shared/components/CustomTextFormField.dart';
// import 'package:gkvk/shared/components/SelectionButton.dart';
// import 'package:gkvk/database/cropdetails_db.dart';

// class Cropdetails extends StatefulWidget {
//   final int aadharId;
//   const Cropdetails({required this.aadharId, super.key});

//   @override
//   _CropdetailsState createState() => _CropdetailsState();
// }

// class _CropdetailsState extends State<Cropdetails> {
//   // General Details
//   final _cropNameController = TextEditingController();
//   final _areaController = TextEditingController();
//   final _surveyHissaController = TextEditingController();
//   final _varietyController = TextEditingController();
//   final _durationController = TextEditingController();
//   final _costController = TextEditingController();
//   final _rdfNitrogenController = TextEditingController();
//   final _rdfPhosphorousController = TextEditingController();
//   final _rdfPotassiumController = TextEditingController();
//   final _adjustedrdfNitrogenController = TextEditingController();
//   final _adjustedrdfPhosphorousController = TextEditingController();
//   final _adjustedrdfPotassiumController = TextEditingController();

//   // Organic Manures
//   final _organicManureNameController = TextEditingController();
//   final _organicManureQuantityController = TextEditingController();
//   final _organicManureCostController = TextEditingController();

//   // Bio-fertilizers
//   final _bioFertilizerNameController = TextEditingController();
//   final _bioFertilizerQuantityController = TextEditingController();
//   final _bioFertilizerCostController = TextEditingController();

//   // Labour Details
//   final TextEditingController _plantProtectionCostController = TextEditingController();
//   final TextEditingController _ownLabourNumberController = TextEditingController();
//   final TextEditingController _ownLabourCostController = TextEditingController();
//   final TextEditingController _hiredLabourNumberController = TextEditingController();
//   final TextEditingController _hiredLabourCostController = TextEditingController();
//   final TextEditingController _animalDrawnCostController = TextEditingController();
//   final TextEditingController _animalMechanizedCostController = TextEditingController();
//   final TextEditingController _irrigationCostController = TextEditingController();
//   final TextEditingController _otherProductionCostController = TextEditingController();
//   final TextEditingController _totalProductionCostController = TextEditingController();

//   // Returns
//   final TextEditingController _mainProductQuantityController = TextEditingController();
//   final TextEditingController _mainProductPriceController = TextEditingController();
//   final TextEditingController _mainProductAmountController = TextEditingController();
//   final TextEditingController _byProductQuantityController = TextEditingController();
//   final TextEditingController _byProductPriceController = TextEditingController();
//   final TextEditingController _byProductAmountController = TextEditingController();
//   final TextEditingController _totalByProductAmountController1 = TextEditingController();
//   final TextEditingController _totalReturnsController = TextEditingController();

//   // Rx variables for selection fields
//   final RxString _selectedTypeOfLand = ''.obs;
//   final RxString _selectedSeason = ''.obs;
//   final RxString _selectedSourceOfIrrigation = ''.obs;
//   final RxString _selectedNitrogen = ''.obs;
//   final RxString _selectedPhosphorous = ''.obs;
//   final RxString _selectedPotassium = ''.obs;
//   final RxString _Methodsoffertilizer = ''.obs;

//   // List of chemical fertilizers
//   final List<Map<String, TextEditingController>> chemicalFertilizers = [];

//   @override
//   void initState() {
//     super.initState();
//     addNewFertilizer();
//   }

//   void addNewFertilizer() {
//     setState(() {
//       chemicalFertilizers.add({
//         "name": TextEditingController(),
//         "basal": TextEditingController(),
//         "topDress": TextEditingController(),
//         "totalQuantity": TextEditingController(),
//         "totalCost": TextEditingController(),
//       });
//     });
//   }

//   Future<void> _submitData(BuildContext context) async {
//     final cropDetailsDB = CropdetailsDB();

//     Map<String, dynamic> data = {
//       'aadharId': widget.aadharId,
//       'cropName': _cropNameController.text,
//       'area': double.tryParse(_areaController.text),
//       'surveyHissa': _surveyHissaController.text,
//       'variety': _varietyController.text,
//       'duration': int.tryParse(_durationController.text),
//       'season': _selectedSeason.value,
//       'typeOfLand': _selectedTypeOfLand.value,
//       'sourceOfIrrigation': _selectedSourceOfIrrigation.value,
//       'cost': int.tryParse(_costController.text),
//       'nitrogen': _selectedNitrogen.value,
//       'phosphorous': _selectedPhosphorous.value,
//       'potassium': _selectedPotassium.value,
//       'rdfNitrogen': _rdfNitrogenController.text,
//       'rdfPhosphorous': _rdfPhosphorousController.text,
//       'rdfPotassium': _rdfPotassiumController.text,
//       'adjustedrdfNitrogen': _adjustedrdfNitrogenController.text,
//       'adjustedrdfPhosphorous': _adjustedrdfPhosphorousController.text,
//       'adjustedrdfPotassium': _adjustedrdfPotassiumController.text,
//       'organicManureName': _organicManureNameController.text,
//       'organicManureQuantity': double.tryParse(_organicManureQuantityController.text),
//       'organicManureCost': double.tryParse(_organicManureCostController.text),
//       'bioFertilizerName': _bioFertilizerNameController.text,
//       'bioFertilizerQuantity': double.tryParse(_bioFertilizerQuantityController.text),
//       'bioFertilizerCost': double.tryParse(_bioFertilizerCostController.text),
//       'plantProtectionCost': double.tryParse(_plantProtectionCostController.text),
//       'ownLabourNumber': int.tryParse(_ownLabourNumberController.text),
//       'ownLabourCost': double.tryParse(_ownLabourCostController.text),
//       'hiredLabourNumber': int.tryParse(_hiredLabourNumberController.text),
//       'hiredLabourCost': double.tryParse(_hiredLabourCostController.text),
//       'animalDrawnCost': double.tryParse(_animalDrawnCostController.text),
//       'animalMechanizedCost': double.tryParse(_animalMechanizedCostController.text),
//       'irrigationCost': double.tryParse(_irrigationCostController.text),
//       'mainProductQuantity': double.tryParse(_mainProductQuantityController.text),
//       'mainProductPrice': double.tryParse(_mainProductPriceController.text),
//       'mainProductAmount': double.tryParse(_mainProductAmountController.text),
//       'byProductQuantity': double.tryParse(_byProductQuantityController.text),
//       'byProductPrice': double.tryParse(_byProductPriceController.text),
//       'byProductAmount': double.tryParse(_byProductAmountController.text),
//       'totalByProductAmount1': double.tryParse(_totalByProductAmountController1.text),
//       'totalReturns': double.tryParse(_totalReturnsController.text),
//       'methodsoffertilizer': _Methodsoffertilizer.value,
//     };

//     // Add chemical fertilizers details
//     for (var i = 0; i < chemicalFertilizers.length; i++) {
//       data['chemicalFertilizerName$i'] = chemicalFertilizers[i]['name']!.text;
//       data['chemicalFertilizerBasal$i'] = chemicalFertilizers[i]['basal']!.text;
//       data['chemicalFertilizerTopDress$i'] = chemicalFertilizers[i]['topDress']!.text;
//       data['chemicalFertilizerTotalQuantity$i'] = double.tryParse(chemicalFertilizers[i]['totalQuantity']!.text);
//       data['chemicalFertilizerTotalCost$i'] = double.tryParse(chemicalFertilizers[i]['totalCost']!.text);
//     }

//     await cropDetailsDB.create(data);

//     print('Data submitted successfully');
//     Navigator.pop(context);
//   }

//   Future<void> _showExitConfirmationDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Exit'),
//           content: const Text('Do you want to return to the home page?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildTextFormField(String labelText, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
//     return CustomTextFormField(
//       labelText: labelText,
//       controller: controller,
//       keyboardType: keyboardType,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Management'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               _showExitConfirmationDialog(context);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTextFormField('Crop Name', _cropNameController),
//               buildTextFormField('Area', _areaController, keyboardType: TextInputType.number),
//               buildTextFormField('Survey/Hissa Number', _surveyHissaController),
//               buildTextFormField('Variety', _varietyController),
//               buildTextFormField('Duration', _durationController, keyboardType: TextInputType.number),
//               buildTextFormField('Cost', _costController, keyboardType: TextInputType.number),
//               Obx(() => SelectionButton(
//                     label: 'Season',
//                     options: ['Kharif', 'Rabi', 'Summer'],
//                     selectedOption: _selectedSeason.value,
//                     onChanged: (value) => _selectedSeason.value = value ?? '', onPressed: (String? ) {  },
//                   )),
//               Obx(() => SelectionButton(
//                     label: 'Type of Land',
//                     options: ['Wetland', 'Dryland', 'Gardenland'],
//                     selectedOption: _selectedTypeOfLand.value,
//                     onChanged: (value) => _selectedTypeOfLand.value = value ?? '',
//                   )),
//               Obx(() => SelectionButton(
//                     label: 'Source of Irrigation',
//                     options: ['Open well', 'Borewell', 'Canal', 'Tank', 'River'],
//                     selectedOption: _selectedSourceOfIrrigation.value,
//                     onChanged: (value) => _selectedSourceOfIrrigation.value = value ?? '',
//                   )),
//               buildTextFormField('Nitrogen', _rdfNitrogenController),
//               buildTextFormField('Phosphorous', _rdfPhosphorousController),
//               buildTextFormField('Potassium', _rdfPotassiumController),
//               buildTextFormField('Adjusted RDF Nitrogen', _adjustedrdfNitrogenController),
//               buildTextFormField('Adjusted RDF Phosphorous', _adjustedrdfPhosphorousController),
//               buildTextFormField('Adjusted RDF Potassium', _adjustedrdfPotassiumController),
//               buildTextFormField('Organic Manure Name', _organicManureNameController),
//               buildTextFormField('Organic Manure Quantity', _organicManureQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('Organic Manure Cost', _organicManureCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Bio-Fertilizer Name', _bioFertilizerNameController),
//               buildTextFormField('Bio-Fertilizer Quantity', _bioFertilizerQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('Bio-Fertilizer Cost', _bioFertilizerCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Plant Protection Cost', _plantProtectionCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Number of Own Labourers', _ownLabourNumberController, keyboardType: TextInputType.number),
//               buildTextFormField('Cost of Own Labour', _ownLabourCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Number of Hired Labourers', _hiredLabourNumberController, keyboardType: TextInputType.number),
//               buildTextFormField('Cost of Hired Labour', _hiredLabourCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Animal Drawn Cost', _animalDrawnCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Animal Mechanized Cost', _animalMechanizedCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Irrigation Cost', _irrigationCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Other Production Cost', _otherProductionCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Total Cost of Production', _totalProductionCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Main Product Quantity', _mainProductQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('Main Product Price', _mainProductPriceController, keyboardType: TextInputType.number),
//               buildTextFormField('Main Product Amount', _mainProductAmountController, keyboardType: TextInputType.number),
//               buildTextFormField('By Product Quantity', _byProductQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('By Product Price', _byProductPriceController, keyboardType: TextInputType.number),
//               buildTextFormField('By Product Amount', _byProductAmountController, keyboardType: TextInputType.number),
//               buildTextFormField('Total By Product Amount', _totalByProductAmountController1, keyboardType: TextInputType.number),
//               buildTextFormField('Total Returns', _totalReturnsController, keyboardType: TextInputType.number),
//               Obx(() => SelectionButton(
//                     label: 'Methods of Fertilizer',
//                     options: ['Broadcasting', 'Placement', 'Foliar application'],
//                     selectedOption: _Methodsoffertilizer.value,
//                     onChanged: (value) => _Methodsoffertilizer.value = value,
//                   )),
//               ElevatedButton(
//                 onPressed: () => _submitData(context),
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _cropNameController.dispose();
//     _areaController.dispose();
//     _surveyHissaController.dispose();
//     _varietyController.dispose();
//     _durationController.dispose();
//     _costController.dispose();
//     _rdfNitrogenController.dispose();
//     _rdfPhosphorousController.dispose();
//     _rdfPotassiumController.dispose();
//     _adjustedrdfNitrogenController.dispose();
//     _adjustedrdfPhosphorousController.dispose();
//     _adjustedrdfPotassiumController.dispose();
//     _organicManureNameController.dispose();
//     _organicManureQuantityController.dispose();
//     _organicManureCostController.dispose();
//     _bioFertilizerNameController.dispose();
//     _bioFertilizerQuantityController.dispose();
//     _bioFertilizerCostController.dispose();
//     _plantProtectionCostController.dispose();
//     _ownLabourNumberController.dispose();
//     _ownLabourCostController.dispose();
//     _hiredLabourNumberController.dispose();
//     _hiredLabourCostController.dispose();
//     _animalDrawnCostController.dispose();
//     _animalMechanizedCostController.dispose();
//     _irrigationCostController.dispose();
//     _otherProductionCostController.dispose();
//     _totalProductionCostController.dispose();
//     _mainProductQuantityController.dispose();
//     _mainProductPriceController.dispose();
//     _mainProductAmountController.dispose();
//     _byProductQuantityController.dispose();
//     _byProductPriceController.dispose();
//     _byProductAmountController.dispose();
//     _totalByProductAmountController1.dispose();
//     _totalReturnsController.dispose();
//     for (var i = 0; i < chemicalFertilizers.length; i++) {
//       chemicalFertilizers[i]['name']!.dispose();
//       chemicalFertilizers[i]['basal']!.dispose();
//       chemicalFertilizers[i]['topDress']!.dispose();
//       chemicalFertilizers[i]['totalQuantity']!.dispose();
//       chemicalFertilizers[i]['totalCost']!.dispose();
//     }
//     super.dispose();
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gkvk/shared/components/CustomTextFormField.dart';
// import 'package:gkvk/shared/components/SelectionButton.dart';
// import 'package:gkvk/database/cropdetails_db.dart';

// class Cropdetails extends StatefulWidget {
//   final int aadharId;
//   const Cropdetails({required this.aadharId, super.key});

//   @override
//   _CropdetailsState createState() => _CropdetailsState();
// }

// class _CropdetailsState extends State<Cropdetails> {
//   // General Details
//   final _cropNameController = TextEditingController();
//   final _areaController = TextEditingController();
//   final _surveyHissaController = TextEditingController();
//   final _varietyController = TextEditingController();
//   final _durationController = TextEditingController();
//   final _costController = TextEditingController();
//   final _rdfNitrogenController = TextEditingController();
//   final _rdfPhosphorousController = TextEditingController();
//   final _rdfPotassiumController = TextEditingController();
//   final _adjustedrdfNitrogenController = TextEditingController();
//   final _adjustedrdfPhosphorousController = TextEditingController();
//   final _adjustedrdfPotassiumController = TextEditingController();

//   // Organic Manures
//   final _organicManureNameController = TextEditingController();
//   final _organicManureQuantityController = TextEditingController();
//   final _organicManureCostController = TextEditingController();

//   // Bio-fertilizers
//   final _bioFertilizerNameController = TextEditingController();
//   final _bioFertilizerQuantityController = TextEditingController();
//   final _bioFertilizerCostController = TextEditingController();

//   // Labour Details
//   final TextEditingController _plantProtectionCostController = TextEditingController();
//   final TextEditingController _ownLabourNumberController = TextEditingController();
//   final TextEditingController _ownLabourCostController = TextEditingController();
//   final TextEditingController _hiredLabourNumberController = TextEditingController();
//   final TextEditingController _hiredLabourCostController = TextEditingController();
//   final TextEditingController _animalDrawnCostController = TextEditingController();
//   final TextEditingController _animalMechanizedCostController = TextEditingController();
//   final TextEditingController _irrigationCostController = TextEditingController();
//   final TextEditingController _otherProductionCostController = TextEditingController();
//   final TextEditingController _totalProductionCostController = TextEditingController();

//   // Returns
//   final TextEditingController _mainProductQuantityController = TextEditingController();
//   final TextEditingController _mainProductPriceController = TextEditingController();
//   final TextEditingController _mainProductAmountController = TextEditingController();
//   final TextEditingController _byProductQuantityController = TextEditingController();
//   final TextEditingController _byProductPriceController = TextEditingController();
//   final TextEditingController _byProductAmountController = TextEditingController();
//   final TextEditingController _totalByProductAmountController1 = TextEditingController();
//   final TextEditingController _totalReturnsController = TextEditingController();

//   // Rx variables for selection fields
//   final RxString _selectedTypeOfLand = ''.obs;
//   final RxString _selectedSeason = ''.obs;
//   final RxString _selectedSourceOfIrrigation = ''.obs;
//   final RxString _selectedNitrogen = ''.obs;
//   final RxString _selectedPhosphorous = ''.obs;
//   final RxString _selectedPotassium = ''.obs;
//   final RxString _Methodsoffertilizer = ''.obs;

//   // List of chemical fertilizers
//   final List<Map<String, TextEditingController>> chemicalFertilizers = [];

//   @override
//   void initState() {
//     super.initState();
//     addNewFertilizer();
//   }

//   void addNewFertilizer() {
//     setState(() {
//       chemicalFertilizers.add({
//         "name": TextEditingController(),
//         "basal": TextEditingController(),
//         "topDress": TextEditingController(),
//         "totalQuantity": TextEditingController(),
//         "totalCost": TextEditingController(),
//       });
//     });
//   }

//   Future<void> _submitData(BuildContext context) async {
//     final cropDetailsDB = CropdetailsDB();

//     Map<String, dynamic> data = {
//       'aadharId': widget.aadharId,
//       'cropName': _cropNameController.text,
//       'area': double.tryParse(_areaController.text),
//       'surveyHissa': _surveyHissaController.text,
//       'variety': _varietyController.text,
//       'duration': int.tryParse(_durationController.text),
//       'season': _selectedSeason.value,
//       'typeOfLand': _selectedTypeOfLand.value,
//       'sourceOfIrrigation': _selectedSourceOfIrrigation.value,
//       'cost': int.tryParse(_costController.text),
//       'nitrogen': _selectedNitrogen.value,
//       'phosphorous': _selectedPhosphorous.value,
//       'potassium': _selectedPotassium.value,
//       'rdfNitrogen': _rdfNitrogenController.text,
//       'rdfPhosphorous': _rdfPhosphorousController.text,
//       'rdfPotassium': _rdfPotassiumController.text,
//       'adjustedrdfNitrogen': _adjustedrdfNitrogenController.text,
//       'adjustedrdfPhosphorous': _adjustedrdfPhosphorousController.text,
//       'adjustedrdfPotassium': _adjustedrdfPotassiumController.text,
//       'organicManureName': _organicManureNameController.text,
//       'organicManureQuantity': double.tryParse(_organicManureQuantityController.text),
//       'organicManureCost': double.tryParse(_organicManureCostController.text),
//       'bioFertilizerName': _bioFertilizerNameController.text,
//       'bioFertilizerQuantity': double.tryParse(_bioFertilizerQuantityController.text),
//       'bioFertilizerCost': double.tryParse(_bioFertilizerCostController.text),
//       'plantProtectionCost': double.tryParse(_plantProtectionCostController.text),
//       'ownLabourNumber': int.tryParse(_ownLabourNumberController.text),
//       'ownLabourCost': double.tryParse(_ownLabourCostController.text),
//       'hiredLabourNumber': int.tryParse(_hiredLabourNumberController.text),
//       'hiredLabourCost': double.tryParse(_hiredLabourCostController.text),
//       'animalDrawnCost': double.tryParse(_animalDrawnCostController.text),
//       'animalMechanizedCost': double.tryParse(_animalMechanizedCostController.text),
//       'irrigationCost': double.tryParse(_irrigationCostController.text),
//       'mainProductQuantity': double.tryParse(_mainProductQuantityController.text),
//       'mainProductPrice': double.tryParse(_mainProductPriceController.text),
//       'mainProductAmount': double.tryParse(_mainProductAmountController.text),
//       'byProductQuantity': double.tryParse(_byProductQuantityController.text),
//       'byProductPrice': double.tryParse(_byProductPriceController.text),
//       'byProductAmount': double.tryParse(_byProductAmountController.text),
//       'totalByProductAmount1': double.tryParse(_totalByProductAmountController1.text),
//       'totalReturns': double.tryParse(_totalReturnsController.text),
//       'methodsoffertilizer': _Methodsoffertilizer.value,
//     };

//     // Add chemical fertilizers details
//     for (var i = 0; i < chemicalFertilizers.length; i++) {
//       data['chemicalFertilizerName$i'] = chemicalFertilizers[i]['name']!.text;
//       data['chemicalFertilizerBasal$i'] = chemicalFertilizers[i]['basal']!.text;
//       data['chemicalFertilizerTopDress$i'] = chemicalFertilizers[i]['topDress']!.text;
//       data['chemicalFertilizerTotalQuantity$i'] = double.tryParse(chemicalFertilizers[i]['totalQuantity']!.text);
//       data['chemicalFertilizerTotalCost$i'] = double.tryParse(chemicalFertilizers[i]['totalCost']!.text);
//     }

//     await cropDetailsDB.create(data);

//     print('Data submitted successfully');
//     Navigator.pop(context);
//   }

//   Future<void> _showExitConfirmationDialog(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Exit'),
//           content: const Text('Do you want to return to the home page?'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).popUntil((route) => route.isFirst);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildTextFormField(String labelText, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
//     return CustomTextFormField(
//       labelText: labelText,
//       controller: controller,
//       keyboardType: keyboardType,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crop Management'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               _showExitConfirmationDialog(context);
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               buildTextFormField('Crop Name', _cropNameController),
//               buildTextFormField('Area', _areaController, keyboardType: TextInputType.number),
//               buildTextFormField('Survey/Hissa Number', _surveyHissaController),
//               buildTextFormField('Variety', _varietyController),
//               buildTextFormField('Duration', _durationController, keyboardType: TextInputType.number),
//               buildTextFormField('Cost', _costController, keyboardType: TextInputType.number),
//               Obx(() => SelectionButton(
//                     label: 'Season',
//                     options: ['Kharif', 'Rabi', 'Summer'],
//                     selectedOption: _selectedSeason.value,
//                     onChanged: (value) => _selectedSeason.value = value ?? '', onPressed: (String? ) {  },
//                   )),
//               Obx(() => SelectionButton(
//                     label: 'Type of Land',
//                     options: ['Wetland', 'Dryland', 'Gardenland'],
//                     selectedOption: _selectedTypeOfLand.value,
//                     onChanged: (value) => _selectedTypeOfLand.value = value ?? '',
//                   )),
//               Obx(() => SelectionButton(
//                     label: 'Source of Irrigation',
//                     options: ['Open well', 'Borewell', 'Canal', 'Tank', 'River'],
//                     selectedOption: _selectedSourceOfIrrigation.value,
//                     onChanged: (value) => _selectedSourceOfIrrigation.value = value ?? '',
//                   )),
//               buildTextFormField('Nitrogen', _rdfNitrogenController),
//               buildTextFormField('Phosphorous', _rdfPhosphorousController),
//               buildTextFormField('Potassium', _rdfPotassiumController),
//               buildTextFormField('Adjusted RDF Nitrogen', _adjustedrdfNitrogenController),
//               buildTextFormField('Adjusted RDF Phosphorous', _adjustedrdfPhosphorousController),
//               buildTextFormField('Adjusted RDF Potassium', _adjustedrdfPotassiumController),
//               buildTextFormField('Organic Manure Name', _organicManureNameController),
//               buildTextFormField('Organic Manure Quantity', _organicManureQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('Organic Manure Cost', _organicManureCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Bio-Fertilizer Name', _bioFertilizerNameController),
//               buildTextFormField('Bio-Fertilizer Quantity', _bioFertilizerQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('Bio-Fertilizer Cost', _bioFertilizerCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Plant Protection Cost', _plantProtectionCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Number of Own Labourers', _ownLabourNumberController, keyboardType: TextInputType.number),
//               buildTextFormField('Cost of Own Labour', _ownLabourCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Number of Hired Labourers', _hiredLabourNumberController, keyboardType: TextInputType.number),
//               buildTextFormField('Cost of Hired Labour', _hiredLabourCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Animal Drawn Cost', _animalDrawnCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Animal Mechanized Cost', _animalMechanizedCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Irrigation Cost', _irrigationCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Other Production Cost', _otherProductionCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Total Cost of Production', _totalProductionCostController, keyboardType: TextInputType.number),
//               buildTextFormField('Main Product Quantity', _mainProductQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('Main Product Price', _mainProductPriceController, keyboardType: TextInputType.number),
//               buildTextFormField('Main Product Amount', _mainProductAmountController, keyboardType: TextInputType.number),
//               buildTextFormField('By Product Quantity', _byProductQuantityController, keyboardType: TextInputType.number),
//               buildTextFormField('By Product Price', _byProductPriceController, keyboardType: TextInputType.number),
//               buildTextFormField('By Product Amount', _byProductAmountController, keyboardType: TextInputType.number),
//               buildTextFormField('Total By Product Amount', _totalByProductAmountController1, keyboardType: TextInputType.number),
//               buildTextFormField('Total Returns', _totalReturnsController, keyboardType: TextInputType.number),
//               Obx(() => SelectionButton(
//                     label: 'Methods of Fertilizer',
//                     options: ['Broadcasting', 'Placement', 'Foliar application'],
//                     selectedOption: _Methodsoffertilizer.value,
//                     onChanged: (value) => _Methodsoffertilizer.value = value,
//                   )),
//               ElevatedButton(
//                 onPressed: () => _submitData(context),
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _cropNameController.dispose();
//     _areaController.dispose();
//     _surveyHissaController.dispose();
//     _varietyController.dispose();
//     _durationController.dispose();
//     _costController.dispose();
//     _rdfNitrogenController.dispose();
//     _rdfPhosphorousController.dispose();
//     _rdfPotassiumController.dispose();
//     _adjustedrdfNitrogenController.dispose();
//     _adjustedrdfPhosphorousController.dispose();
//     _adjustedrdfPotassiumController.dispose();
//     _organicManureNameController.dispose();
//     _organicManureQuantityController.dispose();
//     _organicManureCostController.dispose();
//     _bioFertilizerNameController.dispose();
//     _bioFertilizerQuantityController.dispose();
//     _bioFertilizerCostController.dispose();
//     _plantProtectionCostController.dispose();
//     _ownLabourNumberController.dispose();
//     _ownLabourCostController.dispose();
//     _hiredLabourNumberController.dispose();
//     _hiredLabourCostController.dispose();
//     _animalDrawnCostController.dispose();
//     _animalMechanizedCostController.dispose();
//     _irrigationCostController.dispose();
//     _otherProductionCostController.dispose();
//     _totalProductionCostController.dispose();
//     _mainProductQuantityController.dispose();
//     _mainProductPriceController.dispose();
//     _mainProductAmountController.dispose();
//     _byProductQuantityController.dispose();
//     _byProductPriceController.dispose();
//     _byProductAmountController.dispose();
//     _totalByProductAmountController1.dispose();
//     _totalReturnsController.dispose();
//     for (var i = 0; i < chemicalFertilizers.length; i++) {
//       chemicalFertilizers[i]['name']!.dispose();
//       chemicalFertilizers[i]['basal']!.dispose();
//       chemicalFertilizers[i]['topDress']!.dispose();
//       chemicalFertilizers[i]['totalQuantity']!.dispose();
//       chemicalFertilizers[i]['totalCost']!.dispose();
//     }
//     super.dispose();
//   }
// }
