//
//  VehicleViewModel.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 15/07/21.
//

import UIKit

public class VehicleCellViewModel {
  
  let numberOfSeat: String
  let remaining_mileage: String
  let vehicleName: String
  let license_plate_number: String
  let vehicleImage: String
  
  init(vehicle: Vehicle) {
    numberOfSeat = "\(Int.random(in: 3...6)) Seats"
    remaining_mileage = "Remaining mileage: \(vehicle.remainingMileage)"
    vehicleName = vehicle.vehiclMake
    license_plate_number = vehicle.licensePlateNumber
    vehicleImage = vehicle.vehiclePicAbsoluteUrl
  }
  
  func loadVehicleImage(completion: @escaping (UIImage) -> Void ) {
    guard let url = URL(string: vehicleImage) else {
      print("Error while getting url of vehicle.")
      completion(UIImage())
      return
    }
    
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
      guard error == nil, let data = data, let image = UIImage(data: data) else {
        print("Could not get image")
        completion(UIImage())
        return
      }
      completion(image)
    }).resume()
  }
}
