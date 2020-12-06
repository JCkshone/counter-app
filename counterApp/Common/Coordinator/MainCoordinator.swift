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
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToCounters() {
        let vc = CountersViewController()
        vc.viewModel = CountersViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToCounterCreate() {
        let vc = CreateCounterViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToCounterExample() {
        let vc = CreateCounterExampleViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
