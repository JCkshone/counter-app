//
//  CreateCounterViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 4/12/20.
//

import UIKit

class CreateCounterViewController: BaseViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var counterHelp: UIButton! {
        didSet {
            let title = CounterConstants.CounterCreate.examples.localized(usingFile: StringFiles.counterCrete)
            let underlineWords = CounterConstants.CounterCreate.underlineExamples.localized(usingFile: StringFiles.counterCrete)
            counterHelp.setTitleWidthUndelineWords(title: title, underlineWords: underlineWords)
        }
    }
    
    var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupView()
        setupTextField()
        setupEvenst()
    }
}

extension CreateCounterViewController {
    func setupEvenst() {
        counterHelp.addAction(for: .touchUpInside) {
            self.coordinator?.goToCounterExample()
        }
    }
}

extension CreateCounterViewController {
    func setupTextField() {
        textField.tintColor = .primaryOrange
        
        UIView.animate(withDuration: 0.3) {
            self.textField.becomeFirstResponder()
        }
    }
    
    func setupView() {
        self.view.backgroundColor = .lightGray
        self.showLargeTitles = false
        self.barTitle = CounterConstants.CounterCreate.title.localized(usingFile: StringFiles.counterCrete)
        self.setActions(for: .createCounters)
        
        textField.placeholder = CounterConstants.CounterCreate.counterPlaceholder.localized(usingFile: StringFiles.counterCrete)
    }
}

extension CreateCounterViewController: BaseViewControllerDelegate {
    func leftBarItemTapped() {
        coordinator?.goBack()
    }
    
    func rightBarItemTapped() {
    }
}
