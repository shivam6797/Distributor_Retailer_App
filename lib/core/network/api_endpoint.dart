class ApiEndpoints {
  // Base URL for the API
  static const String baseUrl = "http://128.199.98.121";

  // ---------- Distributor/Retailer ----------
  static String getDistriRetailUrl(int page) {
    return "$baseUrl/admin/Api/get_retailer_distributor_master/$page";
  }

  // ---------- Distributor/Retailer Add/Update ----------
 static const String addDistributorUrl = "$baseUrl/admin/Api/add_distributor";

}
