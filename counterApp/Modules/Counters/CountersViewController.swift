//
//  CountersViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import UIKit

class CountersViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Counters";
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        let rightButtonItem = UIBarButtonItem(
            title: "Title",
            style: .done,
            target: self,
            action: "rightButtonAction:"
        )
        
        let leftMenuItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(leftMenuItemSelected))
           self.navigationItem.setLeftBarButton(leftMenuItem, animated: false);
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func leftMenuItemSelected() {
        
    }
    
}

extension CountersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
