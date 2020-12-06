//
//  CounterExampleCollectionViewCell.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import UIKit

class CounterExampleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var descriptionExample: UILabel!
    
    var example: String = "" {
        didSet {
            descriptionExample.text = example
        }
    }
    override func prepareForReuse() {
        descriptionExample.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
