//
//  QuickSort.swift
//  sortChart
//
//  Created by Alessandro Marcon on 15/11/21.
//

import Foundation
import UIKit

class QuickSort {
    
    var delegate: SortDelegate?
    private var chartsArray: [ChartBarView]?
    private var chart: UIView
    private var duration: Double
    
    var arr = [Int]()
    
    init(chartsArray: [ChartBarView], chart: UIView, duration: Double = 0.003) {
        self.chartsArray = chartsArray
        self.chart = chart
        self.duration = duration
    }
    
    func sort() {
        arr = [8, 6, 5, 7, 9, 10, 13]
        quickSort(low: 0, high: arr.count-1)
        print("Complete")
        for n in arr {
            print("\(n)")
        }
    }

    func quickSort(low: Int, high: Int) {
        if (low < high) {
              
            // pi is partitioning index, arr[p]
            // is now at right place
            let pi: Int = partition(low: low, high: high) //partition(arr, low, high);
      
            // Separately sort elements before
            // partition and after partition
            quickSort(low: low, high: pi-1)
//            quickSort(arr, low, pi - 1)
            quickSort(low: pi+1, high: high)
//            quickSort(arr, pi + 1, high)
        }
    }
    
    func partition(low: Int, high: Int) -> Int {
          
        // pivot
        var pivot: Int = arr[high]
          
        // Index of smaller element and
        // indicates the right position
        // of pivot found so far
        var i = (low - 1)
      
        for j in low..<high {
//        for(int j = low; j <= high - 1; j++) {
              
            // If current element is smaller
            // than the pivot
            if (arr[j] <= pivot) {
                  
                // Increment index of
                // smaller element
                i = i+1
                quickSwap(i: i, j: j)
//                quickSwap(arr, i, j)
            }
        }
        quickSwap(i: i+1, j: high)
//        quickSwap(arr, i + 1, high)
        return (i + 1);
    }
    
    func quickSwap(i: Int, j: Int) {
        let temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
    }
}
