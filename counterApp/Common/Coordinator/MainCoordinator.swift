//
//  MainCoordinator.swift
//  counterApp
//
//  Created by Juan Camilo on 2/12/20.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func welcome() {
        let vc = WelcomeViewController()
        let viewModel = WelcomeViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToCounters() {
        let vc = CountersViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
