class ApiEndpoints {
  // Base URL for the API
  static const String baseUrl = "http://128.199.98.121";

  // ---------- Distributor/Retailer ----------
  static String getDistriRetailUrl(int type) {
    // type = 1 distributor, type = 2 retailer
    return "$baseUrl/admin/Api/get_retailer_distributor_master/$type";
  }

  // ---------- Distributor/Retailer Add/Update ----------
 static const String addDistributorUrl = "$baseUrl/admin/Api/add_distributor";

}
