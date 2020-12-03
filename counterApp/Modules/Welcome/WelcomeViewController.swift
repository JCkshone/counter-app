//
//  WelcomeViewController.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import UIKit

class WelcomeViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentViewAlmost: UIView! {
        didSet {
            contentViewAlmost.roundView(color: .primaryRed)
            contentViewAlmost.setBorder(color: .darkOpacity)
        }
    }
    @IBOutlet weak var contentViewUser: UIView! {
        didSet {
            contentViewUser.roundView(color: .primaryYellow)
            contentViewUser.setBorder(color: .darkOpacity)
        }
    }
    @IBOutlet weak var contentViewThoughts: UIView! {
        didSet {
            contentViewThoughts.roundView(color: .primaryGreen)
            contentViewThoughts.setBorder(color: .darkOpacity)
        }
    }
    @IBOutlet weak var continueBtn: UIButton! {
        didSet {
            continueBtn.backgroundColor = .primaryOrange
            continueBtn.shadowWithRadius()
            continueBtn.setTitle(CounterConstants.Welcome.continueText.localized(usingFile: StringFiles.welcome), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle()
        setEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setTitle() {
        titleLabel.text = CounterConstants.Welcome.title.localized(usingFile: StringFiles.welcome)
        titleLabel.changeColorWord(boldWord: CounterConstants.Welcome.titleWord.localized(usingFile: StringFiles.welcome))
    }
}

extension WelcomeViewController {
    func setEvents() {
        continueBtn.addAction(for: .touchUpInside) { [weak self] in
            self?.coordinator?.goToCounters()
        }
    }
}
