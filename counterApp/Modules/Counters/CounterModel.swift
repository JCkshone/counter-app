//
//  CounterModel.swift
//  counterApp
//
//  Created by Juan Camilo on 4/12/20.
//

import Foundation

/// Counter model
struct Counter: Codable {
    let id: String
    let title: String
    let count: Int
}
