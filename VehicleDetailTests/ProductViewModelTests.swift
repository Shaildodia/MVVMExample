//
//  ProductViewModelTests.swift
//  VehicleDetailTests
//
//  Created by Shailesh Dodia on 17/07/21.
//

import XCTest
@testable import VehicleDetail

class ProductViewModelTests: XCTestCase {
  
  var productViewModel: ProductViewModel!
  
  override func setUpWithError() throws {
    productViewModel = ProductViewModel(jsonFileName: "DataForTest")
  }
  
  func testVehicleDetailsFromJson() {
    XCTAssertEqual(productViewModel.vehicles.count, 2, "There should be two vehicle")
    XCTAssertEqual(productViewModel.vehicles.first!.id, 100)
    XCTAssertEqual(productViewModel.vehicles.first!.lat, 37.779816)
    XCTAssertEqual(productViewModel.vehicles.first!.lng, -122.395447)
    XCTAssertEqual(productViewModel.vehicles.first!.vehiclMake, "Tata Tiago")
    XCTAssertEqual(productViewModel.vehicles.first!.vehicleType, "Tata Tiago")
    XCTAssertEqual(productViewModel.vehicles.first!.licensePlateNumber, "XYZ123")
    XCTAssertTrue(productViewModel.vehicles.first!.isActive)
    XCTAssertTrue(productViewModel.vehicles.first!.isActive)
  }
  
  func testAnnotationForAllVehicles() {
    XCTAssertEqual(productViewModel.annotations.count, 1, "There should be annotation for single vehicle")
    XCTAssertEqual(productViewModel.annotations.first!.coordinate.latitude, 37.779816)
    XCTAssertEqual(productViewModel.annotations.first!.coordinate.longitude, -122.395447)
  }
  
  func testSuccessAnnotationIndexPath() {
    let annotation = productViewModel.annotation(for: 0)
    XCTAssertEqual(annotation!.coordinate.latitude, 37.779816)
    XCTAssertEqual(annotation!.coordinate.longitude, -122.395447)
  }
  
  func testFailAnnotationIndexPath() {
    let annotation = productViewModel.annotation(for: 1)
    XCTAssertNil(annotation, "Annotation should not be present for index 1")
  }
}
