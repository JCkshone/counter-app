//
//  UIAlertAction.swift
//  counterApp
//
//  Created by Juan Camilo on 8/12/20.
//

import Foundation
import UIKit

extension UIAlertAction {
    func changeTextColor(for color: UIColor = .primaryOrange) -> UIAlertAction {
        self.setValue(color, forKey: "titleTextColor")
        return self
    }
}
