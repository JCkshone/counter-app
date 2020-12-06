//
//  CounterExampleModel.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import Foundation

struct CounterExample: Codable {
    var id: String
    var title: String
    var examples: [Example]
}

struct Example: Codable {
    var name: String
}
