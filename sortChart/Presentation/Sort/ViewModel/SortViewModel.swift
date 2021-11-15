//
//  SortViewModel.swift
//  sortChart
//
//  Created by Alessandro Marcon on 02/11/21.
//

import Foundation
import Combine
import UIKit

class SortViewModel {
    
    //MARK: - View model state
    enum State {
        case none
        case generatingRandomValues
        case randomValuesGenerated
        case sortingRandomValues
        case randomValuesSorted
    }
    //MARK: - Public properties
    var algorithms = [AlgorithmModel]()
    
    //MARK: - Private properties
    private var unorderedRandomValueBars = [ChartBarView]()
    private var repository: AlgorithmModelRepository?
    private var bubbleSort: BubbleSort?
    private(set) var state: CurrentValueSubject<State, Never> = .init(.none)
    
    //MARK: - Private constants
    private let NUMBER_OF_ELEMENTS = 20
    
    //MARK: - INIT
    init() {
        repository = AlgorithmModelRepository()
        generateAlgorithms()
    }
    
    /// Generate random Int values
    func generateRandomValues() {
        state.send(.generatingRandomValues)
        unorderedRandomValueBars.removeAll()
        
        while unorderedRandomValueBars.count < Int(NUMBER_OF_ELEMENTS) {
            let randomNumber = Int.random(in: 1...Int(NUMBER_OF_ELEMENTS))
            if( unorderedRandomValueBars.first(where: ({ $0.getChartBarValue() == randomNumber })) == nil ) {
                unorderedRandomValueBars.append( ChartBarView(value: randomNumber) )
            }
        }
        
        state.send(.randomValuesGenerated)
    }
    
    /// Generate algorithms array
    private func generateAlgorithms() {
        if let alg = repository?.generateAlgorithms() {
            algorithms = alg
        }
    }
    
    /// Get unordered array count
    /// - Returns: The elements of unorderedRandomValueBars
    func randomValuesCount() -> Int {
        return unorderedRandomValueBars.count
    }
    
    /// Get bar at specific index of unorderedRandomValueBars
    /// - Parameter index: The specific index to get bar from
    /// - Returns:ChartBarView object at specific index
    func getBarAt(index: Int) -> ChartBarView {
        if( index >= 0 && unorderedRandomValueBars.count > index ) {
            return unorderedRandomValueBars[index]
        } else {
            return ChartBarView(value: 0)
        }
    }
    
    /// Get number of elements to draw
    /// - Returns: NUMBER_OF_ELEMENTS let value
    func getNumberOfElements() -> Int {
        return NUMBER_OF_ELEMENTS
    }
    
    /// Execute sort with selected algorithm
    /// - Parameter chartView: UIView where animate sorting
    func sortValuesWith(chartView: UIView) {
        if let algorithm = algorithms.first(where: { $0.selected }) {
            state.send(.sortingRandomValues)
            switch algorithm.type {
            case .bubbleSort:
                let bubbleSort = BubbleSort(chartsArray: unorderedRandomValueBars, chart: chartView, duration: 0.1)
                bubbleSort.delegate = self
                bubbleSort.sort()
            case .quickSort:
                let quickSort = QuickSort(chartsArray: unorderedRandomValueBars, chart: chartView, duration: 0.1)
                quickSort.sort()
            default:
                print("Sort algorithm unknown")
            }
        }
    }
}


extension SortViewModel: SortDelegate {
    
    func sortingCompleted(sortedValues: [ChartBarView]) {
        print("Sorting completed")
        self.unorderedRandomValueBars = sortedValues
        state.send(.randomValuesSorted)
    }
    
}
