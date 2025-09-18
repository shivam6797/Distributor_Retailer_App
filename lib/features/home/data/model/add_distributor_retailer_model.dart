class AddDistributorRetailerModel {
  final String? id;
  final String businessName;
  final String businessType;
  final String gstNo;
  final String address;
  final String pincode;
  final String name;
  final String mobile;
  final String state;
  final String city;
  final String regionId;
  final String areaId;
  final String appPk;
  final String userId;
  final String bankAccountId;
  final String type;
  final String brandIds;
  final String? parentId;
  final String? imagePath;

  AddDistributorRetailerModel({
    this.id,
    required this.businessName,
    required this.businessType,
    required this.gstNo,
    required this.address,
    required this.pincode,
    required this.name,
    required this.mobile,
    required this.state,
    required this.city,
    required this.regionId,
    required this.areaId,
    required this.appPk,
    required this.userId,
    required this.bankAccountId,
    required this.type,
    required this.brandIds,
    this.parentId,
    this.imagePath,
  });

  factory AddDistributorRetailerModel.fromJson(Map<String, dynamic> json) {
    return AddDistributorRetailerModel(
      id: json["id"]?.toString(),
      businessName: json["business_name"] ?? "",
      businessType: json["business_type"] ?? "",
      gstNo: json["gst_no"] ?? "",
      address: json["address"] ?? "",
      pincode: json["pincode"] ?? "",
      name: json["name"] ?? "",
      mobile: json["mobile"] ?? "",
      state: json["state"] ?? "",
      city: json["city"] ?? "",
      regionId: json["region_id"] ?? "",
      areaId: json["area_id"] ?? "",
      appPk: json["app_pk"]?.toString() ?? "",
      userId: json["user_id"]?.toString() ?? "",
      bankAccountId: json["bank_account_id"] ?? "",
      type: json["type"] ?? "",
      brandIds: json["brand_ids"] ?? "",
      parentId: json["parent_id"]?.toString(),
      imagePath: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "business_name": businessName,
      "business_type": businessType,
      "gst_no": gstNo,
      "address": address,
      "pincode": pincode,
      "name": name,
      "mobile": mobile,
      "state": state,
      "city": city,
      "region_id": regionId,
      "area_id": areaId,
      "app_pk": appPk.toString(),
      "user_id": userId.toString(),
      "bank_account_id": "1",
      "type": type,
      "brand_ids": brandIds,
    };

    if (type.toLowerCase() == 'retailer') {
      data["parent_id"] = parentId?.toString() ?? "";
    }

    if (imagePath != null && imagePath!.isNotEmpty) {
      data["image"] = imagePath!;
    }

    if (id != null && id!.isNotEmpty) {
      data["id"] = id!;
    }

    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "businessName": businessName,
      "businessType": businessType,
      "gstNo": gstNo,
      "address": address,
      "pincode": pincode,
      "name": name,
      "mobile": mobile,
      "state": state,
      "city": city,
      "regionId": regionId,
      "areaId": areaId,
      "appPk": appPk,
      "userId": userId,
      "bankAccountId": bankAccountId,
      "type": type,
      "brandIds": brandIds,
      "parentId": parentId,
      "imagePath": imagePath,
    };
  }
}
