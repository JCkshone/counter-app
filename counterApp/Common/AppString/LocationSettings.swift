//
//  LocationSettings.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation

struct StringFiles {
    static let welcome = "Welcome"
    static let counters = "Counters"
    static let counterCrete = "CounterCrete"
}
enum CounterLanguage: String {
    case en = "en"
}

class CounterLocalization {
    var baseLanguage: CounterLanguage = .en
    static let share = CounterLocalization()
}
