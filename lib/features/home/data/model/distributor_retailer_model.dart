class DistributorRetailerModel {
  String? st;
  String? msg;
  String? limit;
  int? numberOfPage;
  String? total;
  String? page;
  List<Data>? data;

  DistributorRetailerModel({
    this.st,
    this.msg,
    this.limit,
    this.numberOfPage,
    this.total,
    this.page,
    this.data,
  });

  DistributorRetailerModel.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    msg = json['msg'];
    limit = json['limit'];
    numberOfPage = json['number_of_page'];
    total = json['total'];
    page = json['page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['st'] = st;
    data['msg'] = msg;
    data['limit'] = limit;
    data['number_of_page'] = numberOfPage;
    data['total'] = total;
    data['page'] = page;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static fromData(Data data) {}
}

class Data {
  String? id;
  String? type;
  String? businessName;
  String? businessType;
  String? gstNo;
  String? address;
  String? pincode;
  String? name;
  String? mobile;
  String? state;
  String? city;
  String? regionId;
  String? areaId;
  String? appPk;
  String? image;
  String? bankAccountId;
  String? isApproved;
  String? openTime;
  String? closeTime;
  String? parentId;
  String? isAsync;
  String? brands;
  String? isDelete;

  Data({
    this.id,
    this.type,
    this.businessName,
    this.businessType,
    this.gstNo,
    this.address,
    this.pincode,
    this.name,
    this.mobile,
    this.state,
    this.city,
    this.regionId,
    this.areaId,
    this.appPk,
    this.image,
    this.bankAccountId,
    this.isApproved,
    this.openTime,
    this.closeTime,
    this.parentId,
    this.isAsync,
    this.brands,
    this.isDelete,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    businessName = json['business_name'];
    businessType = json['business_type'];
    gstNo = json['gst_no'];
    address = json['address'];
    pincode = json['pincode'];
    name = json['name'];
    mobile = json['mobile'];
    state = json['state'];
    city = json['city'];
    regionId = json['region_id'];
    areaId = json['area_id'];
    appPk = json['app_pk'];
    image = json['image'];
    bankAccountId = json['bank_account_id'];
    isApproved = json['isApproved'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    parentId = json['parent_id'];
    isAsync = json['is_async'];
    brands = json['brands'];
    isDelete = json['is_delete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['business_name'] = businessName;
    data['business_type'] = businessType;
    data['gst_no'] = gstNo;
    data['address'] = address;
    data['pincode'] = pincode;
    data['name'] = name;
    data['mobile'] = mobile;
    data['state'] = state;
    data['city'] = city;
    data['region_id'] = regionId;
    data['area_id'] = areaId;
    data['app_pk'] = appPk;
    data['image'] = image;
    data['bank_account_id'] = bankAccountId;
    data['isApproved'] = isApproved;
    data['open_time'] = openTime;
    data['close_time'] = closeTime;
    data['parent_id'] = parentId;
    data['is_async'] = isAsync;
    data['brands'] = brands;
    data['is_delete'] = isDelete;
    return data;
  }
}
