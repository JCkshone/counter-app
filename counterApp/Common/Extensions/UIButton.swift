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
    
    func setTitleWidthUndelineWords(title: String, underlineWords: String, color: UIColor = .darkSilver) {
        let range = (title as NSString).range(of: underlineWords)
        let attributedText = NSMutableAttributedString.init(string: title)
        
        attributedText.addAttribute(.underlineStyle, value: 1, range: range)
        self.setAttributedTitle(attributedText, for: .normal)
        self.setTitleColor(color, for: .normal)
    }
}
