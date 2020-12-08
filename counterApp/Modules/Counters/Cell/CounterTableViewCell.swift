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
    @IBOutlet weak var stepper: UIStepper!
    
    var stepperIncrement: ((Counter) -> ())?
    var stepperDecrement: ((Counter) -> ())?
    var itemSelect: ((Counter, Bool) -> ())?
    
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
    
    var model: Counter = Counter() {
        didSet {
            descriptionItem.text = model.title
            quantity.text = "\(model.count ?? 0)"
            stepper.value = Double(model.count ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        quantity.textColor = .primaryOrange
        setEvents()
    }
    
    override func prepareForReuse() {
        quantity.text = ""
        descriptionItem.text = ""
    }
    
    
    private func setEvents() {
        checkBtn.addAction(for: .touchUpInside) {
            self.isItemSelect = !self.isItemSelect
            self.itemSelect?(self.model, self.isItemSelect)
        }
        
        stepper.addAction(for: .valueChanged) {
            self.stepperHanblerdExec()
            self.quantity.text = "\(Int(self.stepper.value))"
        }
    }
    
    private func stepperHanblerdExec() {
        if  Int(stepper.value) > Int(quantity.text ?? "") ?? 0 {
            stepperIncrement?(model)
            return
        }
        
        stepperDecrement?(model)
    }
    
}
