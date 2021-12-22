//
//  QuickSort.swift
//  sortChart
//
//  Created by Alessandro Marcon on 15/11/21.
//

import Foundation
import UIKit
import PromiseKit

class QuickSort {
    
    var delegate: SortDelegate?
    private var chartsArray: [ChartBarView]!
    private var chart: UIView
    private var duration: Double
    
    init(chartsArray: [ChartBarView], chart: UIView, duration: Double = 0.003) {
        self.chartsArray = chartsArray
        self.chart = chart
        self.duration = duration
    }
    
    var arr = [8, 10, 2, 15, 7, 22, 3, 1]
    var less = [Int]()
    var equal = [Int]()
    var greater = [Int]()
    
    func quickSort(arr: [Int]) -> [Int] {
        less = [Int]()
        equal = [Int]()
        greater = [Int]()
        
        if( arr.count > 1 ) {
            let pivot = arr[0]
            
            for x in arr {
                if( x < pivot ) {
                    less.append(x)
                }
                if( x == pivot ) {
                    equal.append(x)
                }
                if( x > pivot ) {
                    greater.append(x)
                }
            }
//            quickSortLoop(index: 0, array: arr, pivot: pivot)
            return(quickSort(arr:less)+equal+quickSort(arr:greater))
        } else {
            return arr
        }
    }
    
    func quickSortLoop(index: Int, array: [Int], pivot: Int) {
        if( index < arr.count-1 ) {
            if( arr[index] < pivot ) {
                less.append(arr[index])
            }
            if( arr[index] == pivot ) {
                equal.append(arr[index])
            }
            if( arr[index] > pivot ) {
                greater.append(arr[index])
            }
            quickSortLoop(index: index+1, array: arr, pivot: pivot)
        }
    }
    
    
    
    func qSort() {
//        qRightChecking(leftIndex: 0, rightIndex: chartsArray.count-1, pivot: chartsArray.count-1)
//        qLeftChecking(leftIndex: 1, rightIndex: chartsArray.count-1, pivot: 1)
//        qLeftMove(leftIndex: 0, rightIndex: chartsArray.count-1, pivot: 0)
        var a = quickSort(arr: arr)
        for n in a {
            print("\(n)")
        }
    }
    
//    func qPartition(leftIndex: Int, rightIndex: Int, pivot: Int) {
//        qRightChecking(leftIndex: leftIndex, rightIndex: rightIndex, pivot: pivot)
//    }
    
    func qRightChecking(leftIndex: Int, rightIndex: Int, pivot: Int) {
        if( rightIndex > leftIndex ) {
//            if( leftIndex != rightIndex ) {
                let diff = chartsArray[pivot].getChartBarValue() < chartsArray[rightIndex].getChartBarValue()
                print("Pivot \(chartsArray[pivot].getChartBarValue()) è minore di destra \(chartsArray[rightIndex].getChartBarValue())? \(diff)")
                if( chartsArray[pivot].getChartBarValue() < chartsArray[rightIndex].getChartBarValue() ) {
                    qRightChecking(leftIndex: leftIndex, rightIndex: rightIndex-1, pivot: pivot)
                } else {
                    // Scambio pivot con destra
                    print("Metto \(chartsArray[pivot].getChartBarValue()) al posto di \(chartsArray[rightIndex].getChartBarValue())")
                    swapLeft(pivotIndex: pivot, rightIndex: rightIndex, leftIndex: leftIndex)
                }
//            } else {
//                print("Pivot element \(chartsArray[pivot].getChartBarValue()) is in correct place \(leftIndex)")
//                if( pivot-1 == chartsArray.count ) {
//                    // Sono a fine array, parto dalla metà
//                    qRightChecking(leftIndex: 0, rightIndex: pivot-1, pivot: pivot-1)
//                } else if( pivot == 0 ) {
//                    qRightChecking(leftIndex: pivot+1, rightIndex: chartsArray.count-1, pivot: pivot+1)
//                } else {
//                    qRightChecking(leftIndex: 0, rightIndex: pivot, pivot: pivot)
//                }
//            }
        } else {
            print("Ordinamento completo")
            printArray()
        }
    }
    
