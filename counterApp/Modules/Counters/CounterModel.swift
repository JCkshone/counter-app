//
//  CounterModel.swift
//  counterApp
//
//  Created by Juan Camilo on 4/12/20.
//

import Foundation

/// Counter model
struct Counter: Codable {
    var id: String? = nil
    var title: String? = nil
    var count: Int? = nil
}

struct CounterRequest: Codable {
    var title: String
}
