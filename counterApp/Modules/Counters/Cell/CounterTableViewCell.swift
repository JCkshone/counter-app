//
//  CounterTableViewCell.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import UIKit

class CounterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var descriptionItem: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!
    
    var isEditMode: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.checkBtn.alpha = self.isEditMode ? 1 : 0
            }
            UIView.animate(withDuration: 0.4) {
                self.leadingContraint.constant = self.isEditMode ? CounterConstants.View.CounterCell.leadingExpand : CounterConstants.View.CounterCell.leadingDefault
                self.layoutIfNeeded()
            }
            
        }
    }
    
    var isItemSelect: Bool = false {
        didSet {
            let imageName = isItemSelect ? "ic_check" : "ic_mark"
            UIView.animate(withDuration: 0.3) {
                self.checkBtn.setImage(UIImage(named: imageName), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quantity.textColor = .primaryOrange
    }
    
    override func prepareForReuse() {
        quantity.text = ""
        descriptionItem.text = ""
    }
    
}
