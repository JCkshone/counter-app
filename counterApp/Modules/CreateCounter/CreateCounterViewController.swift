//
//  CreateCounterViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 4/12/20.
//

import UIKit

class CreateCounterViewController: BaseViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var counterHelp: UIButton! {
        didSet {
            let title = CounterConstants.CounterCreate.examples.localized(usingFile: StringFiles.counterCrete)
            let underlineWords = CounterConstants.CounterCreate.underlineExamples.localized(usingFile: StringFiles.counterCrete)
            counterHelp.setTitleWidthUndelineWords(title: title, underlineWords: underlineWords)
        }
    }
    
    var coordinator: MainCoordinator?
    var counterViewModel: ICountersViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupView()
        setupTextField()
        setupEvenst()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.barTitle = CounterConstants.CounterCreate.title.localized(usingFile: StringFiles.counterCrete)
    }
    @IBAction func changeTextField(_ sender: Any) {
        if textField.text?.count ?? 0 > 1 {
            return
        }
        self.setActions(for: .createCounters, availableActions: !(textField.text?.isEmpty ?? true))
    }
}

extension CreateCounterViewController {
    func setupEvenst() {
        counterHelp.addAction(for: .touchUpInside) {
            self.coordinator?.goToCounterExample()
        }
        
        counterViewModel?.loadComplete = { [weak self]  response in
            guard let self = self else { return }
            self.validateResponse(response)
        }
    }
    
    func validateResponse(_ response: LoadResponse) {
        if response == .success {
            DispatchQueue.main.async {
                self.coordinator?.goBack()
            }
            return
        }
        
        DispatchQueue.main.async {
            self.showAlert(title: CounterConstants.CounterCreate.createError.localized(usingFile: StringFiles.counterCrete),
                           messages: CounterConstants.General.errorConnection.localized(usingFile: StringFiles.general),
                           dismiss:  { _ in
                            self.coordinator?.goBack()
            })
            
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
        self.setActions(for: .createCounters, availableActions: false)
        
        textField.placeholder = CounterConstants.CounterCreate.counterPlaceholder.localized(usingFile: StringFiles.counterCrete)
    }
}

extension CreateCounterViewController: BaseViewControllerDelegate {
    func leftBarItemTapped() {
        coordinator?.goBack()
    }
    
    func rightBarItemTapped() {
        UIView.animate(withDuration: 0.3) {
            self.loader.alpha = 1
            self.textField.isUserInteractionEnabled = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
        }
        
        counterViewModel?.doCreateCounter(counter: CounterRequest(title: textField.text ?? ""))
    }
}
