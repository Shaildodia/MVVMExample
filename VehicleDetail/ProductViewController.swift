//
//  ProductViewController.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 15/07/21.
//

import UIKit
import MapKit

class ProductViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  private struct Constants {
    static let reuseIdentifier = "vehicleDetailCellIdentifier"
    static let cellWidth = 266.0
    static let cellHeight = 196.0
    static let defaultCordinateLat = 37.7749
    static let defaultCordinateLon = -122.419418
  }
  
  @IBOutlet private var mapView: MKMapView!
  @IBOutlet private var vehicleCollectionViewController: UICollectionView!
  
  let productViewModel = ProductViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    vehicleCollectionViewController.contentInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 64);
    getRequiredLocatiom()
    addAnotations()
  }
  
  // Zoom map to sanfrancisco.
  private func getRequiredLocatiom() {
    let sanfranciscoCordinates = CLLocation(
      latitude: Constants.defaultCordinateLat, longitude: Constants.defaultCordinateLon)
    let viewRegion = MKCoordinateRegion(
      center: sanfranciscoCordinates.coordinate, latitudinalMeters: 6000, longitudinalMeters: 6000)
    mapView.setRegion(viewRegion, animated: false)
  }
  
  // Add all annotation on mapview.
  private func addAnotations() {
    mapView.addAnnotations(productViewModel.annotations)
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if annotation is MKUserLocation { return nil }
    let identifier = "annotationIdentifier"
    if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
      annotationView.annotation = annotation
      return annotationView
    } else {
      let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier: identifier)
      annotationView.isEnabled = true
      annotationView.canShowCallout = true
      return annotationView
    }
  }
  
  // Delegate method when user tap on annotation Pin.
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
    print("didSelectAnnotationTapped")
    guard let annotation = view.annotation else { return }
    // center the mapView on the selected pin
    let coordinate = annotation.coordinate
    let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
    
    guard let indexPath = productViewModel.indexForAnnotation(annotation: annotation) else {
      return
    }
    vehicleCollectionViewController.scrollToItem(at: indexPath, at: .right, animated: true)
  }
  
  
  @IBAction func reserveCabButtonTapped(_ sender: Any) {
    let alertView = UIAlertController(
      title: "Success!", message: "This cab has been reserved for you!", preferredStyle: .alert)
    alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    self.present(alertView, animated: true)
  }
}

extension ProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    productViewModel.vehicles.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as? VehicleDetailCell else {
      Swift.assertionFailure("Could not get CollectionViewCell.")
      return UICollectionViewCell()
    }
    cell.configureCell(with: productViewModel.getVehicleDetailModel(for: indexPath.row))
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let selectedAnnotation = productViewModel.annotation(for: indexPath.row) {
      mapView.selectAnnotation(selectedAnnotation, animated: true)
    } else {
      print("We do not have map position.")
      let alertView = UIAlertController(
        title: "Error", message: "We do not have map position for this cab.", preferredStyle: .alert)
      alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
      self.present(alertView, animated: true)
    }
  }
}

extension ProductViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
  }
}
