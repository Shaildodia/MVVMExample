//
//  Vehicle.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 15/07/21.
//

import Foundation

struct Vehicles: Codable {
  let vehicles: [Vehicle]
}

struct Vehicle: Codable {
  let id: Double
  let is_active: Bool
  let is_available: Bool
  let lat: Double?
  let license_plate_number: String
  let lng: Double?
  let pool: String
  let remaining_mileage: Double
  let remaining_range_in_meters: Double?
  let transmission_mode: String?
  let vehicle_make: String
  let vehicle_pic: String
  let vehicle_pic_absolute_url: String
  let vehicle_type: String
  let vehicle_type_id: Double
}
