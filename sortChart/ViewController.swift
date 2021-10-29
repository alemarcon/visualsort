//
//  ViewController.swift
//  sortChart
//
//  Created by Alessandro Marcon on 27/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chartContainer: UIView!
    
    var valueArray = [Int]()
    let BARS_COUNT: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateChartBars()
    }


    func generateChartBars() {
        while valueArray.count < Int(BARS_COUNT) {
            let randomNumber = Int.random(in: 1...Int(BARS_COUNT))
            if( !valueArray.contains(randomNumber) ) {
                valueArray.append( randomNumber )
            }
        }
        drawBars()
    }
    
    func drawBars() {
        let singleBarWidth = chartContainer.frame.size.width/BARS_COUNT
        let singleBarMinHeight = chartContainer.frame.size.height/BARS_COUNT
        
        DispatchQueue.main.async {
            
            for index in 0..<self.valueArray.count {
                let currentNumber = self.valueArray[index]
                let currentHeight = CGFloat(currentNumber)*singleBarMinHeight
                let barX = singleBarWidth*CGFloat(index)
                let barY = self.chartContainer.bounds.size.height
                
                let bar = UIView(frame: CGRect(
                                    x: barX,
                                    y: barY,
                                    width: singleBarWidth,
                                    height: -currentHeight)
                )
                bar.tag = currentNumber
                bar.backgroundColor = .red
                self.chartContainer.addSubview(bar)
            }
        }
        
    }
    
    @IBAction func bubbleSortAlgorithm(_ sender: UIButton) {
        loopFirstArray(index: 0)
    }
    
    func loopFirstArray(index: Int) {
        if( index < valueArray.count ) {
            loopSecondArray(innerIndex: 0, outerIndex: index)
        }
    }
    
    func loopSecondArray(innerIndex: Int, outerIndex: Int) {
        if( innerIndex < valueArray.count-1 ) {
            if( valueArray[innerIndex] > valueArray[innerIndex+1] ) {
                
                let smallerBarX = self.chartContainer.viewWithTag(valueArray[innerIndex])!.frame.origin.x
                self.chartContainer.viewWithTag(valueArray[innerIndex])!.backgroundColor = .green
                let biggerBarX = self.chartContainer.viewWithTag(valueArray[innerIndex+1])!.frame.origin.x
                self.chartContainer.viewWithTag(valueArray[innerIndex+1])!.backgroundColor = .green
                swapBars(currentIndex: innerIndex, lowerIndex: innerIndex+1, biggerBarX: biggerBarX, smallerBarX: smallerBarX, outerIndex: outerIndex)
            } else {
                self.loopSecondArray(innerIndex: innerIndex+1, outerIndex: outerIndex)
            }
        } else {
            loopFirstArray(index: outerIndex+1)
        }
    }
    
    func swapBars(currentIndex: Int, lowerIndex: Int, biggerBarX: CGFloat, smallerBarX: CGFloat, outerIndex: Int) {
        
        UIView.animate(withDuration: 0.003) {
            let tmp = self.valueArray[currentIndex]
            self.chartContainer.viewWithTag(tmp)!.frame.origin.x = biggerBarX
            self.chartContainer.viewWithTag(self.valueArray[lowerIndex])!.frame.origin.x = smallerBarX
            self.valueArray[currentIndex] = self.valueArray[lowerIndex]
            self.valueArray[lowerIndex] = tmp
            
        } completion: { completed in
            if( completed ) {
                self.chartContainer.viewWithTag(self.valueArray[lowerIndex])!.backgroundColor = .red
                self.chartContainer.viewWithTag(self.valueArray[currentIndex])!.backgroundColor = .red
                self.loopSecondArray(innerIndex: currentIndex+1, outerIndex: outerIndex)
            }
        }
    }
    
}

