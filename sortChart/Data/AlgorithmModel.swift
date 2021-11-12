//
//  AlgorithmModel.swift
//  sortChart
//
//  Created by Alessandro Marcon on 12/11/21.
//

import Foundation

struct AlgorithmModel {
    var name: String
    var imageName: String
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

class AlgorithmModelRepository {
    
    static func generateAlgorithms() -> [AlgorithmModel] {
        var algorithms = [AlgorithmModel]()
        
        algorithms.append( AlgorithmModel(name: "Bubblesort", imageName: "letter-b"))
        
        return algorithms
    }
    
}
