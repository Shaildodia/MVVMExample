//
//  ProductViewModel.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 15/07/21.
//

import Foundation
import MapKit

public class ProductViewModel {
  
  public private(set) var vehicles = [Vehicle]()
  public private(set) var annotations = [MKPointAnnotation]()
  
  init(jsonFileName: String) {
    if let vehicles = fetchVehicleDetails(jsonFileName: jsonFileName) {
      self.vehicles = vehicles
    }
    annotations = annotationForAllVehicles()
  }
  
  // Fetch vehicle details from json files.
  private func fetchVehicleDetails(jsonFileName: String) -> [Vehicle]? {
    if let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let vehicleData = try decoder.decode(Vehicles.self, from: data)
        let vehicles = vehicleData.vehicles
        
        var uniqueVehicles = [Vehicle]()
        uniqueVehicles = vehicles.reduce(uniqueVehicles) { (partialVehicle, vehicle) -> [Vehicle] in
          if !partialVehicle.map({ $0.id }).contains(vehicle.id) {
            var retyr = partialVehicle
            retyr.append(vehicle)
            return retyr
          }
          return partialVehicle
        }
        
        return uniqueVehicles
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
        print("Can not get annotation without cordinates.")
        return nil
      }
      let annotation = MKPointAnnotation()
      annotation.title = vehicle.vehiclMake
      annotation.subtitle = vehicle.licensePlateNumber
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
