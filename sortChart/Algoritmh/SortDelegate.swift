//
//  SortDelegate.swift
//  sortChart
//
//  Created by Alessandro Marcon on 02/11/21.
//

import Foundation

protocol SortDelegate {
    
    /// Method called on sorting completed
    /// - Parameter sortedValues: <#sortedValues description#>
    func sortingCompleted(sortedValues: [ChartBarView])
}
