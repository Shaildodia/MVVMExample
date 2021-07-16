//
//  VehicleDetailCell.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 15/07/21.
//

import UIKit

final class VehicleDetailCell: UICollectionViewCell {
  
  @IBOutlet private var numberOfSeat: UILabel!
  @IBOutlet private var remaining_mileage: UILabel!
  @IBOutlet private var vehicleName: UILabel!
  @IBOutlet private var license_plate_number: UILabel!
  @IBOutlet private var vehicleImage: UIImageView!
  
  func configureCell(with viewModel: VehicleCellViewModel) {
    numberOfSeat.text = viewModel.numberOfSeat
    remaining_mileage.text = viewModel.remaining_mileage
    vehicleName.text = viewModel.vehicleName
    license_plate_number.text = viewModel.license_plate_number

    viewModel.loadVehicleImage { [weak self] image in
      DispatchQueue.main.async {
        self?.vehicleImage.image = image
      }
    }
  }
}
