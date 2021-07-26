//
//  Vehicle.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 15/07/21.
//

import Foundation

public struct Vehicles: Codable {
  let vehicles: [Vehicle]
}

public struct Vehicle: Codable {
  let id: Double
  let isActive: Bool
  let isAvailable: Bool
  let lat: Double?
  let licensePlateNumber: String
  let lng: Double?
  let pool: String
  let remainingMileage: Double
  let remainingRangeInMeters: Double?
  let transmissionMode: String?
  let vehiclMake: String
  let vehiclePic: String
  let vehiclePicAbsoluteUrl: String
  let vehicleType: String
  let vehicleTypeID: Double
  
  enum CodingKeys: String, CodingKey {
    case id
    case isActive = "is_active"
    case isAvailable = "is_available"
    case lat
    case licensePlateNumber = "license_plate_number"
    case lng
    case pool
    case remainingMileage = "remaining_mileage"
    case remainingRangeInMeters = "remaining_range_in_meters"
    case transmissionMode = "transmission_mode"
    case vehiclMake = "vehicle_make"
    case vehiclePic = "vehicle_pic"
    case vehiclePicAbsoluteUrl = "vehicle_pic_absolute_url"
    case vehicleType = "vehicle_type"
    case vehicleTypeID = "vehicle_type_id"
  }
}
