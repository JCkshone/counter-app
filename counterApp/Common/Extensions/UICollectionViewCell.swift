//
//  UICollectionViewCell.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        String(describing: self)
    }
}
