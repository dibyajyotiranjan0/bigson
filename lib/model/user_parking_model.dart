class UserparkingModel {
  bool? success;
  String? message;
  List<ParkingData>? data;

  UserparkingModel({this.success, this.message, this.data});

  factory UserparkingModel.fromJson(Map<String, dynamic> json) {
    return UserparkingModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null
          ? List<ParkingData>.from(
              json['data'].map((x) => ParkingData.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParkingData {
  int? parkingVehicleId;
  int? userId;
  String? vehicleNo;
  String? parkingPlotNo;
  String? parkingDate;
  String? parkingDate2;
  String? createdAt;
  ParkingDetails? parkingDetails;
  ParkingPriceDetails? parkingPriceDetails;

  ParkingData({
    this.parkingVehicleId,
    this.userId,
    this.vehicleNo,
    this.parkingPlotNo,
    this.parkingDate,
    this.parkingDate2,
    this.createdAt,
    this.parkingDetails,
    this.parkingPriceDetails,
  });

  factory ParkingData.fromJson(Map<String, dynamic> json) {
    return ParkingData(
      parkingVehicleId: json['parking_vehicle_id'],
      userId: json['user_id'],
      vehicleNo: json['vehicle_no'],
      parkingPlotNo: json['parking_plot_no'],
      parkingDate: json['parking_date'],
      parkingDate2: json['parking_date_2'],
      createdAt: json['created_at'],
      parkingDetails: json['parking_details'] != null
          ? ParkingDetails.fromJson(json['parking_details'])
          : null,
      parkingPriceDetails: json['parking_price_details'] != null
          ? ParkingPriceDetails.fromJson(json['parking_price_details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parking_vehicle_id'] = this.parkingVehicleId;
    data['user_id'] = this.userId;
    data['vehicle_no'] = this.vehicleNo;
    data['parking_plot_no'] = this.parkingPlotNo;
    data['parking_date'] = this.parkingDate;
    data['parking_date_2'] = this.parkingDate2;
    data['created_at'] = this.createdAt;
    if (this.parkingDetails != null) {
      data['parking_details'] = this.parkingDetails!.toJson();
    }
    if (this.parkingPriceDetails != null) {
      data['parking_price_details'] = this.parkingPriceDetails!.toJson();
    }
    return data;
  }
}

class ParkingDetails {
  int? parkingId;
  String? parkingName;
  int? parkingCapacity;
  int? parkingVehicleCount;
  String? parkingTime;
  String? parkingLocation;
  String? parkingPhoneNumber;
  String? createdAt;

  ParkingDetails({
    this.parkingId,
    this.parkingName,
    this.parkingCapacity,
    this.parkingVehicleCount,
    this.parkingTime,
    this.parkingLocation,
    this.parkingPhoneNumber,
    this.createdAt,
  });

  factory ParkingDetails.fromJson(Map<String, dynamic> json) {
    return ParkingDetails(
      parkingId: json['parking_id'],
      parkingName: json['parking_name'],
      parkingCapacity: json['parking_capacity'],
      parkingVehicleCount: json['parking_vehicle_count'],
      parkingTime: json['parking_time'],
      parkingLocation: json['parking_location'],
      parkingPhoneNumber: json['parking_phone_number'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['parking_id'] = this.parkingId;
    data['parking_name'] = this.parkingName;
    data['parking_capacity'] = this.parkingCapacity;
    data['parking_vehicle_count'] = this.parkingVehicleCount;
    data['parking_time'] = this.parkingTime;
    data['parking_location'] = this.parkingLocation;
    data['parking_phone_number'] = this.parkingPhoneNumber;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ParkingPriceDetails {
  int? priceId;
  int? time;
  int? subscriptionPrice;
  int? nonSubscriptionPrice;

  ParkingPriceDetails({
    this.priceId,
    this.time,
    this.subscriptionPrice,
    this.nonSubscriptionPrice,
  });

  factory ParkingPriceDetails.fromJson(Map<String, dynamic> json) {
    return ParkingPriceDetails(
      priceId: json['price_id'],
      time: json['time'],
      subscriptionPrice: json['subscription_price'],
      nonSubscriptionPrice: json['non_subscription_price'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['price_id'] = this.priceId;
    data['time'] = this.time;
    data['subscription_price'] = this.subscriptionPrice;
    data['non_subscription_price'] = this.nonSubscriptionPrice;
    return data;
  }
}
