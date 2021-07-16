//
//  CustomButton.swift
//  VehicleDetail
//
//  Created by Shailesh Dodia on 16/07/21.
//

import UIKit

@IBDesignable
final class CustomButton: UIButton {
  let borderWidth = CGFloat(2.0)
  let borderColor = UIColor.white.cgColor
  let cornerRadius = CGFloat(8.0)
  
  override init(frame: CGRect){
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    configure()
  }
  
  private func configure() {
    clipsToBounds = true
    layer.borderColor = borderColor
    layer.borderWidth = borderWidth
    layer.cornerRadius = cornerRadius
    setTitleColor(.white, for: .normal)
    backgroundColor = UIColor(red: 0.0, green: (73.0/255.0), blue: (128.0/255.0), alpha: 1.0)
  }
}
