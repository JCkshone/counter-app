//
//  EmptyResult.swift
//  counterApp
//
//  Created by Juan Camilo on 4/12/20.
//

import UIKit

class ResultView: UIView {

    @IBOutlet fileprivate weak var titleItem: UILabel!
    @IBOutlet fileprivate weak var descriptionItem: UILabel!
    @IBOutlet fileprivate weak var itemBtn: UIButton!
    
    var title = "" {
        didSet {
            titleItem.text = title
        }
    }
    
    var descriptionInfo = "" {
        didSet {
            titleItem.text = descriptionInfo
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
    }
    
    func loadViewFromNib() {
        let bundle = Bundle.init(for: ResultView.self)
        
        if let viewsForAdd = bundle.loadNibNamed("EmptyResult", owner: self, options: nil), let contentView = viewsForAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