    func qLeftChecking(leftIndex: Int, rightIndex: Int, pivot: Int) {
        if( leftIndex < rightIndex ) {
//            if( leftIndex != rightIndex ) {
                let diff = chartsArray[pivot].getChartBarValue() > chartsArray[leftIndex].getChartBarValue()
                print("Pivot \(chartsArray[pivot].getChartBarValue()) è maggiore di sinistra \(chartsArray[leftIndex].getChartBarValue())? \(diff)")
                if( chartsArray[pivot].getChartBarValue() > chartsArray[leftIndex].getChartBarValue() ) {
                    qLeftChecking(leftIndex: leftIndex+1, rightIndex: rightIndex, pivot: pivot)
                } else {
                    print("Metto \(chartsArray[pivot].getChartBarValue()) al posto di \(chartsArray[leftIndex].getChartBarValue())")
                    swapRight(pivotIndex: pivot, rightIndex: rightIndex, leftIndex: leftIndex)
                }
//            } else {
//                print("Pivot element \(chartsArray[pivot].getChartBarValue()) is in correct place \(rightIndex)")
//                if( pivot-1 == chartsArray.count ) {
//                    // Sono a fine array, parto dalla metà
//                    qRightChecking(leftIndex: 0, rightIndex: pivot-1, pivot: pivot-1)
//                } else if( pivot == 0 ) {
//                    qRightChecking(leftIndex: pivot+1, rightIndex: chartsArray.count-1, pivot: pivot+1)
//                } else {
//                    qRightChecking(leftIndex: 0, rightIndex: pivot, pivot: pivot)
//                }
//            }
        } else {
            print("Ordinamento completo")
            printArray()
        }
    }
    
    func swapRight(pivotIndex: Int, rightIndex: Int, leftIndex: Int) {
//        swap(left: leftIndex, right: rightIndex)
        let tempRightElement = chartsArray[leftIndex]
        chartsArray[leftIndex] = chartsArray[pivotIndex]
        chartsArray[pivotIndex] = tempRightElement
//        qRightMove(leftIndex: leftIndex, rightIndex: rightIndex, pivot: rightIndex)
        qRightChecking(leftIndex: leftIndex, rightIndex: rightIndex, pivot: leftIndex)
    }
    
    func swapLeft(pivotIndex: Int, rightIndex: Int, leftIndex: Int) {
//        swap(left: leftIndex, right: rightIndex)
        let tempLeftElement = chartsArray[rightIndex]
        chartsArray[rightIndex] = chartsArray[pivotIndex]
        chartsArray[pivotIndex] = tempLeftElement
//        qLeftMove(leftIndex: leftIndex, rightIndex: rightIndex, pivot: leftIndex)
        qLeftChecking(leftIndex: leftIndex, rightIndex: rightIndex, pivot: rightIndex)
    }
    
    func printArray() {
        for n in chartsArray {
            print("\(n.getChartBarValue())")
        }
    }
    
    func swap(left: Int, right: Int) {
        DispatchQueue.main.async {
            let tempLeftIndex = self.chartsArray[left]
            let tempRightIndex = self.chartsArray[right]
            let tempLeftBarXPosition = self.chartsArray[left].getXPosition()
            let tempRightBarXPosition = self.chartsArray[right].getXPosition()
            
            
            self.chart.viewWithTag(tempLeftIndex.getChartBarValue())!.frame.origin.x = tempRightBarXPosition
            self.chart.viewWithTag(tempRightIndex.getChartBarValue())!.frame.origin.x = tempLeftBarXPosition
            tempLeftIndex.setXPosition(tempRightBarXPosition)
            tempRightIndex.setXPosition(tempLeftBarXPosition)
            self.chartsArray[left] = tempRightIndex
            self.chartsArray[right] = tempLeftIndex
        }
    }
    
    
    
    func sort() {
        print("1 Begin sort")
        quickSort(low: 0, high: chartsArray.count-1)
//        print("9 Sort Completed")
//        for n in chartsArray {
//            print("\(n.getChartBarValue())")
//        }
    }
    
