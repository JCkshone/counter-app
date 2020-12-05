//
//  BaseViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import UIKit

protocol BaseViewControllerDelegate {
    func leftBarItemTapped()
    func rightBarItemTapped()
}

class BaseViewController: UIViewController {
    
    var barTitle = "" {
        didSet {
            self.navigationItem.title = barTitle;
        }
    }
    
    var showNavigationItem = false {
        didSet {
            self.navigationItem.hidesBackButton = !showNavigationItem
        }
    }
    
    var delegate: BaseViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupSearchBar(_ delegate: UISearchResultsUpdating) {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = delegate
        search.searchBar.tintColor = .primaryOrange
        search.searchBar.sizeToFit()
        search.obscuresBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = true
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        search.searchBar.sizeToFit()
        definesPresentationContext = true
    }
}

extension BaseViewController {
    func setEditItemsBar(isEdit: Bool, rightAvailable: Bool = false, leftAvailable: Bool = false) {
        let edit = CounterConstants.Counters.edit.localized(usingFile: StringFiles.counters)
        let done = CounterConstants.Counters.done.localized(usingFile: StringFiles.counters)
        let selectAll = CounterConstants.Counters.selectAll.localized(usingFile: StringFiles.counters)
        let lefItem = UIBarButtonItem().getBarItem(title: isEdit ? done : edit,
                                                   isAvailable: leftAvailable,
                                                   target: self,
                                                   action: #selector(leftOnClick))
        
        if isEdit {
            let rightItem = UIBarButtonItem().getBarItem(title: selectAll,
                                                         isAvailable: rightAvailable,
                                                         target: self,
                                                         action: #selector(rightOnClick))
            self.navigationItem.setRightBarButton(rightItem, animated: true)
        } else {
            self.navigationItem.setRightBarButton(UIBarButtonItem(), animated: true)
        }
        self.navigationItem.setLeftBarButton(lefItem, animated: true)
    }
    
    @objc func rightOnClick() {
        delegate?.rightBarItemTapped()
    }
    
    @objc func leftOnClick() {
        delegate?.leftBarItemTapped()
    }
    
    func showShareActivity(title: String) {
        let ac = UIActivityViewController(activityItems: [title], applicationActivities: nil)
        present(ac, animated: true)
    }
}
