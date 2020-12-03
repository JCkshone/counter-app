//
//  UILabel.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation
import UIKit

extension UILabel {
    func changeColorWord(boldWord: String, color: UIColor = .primaryOrange) {
        guard let text = self.text else { return }
        let range = (text as NSString).range(of: boldWord)
        let attributedText = NSMutableAttributedString.init(string: text)
        
        attributedText.addAttribute(.foregroundColor, value: color, range: range)
        self.attributedText = attributedText
    }
}
