//
//  UIButton.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation
import UIKit

extension UIButton {
    func shadowWithRadius(radius: CGFloat = 8) {
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 16
        self.layer.shadowColor = UIColor.shadow.cgColor
        self.layer.cornerRadius = radius
    }
}
