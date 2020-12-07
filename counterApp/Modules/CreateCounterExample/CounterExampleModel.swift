//
//  CounterExampleModel.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import Foundation

struct CounterExample: Codable {
    var id: String? = nil
    var title: String? = nil
    var examples: [Example]
}

struct Example: Codable {
    var name: String
}
