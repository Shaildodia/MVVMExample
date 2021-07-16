//
//  ProductViewModel.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 15/07/21.
//

import Foundation
import MapKit

public class ProductViewModel {
  
  var vehicles = [Vehicle]()
  var annotations = [MKPointAnnotation]()
  
  init() {
    if let vehicles = fetchVehicleDetails() {
      self.vehicles = vehicles
    }
    annotations = annotationForAllVehicles()
  }
  
  // Fetch vehicle details from json files.
  private func fetchVehicleDetails() -> [Vehicle]? {
    if let url = Bundle.main.url(forResource: "Test-vehicles_data", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let vehicleData = try decoder.decode(Vehicles.self, from: data)
        return vehicleData.vehicles
      } catch {
        print("error:\(error)")
        return nil
      }
    } else {
      print("Could not found json file.")
      return nil
    }
  }
  
  // Provides annotations for all available vehicles.
  private func annotationForAllVehicles() -> [MKPointAnnotation] {
    let annotations = vehicles.map { vehicle -> MKPointAnnotation? in
      guard let lat = vehicle.lat, let long = vehicle.lng else {
        return nil
      }
      let annotation = MKPointAnnotation()
      annotation.title = vehicle.vehicle_make
      annotation.subtitle = vehicle.license_plate_number
      annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
      return annotation
    }
    return annotations.compactMap { $0 }
  }
  
  // Provide Annotation for vehicle.
  func annotation(for index: Int) -> MKPointAnnotation? {
    guard let lat = vehicles[index].lat, let long = vehicles[index].lng else {
      return nil
    }
    return annotations.first {
      $0.coordinate.latitude == lat && $0.coordinate.longitude == long
    }
  }
  
  // Method provide collectionViewCell Index for selected annotation.
  func indexForAnnotation(annotation: MKAnnotation) -> IndexPath? {
    let index = vehicles.firstIndex {
      $0.lat == annotation.coordinate.latitude && $0.lng == annotation.coordinate.longitude
    }
    guard let indexRow = index else {
      print("Could not get index from annotation.")
      return nil
    }
    return IndexPath(row: indexRow, section: 0)
  }
  
  // Provide viewModel for VehicleDetailCell.
  func getVehicleDetailModel(for index: Int) -> VehicleCellViewModel {
    return VehicleCellViewModel(vehicle: vehicles[index])
  }
}
