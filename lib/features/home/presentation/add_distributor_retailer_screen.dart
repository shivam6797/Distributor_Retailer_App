import 'package:distributor_retailer_app/core/utils/validators.dart';
import 'package:distributor_retailer_app/core/widgets/custom_dropdown.dart';
import 'package:distributor_retailer_app/core/widgets/custom_textfield.dart';
import 'package:distributor_retailer_app/features/home/bloc/distributor_retailer_bloc.dart';
import 'package:distributor_retailer_app/features/home/bloc/distributor_retailer_event.dart';
import 'package:distributor_retailer_app/features/home/bloc/distributor_retailer_state.dart';
import 'package:distributor_retailer_app/features/home/data/model/add_distributor_retailer_model.dart';
import 'package:distributor_retailer_app/features/home/data/model/dropdown_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDistributorRetailerScreen extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? distributorData;
  const AddDistributorRetailerScreen({
    super.key,
    this.isEdit = false,
    this.distributorData,
  });

  @override
  State<AddDistributorRetailerScreen> createState() =>
      _AddDistributorRetailerScreenState();
}

class _AddDistributorRetailerScreenState
    extends State<AddDistributorRetailerScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedUserType = 'Distributor';
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _gstNoController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _personNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  String? _selectedBrand;
  String? _selectedState;
  String? _selectedCity;
  String? _selectedRegion;
  String? _selectedArea;
  DropdownItem? _selectedBank;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  final List<String> _brands = [
    'Reliance Fresh',
    'Big Bazaar',
    'DMart',
    'More',
    'Spencers',
  ];

  final List<String> _states = [
    'Uttar Pradesh',
    'Maharashtra',
    'Delhi',
    'Karnataka',
    'Tamil Nadu',
    'West Bengal',
    'Rajasthan',
  ];

  final Map<String, List<String>> _citiesByState = {
    'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi', 'Noida'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Delhi': ['New Delhi'],
    'Karnataka': ['Bengaluru', 'Mysuru'],
    'Tamil Nadu': ['Chennai', 'Coimbatore'],
    'West Bengal': ['Kolkata', 'Siliguri'],
    'Rajasthan': ['Jaipur', 'Udaipur'],
  };

  final List<String> _regions = ['North', 'South', 'East', 'West', 'Central'];
  final List<String> _areas = ['Urban', 'Rural', 'Semi-Urban'];

  final List<DropdownItem> _banks = [
    DropdownItem('1', 'State Bank of India'),
    DropdownItem('2', 'HDFC Bank'),
    DropdownItem('3', 'ICICI Bank'),
    DropdownItem('4', 'Axis Bank'),
    DropdownItem('5', 'Punjab National Bank'),
    DropdownItem('6', 'Kotak Mahindra Bank'),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.distributorData != null) {
      _selectedUserType = widget.distributorData!['type'] ?? 'Distributor';
      _prefillData(widget.distributorData!);
    }
  }

  void _prefillData(Map<String, dynamic> data) {
    _businessNameController.text = data['business_name'] ?? '';
    _businessTypeController.text = data['business_type'] ?? '';
    _addressController.text = data['address'] ?? '';
    _gstNoController.text = data['gst_no'] ?? '';
    _pincodeController.text = data['pincode'] ?? '';
    _personNameController.text = data['name'] ?? '';
    _mobileController.text = data['mobile'] ?? '';
    _selectedUserType = data['type'] ?? 'Distributor';

    String? brandFromData = data['brands']?.toString();
    _selectedBrand = _brands.firstWhere(
      (b) => b.toLowerCase() == brandFromData?.toLowerCase(),
      orElse: () => _brands[0],
    );

    String? stateFromData = data['state']?.toString();
    _selectedState = _states.contains(stateFromData)
        ? stateFromData
        : _states[0];

    if (_selectedState != null) {
      String? cityFromData = data['city']?.toString();
      _selectedCity =
          (_citiesByState[_selectedState]?.contains(cityFromData) ?? false)
          ? cityFromData
          : _citiesByState[_selectedState]?.first;
    } else {
      _selectedCity = _citiesByState[_states[0]]?.first;
    }

    String? regionFromData = data['region_id']?.toString();
    if (regionFromData == "0" || !_regions.contains(regionFromData)) {
      _selectedRegion = _regions[0];
    } else {
      _selectedRegion = regionFromData;
    }

    String? areaFromData = data['area_id']?.toString();
    if (areaFromData == "0" || !_areas.contains(areaFromData)) {
      _selectedArea = _areas[0];
    } else {
      _selectedArea = areaFromData;
    }

    _selectedBank = _banks.firstWhere(
      (b) => b.id.toString() == (data['bank_account_id']?.toString() ?? ''),
      orElse: () => _banks[0],
    );
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final model = AddDistributorRetailerModel(
        type: _selectedUserType,
        businessName: _businessNameController.text.trim(),
        businessType: _businessTypeController.text.trim(),
        brandIds: _selectedBrand!,
        address: _addressController.text.trim(),
        state: _selectedState!,
        city: _selectedCity!,
        regionId: _selectedRegion!,
        areaId: _selectedArea!,
        appPk: "1",
        userId: "45",
        bankAccountId: _selectedBank?.id.toString() ?? "1",
        gstNo: _gstNoController.text.trim(),
        pincode: _pincodeController.text.trim(),
        name: _personNameController.text.trim(),
        mobile: _mobileController.text.trim(),
        parentId: _selectedUserType.toLowerCase() == 'retailer'
            ? (widget.distributorData?['parent_id']?.toString() ?? "0")
            : null,
        imagePath: _image?.path,
        id: widget.isEdit
            ? (widget.distributorData != null &&
                      widget.distributorData!['id'] != null
                  ? widget.distributorData!['id'].toString()
                  : null)
            : null,
      );

      context.read<DistributorRetailerBloc>().add(
        widget.isEdit
            ? UpdateDistributorRetailer(model: model)
            : AddDistributorRetailer(model: model),
      );
    }
  }

  void _clearForm() {
    _businessNameController.clear();
    _businessTypeController.clear();
    _addressController.clear();
    _gstNoController.clear();
    _pincodeController.clear();
    _personNameController.clear();
    _mobileController.clear();

    setState(() {
      _selectedBrand = null;
      _selectedState = null;
      _selectedCity = null;
      _selectedRegion = null;
      _selectedArea = null;
      _selectedBank = null;
      _image = null;
      _selectedUserType = 'Distributor';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.only(left: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1.5),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          'ADD NEW DISTRIBUTOR/RETAILER',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<DistributorRetailerBloc, DistributorRetailerState>(
        listener: (context, state) async {
          if (state is DistributorRetailerSuccess) {
            String action = widget.isEdit ? 'updated' : 'added';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "$_selectedUserType $action successfully!",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );

            _clearForm();

            context.read<DistributorRetailerBloc>().add(
              LoadDistributorRetailer(
                type: _selectedUserType,
                page: 1,
                isInitialLoad: true,
              ),
            );
            Navigator.pop(context, _selectedUserType);
          } else if (state is DistributorRetailerFailure) {
            print("Error from Bloc: ${state.message}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  "Error: ${state.message}",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }
        },

        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select type',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedUserType = 'Distributor';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedUserType == 'Distributor'
                                      ? Colors.black
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Distributor',
                                  style: GoogleFonts.poppins(
                                    color: _selectedUserType == 'Distributor'
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedUserType = 'Retailer';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: _selectedUserType == 'Retailer'
                                      ? Colors.black
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Retailer',
                                  style: GoogleFonts.poppins(
                                    color: _selectedUserType == 'Retailer'
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: _image == null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera_alt,
                                        size: 40,
                                        color: Colors.grey[600],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Take Photo',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  )
                                : Image.file(_image!, fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 24),

                        CustomTextField(
                          controller: _businessNameController,
                          labelText: '${_selectedUserType} Business Name',
                          hintText: '',
                          validator: Validators.validateBusinessName,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _businessTypeController,
                          labelText: 'Business Type',
                          hintText: '',
                          validator: Validators.validateBusinessType,
                        ),
                        const SizedBox(height: 16),

                        CustomDropdownField(
                          labelText: 'Select Brand',
                          value: _selectedBrand,
                          items: _brands,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedBrand = newValue;
                            });
                          },
                          hintText: 'Select brand',
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _addressController,
                          labelText: 'Address',
                          hintText: '',
                          validator: Validators.validateAddress,
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownField(
                                labelText: 'State',
                                value: _selectedState,
                                items: _states,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedState = newValue;
                                  });
                                },
                                hintText: 'Select',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomDropdownField<String>(
                                labelText: 'City',
                                value: _selectedCity,
                                items: _selectedState != null
                                    ? _citiesByState[_selectedState] ?? []
                                    : [],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCity = newValue;
                                  });
                                },
                                hintText: 'Select',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(
                              child: CustomDropdownField(
                                labelText: 'Region',
                                value: _selectedRegion,
                                items: _regions,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedRegion = newValue;
                                  });
                                },
                                hintText: 'Select',
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: CustomDropdownField(
                                labelText: 'Area',
                                value: _selectedArea,
                                items: _areas,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedArea = newValue;
                                  });
                                },
                                hintText: 'Select',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        CustomDropdownField<DropdownItem>(
                          labelText: 'Bank Name',
                          value: _selectedBank,
                          items: _banks,
                          labelBuilder: (b) => b.name,
                          onChanged: (DropdownItem? newValue) {
                            setState(() {
                              _selectedBank = newValue;
                            });
                          },
                        ),

                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _gstNoController,
                          labelText: 'Gst No.',
                          hintText: '',
                          validator: Validators.validateGst,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _pincodeController,
                          labelText: 'Pincode',
                          hintText: '',
                          keyboardType: TextInputType.number,
                          validator: Validators.validatePincode,
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _personNameController,
                          labelText: 'Person Name',
                          hintText: '',
                          validator: Validators.validateName,
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          controller: _mobileController,
                          labelText: 'Mobile',
                          hintText: '',
                          keyboardType: TextInputType.phone,
                          validator: Validators.validateMobile,
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state is DistributorRetailerLoading
                        ? null
                        : _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: state is DistributorRetailerLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'SUBMIT',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
