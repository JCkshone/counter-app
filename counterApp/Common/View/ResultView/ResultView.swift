//
//  EmptyResult.swift
//  counterApp
//
//  Created by Juan Camilo on 4/12/20.
//

import UIKit

class ResultView: UIView {

    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var descriptionItem: UILabel!
    @IBOutlet weak var itemBtn: UIButton!
    @IBOutlet weak var btnConstraint: NSLayoutConstraint!
    
    var title = "" {
        didSet {
            titleItem.text = title
        }
    }
    
    var descriptionInfo = "" {
        didSet {
            descriptionItem.text = descriptionInfo
        }
    }
    
    var titleBtn = "" {
        didSet {
            itemBtn.setTitle(titleBtn, for: .normal)
        }
    }
    
    var btnWidth = CounterConstants.View.ResultView.defaultWidthBtn {
        didSet {
            btnConstraint.constant = btnWidth
            self.layoutIfNeeded()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    override func awakeFromNib() {
        descriptionItem.textColor = .darkSilver
        itemBtn.backgroundColor = .primaryOrange
        itemBtn.shadowWithRadius()
    }
    
    func loadViewFromNib() {
        let bundle = Bundle.init(for: ResultView.self)
        
        if let viewsForAdd = bundle.loadNibNamed("ResultView", owner: self, options: nil), let contentView = viewsForAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
