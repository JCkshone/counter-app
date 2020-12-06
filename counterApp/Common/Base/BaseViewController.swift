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

enum NavigationItemType {
    case counters
    case countersEdit
    case createCounters
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
    
    var showLargeTitles = true {
        didSet {
            DispatchQueue.main.async {
                self.navigationItem.largeTitleDisplayMode = self.showLargeTitles ? .always : .never
                self.navigationController?.navigationBar.prefersLargeTitles = self.showLargeTitles
            }
            
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
        search.searchBar.sizeToFit()
        
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
    }
}

extension BaseViewController {
    
    /// Set navigation items
    func setActions(for type: NavigationItemType, availableActions: Bool = true) {
        switch type {
        case .counters:
            setCounterItemsBar(isAvailable: availableActions)
        case .countersEdit:
            serCounterEditItemsBar()
        case .createCounters:
            setCreateItemsBar()
        }
    }
    
    func serCounterEditItemsBar() {
        let done = CounterConstants.Counters.done.localized(usingFile: StringFiles.counters)
        let selectAll = CounterConstants.Counters.selectAll.localized(usingFile: StringFiles.counters)
        setItemsBar(rightAvailable: true, leftAvailable: true, leftItemTitle: done, rightItemTitle: selectAll)
    }
    
    private func setCounterItemsBar(isAvailable: Bool) {
        let edit = CounterConstants.Counters.edit.localized(usingFile: StringFiles.counters)
        setItemsBar(leftAvailable: true, leftItemTitle: isAvailable ? edit : "" )
       
    }
    private func setCreateItemsBar() {
        let cancel = CounterConstants.CounterCreate.cancel.localized(usingFile: StringFiles.counterCrete)
        let save = CounterConstants.CounterCreate.save.localized(usingFile: StringFiles.counterCrete)
        setItemsBar(rightAvailable: true, leftAvailable: true, leftItemTitle: cancel, rightItemTitle: save)
    }
    
    private func setItemsBar(rightAvailable: Bool = false, leftAvailable: Bool = false, leftItemTitle: String = "", rightItemTitle: String = "") {
        
        let lefItem = UIBarButtonItem().getBarItem(title: leftItemTitle,
                                                   isAvailable: leftAvailable,
                                                   target: self,
                                                   action: #selector(leftOnClick))
        
        let rightItem = UIBarButtonItem().getBarItem(title: rightItemTitle,
                                                     isAvailable: rightAvailable,
                                                     target: self,
                                                     action: #selector(rightOnClick))
        
        self.navigationItem.setLeftBarButton(!leftItemTitle.isEmpty ? lefItem : UIBarButtonItem(), animated: true)
        self.navigationItem.setRightBarButton(!rightItemTitle.isEmpty ? rightItem : UIBarButtonItem(), animated: true)
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
