//
//  Counters.swift
//  counterAppTests
//
//  Created by Juan Camilo on 8/12/20.
//

import XCTest
@testable import counterApp

class Counters: XCTestCase {
    var viewModel: ICountersViewModel!
    fileprivate var manager: FakeCounterManager!
    
    override func setUp() {
        super.setUp()
        self.manager = FakeCounterManager()
        self.viewModel = CountersViewModel(manager: manager)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.manager = nil
        super.tearDown()
    }
    
    func testAddCounter() {
        let exp = expectation(description: "Add new counter")
        var loadResponse: LoadResponse = .success
        
        viewModel.loadComplete = { response in
            loadResponse = response
            exp.fulfill()
        }
        
        viewModel.doCreateCounter(counter: CounterRequest(title: "Prueba"))
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(loadResponse, .success, "Error to remove counter")
            XCTAssertTrue(!self.viewModel.counters.isEmpty)
        }
    }
    
    
    func testGetCounters() {
        let exp = expectation(description: "Get all counters")
        var loadResponse: LoadResponse = .success
        manager.response = [Counter()]
        
        viewModel.loadComplete = { response in
            loadResponse = response
            exp.fulfill()
        }
        
        viewModel.doLoadCounter()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertEqual(loadResponse, .success, "Error for get counters")
        }
    }
    
    func testGetEmptyCounters() {
        let exp = expectation(description: "Get empty counters")
        var loadResponse: LoadResponse = .empty
        
        viewModel.loadComplete = { response in
            loadResponse = response
            exp.fulfill()
        }
        
        viewModel.doLoadCounter()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
            XCTAssertEqual(loadResponse, .empty, "Error for get counters")
        }
    }
    
    func testRemoveCounter() {
        let exp = expectation(description: "Remove counter")
        var loadResponse: LoadResponse = .success
        let newResponse = [Counter(id: UUID().uuidString,
                                   title: "Prueba",
                                   count: 0),
                           Counter(id: UUID().uuidString,
                                   title: "Prueba2",
                                   count: 0)]
        
        manager.response?.append(contentsOf: newResponse)
        
        if let counters = manager.response {
            viewModel.counterSelect(counter: counters[0])
        }

        viewModel.loadComplete = { response in
            loadResponse = response
            exp.fulfill()
        }
        
        viewModel.doRemoveCounters()
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(loadResponse, .success, "Error to remove counter")
            XCTAssertTrue(self.viewModel.counters.count < newResponse.count)
        }
    }
    
    func testIncrementCounter() {
        let exp = expectation(description: "Remove counter")
        var loadResponse: LoadResponse = .success
        manager.response = [Counter(id: UUID().uuidString,
                                   title: "Prueba",
                                   count: 0)]

        viewModel.loadComplete = { response in
            loadResponse = response
            exp.fulfill()
        }
        
        viewModel.doIncrementCounter(counter: CounterRequest(id: manager.response?.first?.id ?? ""))
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(loadResponse, .success, "Error to remove counter")
            XCTAssertTrue(self.viewModel.counters.first?.count ?? 0 > 0)
        }
    }
    
    func testDecrementCounter() {
        let exp = expectation(description: "Remove counter")
        var loadResponse: LoadResponse = .success
        manager.response = [Counter(id: UUID().uuidString,
                                   title: "Prueba",
                                   count: 1)]

        viewModel.loadComplete = { response in
            loadResponse = response
            exp.fulfill()
        }
        
        viewModel.doDecrementCounter(counter: CounterRequest(id: manager.response?.first?.id ?? ""))
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssertEqual(loadResponse, .success, "Error to remove counter")
            XCTAssertTrue(self.viewModel.counters.first?.count ?? 0 == 0)
        }
    }
    
}

fileprivate class FakeCounterManager: ICountersManager {
    var response: [Counter]? = []
    
    func requestCounter(_ counter: CounterRequest, actionType: CounterAction,
                        completion: @escaping ([Counter]) -> (),
                        onError: @escaping (APIServiceError) -> ()) {
        if response == nil {
            onError(.apiError)
            return
        }
        
        switch actionType {
        case .delete:
            removeCounter(counter: CounterRequest(id: counter.id))
        case .create:
            addCounter(counter: counter)
        case .decrement:
            decrementCounter(counter: counter)
        case .increment:
            incrementCounter(counter: counter)
        default:
            break
        }
        
        completion(response ?? [])
    }
    
    func removeCounter(counter: CounterRequest) {
        let index = response?.firstIndex { $0.id == counter.id }
        if let index = index {
            response?.remove(at: index)
        }
    }
    
    func incrementCounter(counter: CounterRequest) {
        let index = response?.firstIndex { $0.id == counter.id }
        if let index = index, let count = response?[index].count {
            response?[index].count = count + 1
        }
    }
    
    func decrementCounter(counter: CounterRequest) {
        let index = response?.firstIndex { $0.id == counter.id }
        if let index = index, let count = response?[index].count {
            response?[index].count = count - 1
        }
    }
    
    func addCounter(counter: CounterRequest) {
        response?.append(Counter(id: UUID().uuidString,
                                 title: counter.title, count: 0))
    }
}