    func quickSort(low: Int, high: Int) {
        if (low < high) {
            
            // pi is partitioning index, arr[p]
            // is now at right place
            var pi = 0
            
//            let pi: Int = partition(low: low, high: high) //partition(arr, low, high);
            
            firstly {
                partition(low: low, high: high)
            }.done { partitionValue in
                pi = partitionValue
                self.quickSort(low: low, high: pi-1)
                self.quickSort(low: pi+1, high: high)
            }
            
            // Separately sort elements before
            // partition and after partition
//            quickSort(low: low, high: pi-1)
//            quickSort(low: pi+1, high: high)
        }
    }
    
    
    
    func partition(low: Int, high: Int) -> Promise<Int> {
        
        // pivot
//        var pivot: Int = chartsArray[high].getChartBarValue()
        print("2 Begin partition")
        var pivot: Int = chartsArray[high].getChartBarValue()
        
        // Index of smaller element and
        // indicates the right position
        // of pivot found so far
        var i = (low - 1)
        
        for j in low..<high {
            //        for(int j = low; j <= high - 1; j++) {
            print("3 Index J")
            // If current element is smaller
            // than the pivot
            if (chartsArray[j].getChartBarValue() <= pivot) {
                print("4 J is < than pivot \(chartsArray[j].getChartBarValue()) < \(pivot)")
                // Increment index of
                // smaller element
                i = i+1
//                quickSwap(i: i, j: j, isLast: false)
                firstly {
                    quickSwap(i: i, j: j, isLast: false)
                }.done { completed in
                    if( completed ) {
                        print("6 J Swap done")
                    }
                }
            }
        }
        firstly {
            quickSwap(i: i+1, j: high, isLast: true)
        }.done { completed in
            if( completed ) {
                print("7 Last swap done")
            }
        }
        
//        quickSwap(i: i+1, j: high, isLast: true)
//        return (i + 1)
        return Promise { newValue in
            print("8 partition return")
            newValue.fulfill( i+1 )
        }
    }
    
