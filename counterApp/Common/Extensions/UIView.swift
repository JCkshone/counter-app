//
//  UIView.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation
import UIKit

extension UIView {
    func roundView(radius: CGFloat = 10, color: UIColor) {
        self.layer.cornerRadius = radius
        self.backgroundColor = color
    }
    
    func setBorder(_ width: CGFloat = 1, color: UIColor) {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
}
