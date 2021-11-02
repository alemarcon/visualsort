//
//  SortViewModel.swift
//  sortChart
//
//  Created by Alessandro Marcon on 02/11/21.
//

import Foundation
import Combine
import UIKit

enum Algorithm {
    case bubbleSort
}

class SortViewModel {
    
    //MARK: - View model state
    enum State {
        case none
        case generatingRandomValues
        case randomValuesGenerated
        case sortingRandomValues
        case randomValuesSorted
    }
    
    //MARK: - Private properties
    private var unorderedRandomValues = [Int]()
    private(set) var state: CurrentValueSubject<State, Never> = .init(.none)
    
    //MARK: - Private constants
    private let NUMBER_OF_ELEMENTS = 20
    
    //MARK: - Sort algorithm objects
    private var bubbleSort: BubbleSort?
    
    //MARK: - Functions
    
    /// Generate random Int values
    func generateRandomValues() {
        state.send(.generatingRandomValues)
        unorderedRandomValues.removeAll()
        
        while unorderedRandomValues.count < Int(NUMBER_OF_ELEMENTS) {
            let randomNumber = Int.random(in: 1...Int(NUMBER_OF_ELEMENTS))
            if( !unorderedRandomValues.contains(randomNumber) ) {
                unorderedRandomValues.append( randomNumber )
            }
        }
        
        state.send(.randomValuesGenerated)
    }
    
    func randomValuesCount() -> Int {
        return unorderedRandomValues.count
    }
    
    func getValueAt(index: Int) -> Int {
        if( index >= 0 && unorderedRandomValues.count > index ) {
            return unorderedRandomValues[index]
        } else {
            return 0
        }
    }
    
    func getNumberOfElements() -> Int {
        return NUMBER_OF_ELEMENTS
    }
    
    func sortValuesWith(algorithm: Algorithm, chartView: UIView) {
        state.send(.sortingRandomValues)
        
        switch algorithm {
        case .bubbleSort:
            let bubbleSort = BubbleSort(array: unorderedRandomValues, chart: chartView, duration: 0.1)
            bubbleSort.delegate = self
            bubbleSort.sort()
        }
    }
}


extension SortViewModel: SortDelegate {
    
    func sortCompleted(sortedValues: [Int]) {
        self.unorderedRandomValues = sortedValues
        state.send(.randomValuesSorted)
    }
    
}
