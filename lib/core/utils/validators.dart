class Validators {
  Validators._();

  // Business Name Validation
  static String? validateBusinessName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Business name is required";
    }
    if (value.length < 3) return "Business name must be at least 3 characters";
    return null;
  }

  // Business Type Validation
  static String? validateBusinessType(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Business type is required";
    }
    return null;
  }

  // GST Number Validation
  static String? validateGst(String? value) {
    if (value == null || value.trim().isEmpty) return "GST number is required";
    final gstRegex = RegExp(r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$');
    if (!gstRegex.hasMatch(value)) return "Enter valid GST number";
    return null;
  }

  // Address Validation
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) return "Address is required";
    if (value.length < 3) return "Enter valid address";
    return null;
  }

  // Pincode Validation
  static String? validatePincode(String? value) {
    if (value == null || value.trim().isEmpty) return "Pincode is required";
    if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) return "Enter valid pincode";
    return null;
  }

  // Person Name Validation
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return "Name is required";
    if (value.length < 3) return "Enter valid name";
    return null;
  }

  // Mobile Number Validation
  static String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) return "Mobile number is required";
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) return "Enter valid 10-digit mobile number";
    return null;
  }

  // State/City Validation
  static String? validateDropdown(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return "$fieldName is required";
    return null;
  }

  // Brand Validation
  static String? validateBrand(String? value) {
    if (value == null || value.trim().isEmpty) return "Select at least one brand";
    return null;
  }
}
