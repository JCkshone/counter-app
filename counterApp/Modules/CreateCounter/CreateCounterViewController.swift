//
//  CreateCounterViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 4/12/20.
//

import UIKit

class CreateCounterViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        self.barTitle = CounterConstants.CounterCreate.title.localized(usingFile: StringFiles.counterCrete)
    }
}
