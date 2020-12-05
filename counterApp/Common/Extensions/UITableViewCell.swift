//
//  UITableViewCell.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        String(describing: self)
    }
}
