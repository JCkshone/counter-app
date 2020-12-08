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
    func doCreateCounter(counter:  CounterRequest)
}

class CountersViewModel: ICountersViewModel {
    
    var dismissLoading: (() -> ())?
    var counters: [Counter]
    var loadComplete: ((LoadResponse) -> ())?
    var manager: ICountersManager
    var isReload = false
    
    init(manager: ICountersManager = CountersManager()) {
        self.manager = manager
        counters = []
    }
    
    func doLoadCounter() {
        manager.getAllCounters { counters in
            self.counters = counters.filter { !($0.title ?? "").isEmpty }
            self.loadComplete?(counters.isEmpty ? .empty : .success)
            if self.isReload {
                self.dismissLoading?()
            }
        } onError: { error in
            self.loadComplete?(.error)
        }
    }
    
    func reloadCounters() {
        isReload = true
        doLoadCounter()
    }
    
    func doCreateCounter(counter: CounterRequest) {
        manager.createCounter(counter: counter) { response in
            self.loadComplete?(response ? .success : .error)
        } onError: { error in
            self.loadComplete?(.error)
        }

    }
    
}