    func quickSwap(i: Int, j: Int, isLast: Bool) -> Promise<Bool> {
        print("5 Start swap")
        
        return Promise { completed in
            UIView.animate(withDuration: duration) {
                var tempIndexIBar = self.chartsArray[i]
                var tempIndexJBar = self.chartsArray[j]
                var tempIndexIBarXPosition = self.chartsArray[i].getXPosition()
                var tempIndexJBarXPosition = self.chartsArray[j].getXPosition()
                
                
                self.chart.viewWithTag(tempIndexIBar.getChartBarValue())!.frame.origin.x = tempIndexJBarXPosition
                self.chart.viewWithTag(tempIndexJBar.getChartBarValue())!.frame.origin.x = tempIndexIBarXPosition
                tempIndexIBar.setXPosition(tempIndexJBarXPosition)
                tempIndexJBar.setXPosition(tempIndexIBarXPosition)
                self.chartsArray[i] = tempIndexJBar
                self.chartsArray[j] = tempIndexIBar
            } completion: { isCompleted in
                if( isCompleted ) {
                    print("5.1 Animation completed")
                    completed.fulfill(true)
                }
            }
        }
        
//        UIView.animate(withDuration: duration) {
//            var tempIndexIBar = self.chartsArray[i]
//            var tempIndexJBar = self.chartsArray[j]
//            var tempIndexIBarXPosition = self.chartsArray[i].getXPosition()
//            var tempIndexJBarXPosition = self.chartsArray[j].getXPosition()
//
//
//            self.chart.viewWithTag(tempIndexIBar.getChartBarValue())!.frame.origin.x = tempIndexJBarXPosition
//            self.chart.viewWithTag(tempIndexJBar.getChartBarValue())!.frame.origin.x = tempIndexIBarXPosition
//            tempIndexIBar.setXPosition(tempIndexJBarXPosition)
//            tempIndexJBar.setXPosition(tempIndexIBarXPosition)
//            self.chartsArray[i] = tempIndexJBar
//            self.chartsArray[j] = tempIndexIBar
//        } completion: { completed in
//            print("Completed")
////            if( completed ) {
////                completion(true)
////            }
//        }
    }
    
    
    
    
    
    
    
    
    
//    func quickSortNew(low: Int, high: Int) {
//        if (low < high) {
//
//            // pi is partitioning index, arr[p]
//            // is now at right place
//            var pivot: Int = chartsArray[high].getChartBarValue()
//            partitionNew(low: low, high: high, pivot: pivot)
//
//            // Separately sort elements before
//            // partition and after partition
////            quickSort(low: low, high: pi-1)
////            quickSort(low: pi+1, high: high)
//        } else {
//            print("Complete")
//            for n in chartsArray {
//                print("\(n.getChartBarValue())")
//            }
//        }
//    }
//
//
//    func partitionNew(low: Int, high: Int, pivot: Int) {
//
//
//
//        // Index of smaller element and
//        // indicates the right position
//        // of pivot found so far
//        var i = (low - 1)
//
////        for j in low..<high {
////
////            // If current element is smaller
////            // than the pivot
////            if (chartsArray[j].getChartBarValue() <= pivot) {
////
////                // Increment index of
////                // smaller element
////                i = i+1
////                quickSwap(i: i, j: j, isLast: false)
////            }
////        }
////        quickSwap(i: i+1, j: high, isLast: true)
//
//
//        partitionNewLoop(j: low, low: low, high: high, i: i, pivot: pivot)
//
//    }
//
//    func partitionNewLoop(j: Int, low: Int, high: Int, i: Int, pivot: Int) {
//
//        if( low <= high ) {
//            if (chartsArray[j].getChartBarValue() <= pivot) {
//
//                // Increment index of
//                // smaller element
//                quickSwapNew(i: i+1, j: j, isLast: false, low: low, high: high, pivot: pivot)
//            }
//        } else {
//            quickSwapNew(i: i+2, j: high, isLast: true, low: low, high: high, pivot: pivot)
//        }
//    }
//
//    func quickSwapNew(i: Int, j: Int, isLast: Bool, low: Int, high: Int, pivot: Int) {
//
//
//        UIView.animate(withDuration: duration) {
//
//
//        var tempIndexIBar = self.chartsArray[i]
//        var tempIndexJBar = self.chartsArray[j]
//        var tempIndexIBarXPosition = self.chartsArray[i].getXPosition()
//        var tempIndexJBarXPosition = self.chartsArray[j].getXPosition()
//
//
//        self.chart.viewWithTag(tempIndexIBar.getChartBarValue())!.frame.origin.x = tempIndexJBarXPosition
//        self.chart.viewWithTag(tempIndexJBar.getChartBarValue())!.frame.origin.x = tempIndexIBarXPosition
//        tempIndexIBar.setXPosition(tempIndexJBarXPosition)
//        tempIndexJBar.setXPosition(tempIndexIBarXPosition)
//        self.chartsArray[i] = tempIndexJBar
//        self.chartsArray[j] = tempIndexIBar
//
//                } completion: { completed in
//                    if( completed ) {
//                        if( isLast ) {
//                            self.quickSortNew(low: low, high: i-1)
//                            self.quickSortNew(low: i+1, high: high)
//                        } else {
//                            self.partitionNewLoop(j: j+1, low: low, high: high, i: i, pivot: pivot)
//                        }
//        //                return (i+1)
//        //                if( biggerBarNewIndex+1 == self.chartsArray![biggerBarNewIndex].getChartBarValue() ) {
//        //                    biggerBar.setColorFor(position: .ordered)
//        //                } else {
//        //                    biggerBar.setColorFor(position: .unordered)
//        //                }
//        //
//        //                if( smallerBarNewIndex+1 == self.chartsArray![smallerBarNewIndex].getChartBarValue() ) {
//        //                    smallerBar.setColorFor(position: .ordered)
//        //                } else {
//        //                    smallerBar.setColorFor(position: .unordered)
//        //                }
//        //
//        //                self.runSecondLoopOnArray(currentLoopIndex: smallerBarNewIndex+1, firstLoopIndex: firstLoopIndex)
//                    }
//                }
//    }
}
