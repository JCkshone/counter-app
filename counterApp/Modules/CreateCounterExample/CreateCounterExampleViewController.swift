//
//  CreateCounterExampleViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import UIKit

class CreateCounterExampleViewController: BaseViewController {

    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleContent: UIView!
    
    typealias cell = CounterCollectionTableViewCell
    var coordinator: MainCoordinator?
    var viewModel: ICreateCounterExampleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initTableView()
        setupEvents()
    }
}

extension CreateCounterExampleViewController {
    
    func setupView() {
        titleContent.addBorderBottom()
        titleView.textColor = .darkSilver
        self.barTitle = CounterConstants.CreateCounterExample.title.localized(usingFile: StringFiles.createCounterExample)
        self.backButtonTitle = CounterConstants.CreateCounterExample.create.localized(usingFile: StringFiles.createCounterExample)
        self.view.backgroundColor = .lightGray
    }
    
    func initTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func setupEvents() {
        viewModel?.loadComplete = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
        viewModel?.doLoadExamples()
    }
}

extension CreateCounterExampleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (viewModel?.counterExamples ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellView = tableView.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? cell, let vm = viewModel else { return UITableViewCell()}
        cellView.counterExample = vm.counterExamples[indexPath.row]
        return cellView
    }
}
