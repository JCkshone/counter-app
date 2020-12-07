//
//  CountersManager.swift
//  counterApp
//
//  Created by Juan Camilo on 7/12/20.
//

import Foundation

protocol ICountersManager {
    func getAllCounters(completion: @escaping ([Counter]) -> (), onError: @escaping (APIServiceError) -> ())
    func createCounter(counter: CounterRequest, completion: @escaping (Bool) -> (), onError: @escaping (APIServiceError) -> ())
}

class CountersManager: ICountersManager {
    
    let networkHelper = NetworkServices()
    
    func getAllCounters(completion: @escaping ([Counter]) -> (),
                        onError: @escaping (APIServiceError) -> () ) {
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
    
    func createCounter(counter: CounterRequest, completion: @escaping (Bool) -> (),
                       onError: @escaping (APIServiceError) -> ()) {
        let path = "\(CounterConstants.Url.Path.counter)"
        networkHelper.createCounter(data: counter, aditionalPath: path) { response in
            switch response {
            case .success(_):
                completion(true)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
