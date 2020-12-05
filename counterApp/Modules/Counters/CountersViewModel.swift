//
//  CountersViewModel.swift
//  counterApp
//
//  Created by Juan Camilo on 3/12/20.
//

import Foundation

enum LoadResponse {
    case success
    case error
    case empty
}

protocol ICountersViewModel: class {
    var counters: [Counter] { get }
    var loadComplete: ((LoadResponse) -> ())? { get set }
    var dismissLoading: (()->())? { get set }
    func doLoadCounter()
    func reloadCounters()
}

class CountersViewModel: ICountersViewModel {
    
    var dismissLoading: (() -> ())?
    var counters: [Counter]
    var loadComplete: ((LoadResponse) -> ())?
    
    init() {
        counters = []
    }
    
    func doLoadCounter() {
        var items: [Counter] = []
        items.append(Counter(id: "", title: "Records played", count: 20))
        items.append(Counter(id: "", title: "Records played", count: 10))
        items.append(Counter(id: "", title: "Number of times I’ve forgotten my mother’s name because I was high on Frugelés.", count: 2))
        items.append(Counter(id: "", title: "Records played", count: 2))
        items.append(Counter(id: "", title: "Records played", count: 3))
        items.append(Counter(id: "", title: "Number of times I’ve forgotten my mother’s name because I was high on Frugelés.", count: 2))
        items.append(Counter(id: "", title: "Number of times I’ve forgotten my mother’s name because I was high on Frugelés.Number of times I’ve forgotten my mother’s name because I was high on Frugelés.", count: 2))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.counters = items
            self.loadComplete?(.success)
        }
    }
    
    func reloadCounters() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismissLoading?()
        }
    }
}
