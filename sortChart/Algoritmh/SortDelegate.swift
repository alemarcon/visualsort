//
//  SortDelegate.swift
//  sortChart
//
//  Created by Alessandro Marcon on 02/11/21.
//

import Foundation

protocol SortDelegate {
    
    /// Method called on sorting completed
    func sortingCompleted()
    
    func updateAndSwapBar(bars: [ChartBarModel], swapIndexes: [Int], completion: @escaping() -> Void)
}
