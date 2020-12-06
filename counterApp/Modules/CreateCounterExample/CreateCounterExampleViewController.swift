//
//  CreateCounterExampleViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import UIKit

class CreateCounterExampleViewController: UIViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    typealias cell = CounterCollectionTableViewCell
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
}

extension CreateCounterExampleViewController {
    func initTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
}

extension CreateCounterExampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellView = tableView.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? cell else { return UITableViewCell()}
        return cellView
    }
}
