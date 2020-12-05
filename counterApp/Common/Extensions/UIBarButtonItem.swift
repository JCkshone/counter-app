//
//  UIBarButtonItem.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    /// Create item to navigation bar
    func getBarItem(title: String,
                    isAvailable: Bool = false,
                    color: UIColor = .primaryOrange,
                    target: Any,
                    action: Selector) -> UIBarButtonItem {
        self.title = title
        self.tintColor = color
        self.target = target as AnyObject
        self.isEnabled = isAvailable
        self.action = action
        
        if let font = UIFont(name: CounterConstants.Font.regular, size: 17) {
            self.setTitleTextAttributes([.font: font], for: .normal)
        }
        
        return self
    }
}
