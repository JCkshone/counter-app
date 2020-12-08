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
    var filterComplete: (() -> ())? { get set }
    var dismissLoading: (()->())? { get set }
    var failedCounterUpdate: (()->())? { get set }
    
    func doLoadCounter()
    func reloadCounters()
    func doCreateCounter(counter:  CounterRequest)
    func doIncrementCounter(counter: CounterRequest)
    func doDecrementCounter(counter: CounterRequest)
    func counterSelect(counter: Counter)
    func counterDeSelected(counter: Counter)
    func selectAllCounters(_ select: Bool)
    func doRemoveCounters()
    func filter(from value: String)
}

class CountersViewModel: ICountersViewModel {
    var filterComplete: (() -> ())?
    var failedCounterUpdate: (() -> ())?
    var dismissLoading: (() -> ())?
    var counters: [Counter]
    var loadComplete: ((LoadResponse) -> ())?
    var manager: ICountersManager
    var isReload = false
    var counterForActions: [Counter]
    lazy var countersRecovery: [Counter] = []
    
    init(manager: ICountersManager = CountersManager()) {
        self.manager = manager
        
        counters = []
        counterForActions = []
    }
    
    func doLoadCounter() {
        manager.requestCounter(CounterRequest(), actionType: .get) { counters in
            self.countersRecovery  = counters
            self.bindResponse(from: counters)
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
        manager.requestCounter(counter, actionType: .create) { counters in
            self.countersRecovery  = counters
            self.bindResponse(from: counters)
        } onError: { error in
            self.loadComplete?(.error)
        }
    }
    
    func doDecrementCounter(counter: CounterRequest) {
        manager.requestCounter(counter, actionType: .decrement) { counters in
            self.countersRecovery  = counters
            self.bindResponse(from: counters)
        } onError: { error in
            self.failedCounterUpdate?()
        }
        
    }
    
    func doIncrementCounter(counter: CounterRequest) {
        manager.requestCounter(counter, actionType: .increment) { counters in
            self.countersRecovery  = counters
            self.bindResponse(from: counters)
        } onError: { error in
            self.failedCounterUpdate?()
        }
    }
    
    func counterSelect(counter: Counter) {
        counterForActions.append(counter)
    }
    
    func selectAllCounters(_ select: Bool) {
        if select {
            counterForActions = counters
            return
        }
        counterForActions.removeAll()
    }
    
    func counterDeSelected(counter: Counter) {
        let index = counterForActions.firstIndex { $0.id == counter.id }
        if let index = index {
            counterForActions.remove(at: index)
        }
    }
    
    
    func bindResponse(from counters: [Counter]) {
        self.counters = counters.filter { !($0.title ?? "").isEmpty }
        self.loadComplete?(counters.isEmpty ? .empty : .success)
    }
    
    func doRemoveCounters() {
        for item in counterForActions {
            removeCounter(from: CounterRequest(id: item.id))
        }
    }
    
    func filter(from value: String) {
        self.counters = value.isEmpty ? self.countersRecovery : countersRecovery.filter { ($0.title ?? "")
                .lowercased()
                .contains(value.lowercased())}
        self.filterComplete?()
    }
    
    private func removeCounter(from counter: CounterRequest) {
        manager.requestCounter(counter, actionType: .delete) { counters in
            self.bindResponse(from: counters)
        } onError: { error in
            self.failedCounterUpdate?()
        }
    }
    
}
