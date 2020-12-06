//
//  CreateCounterExampleViewModel.swift
//  counterApp
//
//  Created by Juan Camilo on 6/12/20.
//

import Foundation

protocol ICreateCounterExampleViewModel {
    var counterExamples: [CounterExample] { get }
    var loadComplete: (()->())? { get set }
    func doLoadExamples()
}

class CreateCounterExampleViewModel: ICreateCounterExampleViewModel {
    var counterExamples: [CounterExample]
    var loadComplete: (() -> ())?
    
    init() {
        counterExamples = []
    }
    
    func doLoadExamples() {
        counterExamples.append(CounterExample(id: UUID().uuidString,
                                              title: "Drinks", examples: [Example(name: "Cups of coffee"),
                                                                          Example(name: "Glasses of water"),
                                                                          Example(name: "Watter")]))
        counterExamples.append(CounterExample(id: UUID().uuidString,
                                              title: "Food", examples: [Example(name: "Hot-dogs"),
                                                                        Example(name: "Cupcakes eaten"),
                                                                        Example(name: "Chicken")]))
        
        counterExamples.append(CounterExample(id: UUID().uuidString,
                                              title: "Misc", examples: [Example(name: "Times sneezed"),
                                                                        Example(name: "Naps"),
                                                                        Example(name: "Day dreaming")]))
        loadComplete?()
    }
    
    
}
