//
//  Coodinator.swift
//  counterApp
//
//  Created by Juan Camilo on 2/12/20.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func welcome()
}
