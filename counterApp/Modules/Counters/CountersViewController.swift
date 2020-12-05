//
//  CountersViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import UIKit

enum TableViewMode {
    case edit
    case normal
}

class CountersViewController: BaseViewController {
    
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var resultView: ResultView!
    @IBOutlet weak var contentInfoAdd: UIView!
    @IBOutlet weak var contentEditActions: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var counterInfo: UILabel!
    @IBOutlet weak var contentEmpty: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ICountersViewModel?
    var refreshControl: UIRefreshControl!
    var coordinator: MainCoordinator?
    var tableViewMode: TableViewMode = .normal
    var isSelectAllItems: Bool = false
    
    typealias cell = CounterTableViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.showNavigationItem = false
        self.delegate = self
        
        setupView()
        setupSearchBar(self)
        initTableView()
        setupEvents()
    }
    
}

extension CountersViewController {
    
    func validateReponse(from type: LoadResponse) {
        switch type {
        case .empty:
            showError(isEmptyError: true)
        case .success:
            showSuccess()
        default:
            showError()
        }
    }
    
    func setupEvents() {
        addBtn.addAction(for: .touchUpInside) {
            self.coordinator?.goToCounterCreate()
        }
        
        shareBtn.addAction(for: .touchUpInside) {
            self.showShareActivity()
        }
        
        resultView.itemBtn.addAction(for: .touchUpInside) {
            self.coordinator?.goToCounterCreate()
        }
        
        refreshControl.addAction(for: .valueChanged) {
            self.tableView.isUserInteractionEnabled = false
            self.viewModel?.reloadCounters()
            if self.tableViewMode == .edit {
                self.changeTableViewMode()
            }
            
        }
        
        viewModel?.loadComplete = { [weak self] response in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.setEditItemsBar(isEdit: false, leftAvailable: !(self.viewModel?.counters ?? []).isEmpty)
            self.validateReponse(from: response)
        }
        
        viewModel?.dismissLoading = { [weak self] in
            guard let self = self else { return }
            self.tableView.isUserInteractionEnabled = true
            self.refreshControl.endRefreshing()
        }
        viewModel?.doLoadCounter()
    }
}

extension CountersViewController {
    
    func setupView() {
        self.barTitle = CounterConstants.Counters.title.localized(usingFile: StringFiles.counters)
        self.view.backgroundColor = .bgGray
        counterInfo.textColor = .darkSilver
        contentEmpty.backgroundColor = .lightGray
        tableView.backgroundColor = .lightGray
    }
    
    func initTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl)
        tableView.register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func showSuccess() {
        self.contentEmpty.isHidden = true
        self.tableView.isHidden = false
    }
    
    func showError(isEmptyError: Bool = false) {
        setupResult(isErrorNetwork: isEmptyError)
        UIView.animate(withDuration: 0.4) {
            self.loader.isHidden = true
            self.resultView.isHidden = false
        }
    }
    
    func setupResult(isErrorNetwork: Bool) {
        let title = !isErrorNetwork ?
            CounterConstants.Counters.titleFiledLoad.localized(usingFile: StringFiles.counters) :
            CounterConstants.Counters.noCounters.localized(usingFile: StringFiles.counters)
        let description = !isErrorNetwork ? CounterConstants.Counters.descriptionFailedLoad.localized(usingFile: StringFiles.counters) :
            CounterConstants.Counters.noCountersDescription.localized(usingFile: StringFiles.counters)
        let titleBtn = !isErrorNetwork ? CounterConstants.Counters.retry.localized(usingFile: StringFiles.counters) :
            CounterConstants.Counters.createCounters.localized(usingFile: StringFiles.counters)
        
        resultView.title = title
        resultView.descriptionInfo = description
        resultView.titleBtn = titleBtn
        resultView.btnWidth = !isErrorNetwork ?
            CounterConstants.View.ResultView.retryWidthBtn :
            CounterConstants.View.ResultView.defaultWidthBtn
    }
    
    func changeTableViewMode() {
        tableViewMode = tableViewMode == .normal ? .edit : .normal
        contentInfoAdd.isHidden = tableViewMode == .edit
        contentEditActions.isHidden = tableViewMode == .normal
        tableView.reloadData()
        self.setEditItemsBar(isEdit: tableViewMode == .edit,
                             rightAvailable: tableViewMode == .edit,
                             leftAvailable: true)
    }
}

// MARK: - Search bar events
extension CountersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}


// MARK: - Table view events
extension CountersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.counters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellView = tableView.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? cell, let vm = viewModel else { return UITableViewCell()}
        cellView.descriptionItem.text = vm.counters[indexPath.row].title
        cellView.quantity.text = "\(vm.counters[indexPath.row].count)"
        cellView.isEditMode = tableViewMode == .edit
        cellView.isItemSelect = isSelectAllItems
        return cellView
    }
}

extension CountersViewController: BaseViewControllerDelegate {
    func leftBarItemTapped() {
        isSelectAllItems = false
        changeTableViewMode()
    }
    
    func rightBarItemTapped() {
        isSelectAllItems = true
        tableView.reloadData()
    }
}
