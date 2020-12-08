//
//  CountersManager.swift
//  counterApp
//
//  Created by Juan Camilo on 7/12/20.
//

import Foundation

protocol ICountersManager {
    func getAllCounters(completion: @escaping ([Counter]) -> (), onError: @escaping (APIServiceError) -> ())
    func requestCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ())
    func createCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ())
    func deleteCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ())
    func incrementCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ())
    func decrementCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ())
}

enum CounterAction {
    case get
    case create
    case delete
    case increment
    case decrement
}



class CountersManager: ICountersManager {

    let networkHelper = NetworkServices()
    
    func getAllCounters(completion: @escaping ([Counter]) -> (),
                        onError: @escaping (APIServiceError) -> ()) {
        let path = CounterConstants.Url.Path.counters
        
        networkHelper.get(type: [Counter].self, aditionalPath: path) { response in
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func requestCounter(request: CounterRequest, completion: @escaping (Bool) -> (),
                       onError: @escaping (APIServiceError) -> ()) {
        let path = "\(CounterConstants.Url.Path.counter)"
        
        networkHelper.counterAction(data: request, aditionalPath: path) { (response) in
            switch response {
            case .success(_):
                completion(true)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func createCounter(request: CounterRequest, completion: @escaping (Bool) -> (),
                       onError: @escaping (APIServiceError) -> ()) {
        let path = "\(CounterConstants.Url.Path.counter)"
        
        networkHelper.counterAction(data: request, aditionalPath: path) { (response) in
            switch response {
            case .success(_):
                completion(true)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func incrementCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ()) {
        let path = "\(CounterConstants.Url.Path.counter)"
        
        networkHelper.counterAction(data: request, aditionalPath: path) { response in
            switch response {
            case .success(_):
                completion(true)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func decrementCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ()) {
        let path = "\(CounterConstants.Url.Path.counter)/\(CounterConstants.Url.Path.dec)"
        
        networkHelper.counterAction(data: request, aditionalPath: path) { response in
            switch response {
            case .success(_):
                completion(true)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func deleteCounter(request: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ()) {
        let path = "\(CounterConstants.Url.Path.counter)"
        
        networkHelper.counterAction(data: request, aditionalPath: path, httpMethod: .delete) { response in
            switch response {
            case .success(_):
                completion(true)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
