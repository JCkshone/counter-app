//
//  CounterCollectionTableViewCell.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import UIKit

class CounterCollectionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    typealias cell = CounterExampleCollectionViewCell
    var identifier = cell.identifier
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension CounterCollectionTableViewCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
    }
}

extension CounterCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? cell else { return UICollectionViewCell()}
        return cell
    }
}
