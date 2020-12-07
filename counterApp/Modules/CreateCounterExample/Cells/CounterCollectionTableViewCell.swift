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
    
    var counterExample: CounterExample = CounterExample(examples: []) {
        didSet {
            titleItem.text = counterExample.title?.uppercased() ?? ""
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
}

extension CounterCollectionTableViewCell {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
    }
}

extension CounterCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        counterExample.examples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? cell else { return UICollectionViewCell()}
        cellView.example = counterExample.examples[indexPath.row].name
        return cellView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = counterExample.examples[indexPath.row].name
        label.sizeToFit()
        
        return CGSize(width: label.frame.width + 60, height: 70)
    }
}
