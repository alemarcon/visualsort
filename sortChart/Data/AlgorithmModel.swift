//
//  AlgorithmModel.swift
//  sortChart
//
//  Created by Alessandro Marcon on 12/11/21.
//

import Foundation

enum SortAlgorithm {
    case unknow
    case bubbleSort
    case quickSort
    case seleSort
}

struct AlgorithmModel {
    var name: String
    var imageName: String
    var type: SortAlgorithm
    var selected: Bool
    
    init(name: String, imageName: String, type: SortAlgorithm, selected: Bool) {
        self.name = name
        self.imageName = imageName
        self.type = type
        self.selected = selected
    }
}

class AlgorithmModelRepository {
    
    static func generateAlgorithms() -> [AlgorithmModel] {
        var algorithms = [AlgorithmModel]()
        
        algorithms.append( AlgorithmModel(name: "Bubble Sort", imageName: "letter-b", type: .bubbleSort, selected: true))
//        algorithms.append( AlgorithmModel(name: "Quick Sort", imageName: "letter-q", type: .quickSort, selected: false))
        algorithms.append( AlgorithmModel(name: "Selection Sort", imageName: "letter-b", type: .seleSort, selected: false))
        
        return algorithms
    }
    
}
