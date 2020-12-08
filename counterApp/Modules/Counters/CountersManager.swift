//
//  CountersManager.swift
//  counterApp
//
//  Created by Juan Camilo on 7/12/20.
//

import Foundation

protocol ICountersManager {
    func requestCounter(_ counter: CounterRequest, actionType: CounterAction,
                        completion: @escaping ([Counter]) -> (),
                        onError: @escaping (APIServiceError) -> ())
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
    
    func requestCounter(_ counter: CounterRequest, actionType: CounterAction, completion: @escaping ([Counter]) -> (),
                        onError: @escaping (APIServiceError) -> ()) {
        var path = "\(CounterConstants.Url.Path.counter)"
        
        switch actionType {
        case .get:
            path = "/\(CounterConstants.Url.Path.counters)"
        case .increment:
            path += "/\(CounterConstants.Url.Path.inc)"
        case .decrement:
            path += "/\(CounterConstants.Url.Path.dec)"
        default:
            break
        }
        
        if actionType == .get {
            networkHelper.get(type: [Counter].self, aditionalPath: path) { response in
                switch response {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    onError(error)
                }
            }
            return
        }
        
        networkHelper.counterAction(data: counter,
                                    aditionalPath: path,
                                    httpMethod: actionType == .delete ? .delete : .post) { (response) in
            switch response {
            case .success(let data):
                completion(data)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
