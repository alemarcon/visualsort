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
    let BARS_COUNT: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateChartBars()
    }
    
    private func generateChartBars() {
        valueArray.removeAll()
        
        while valueArray.count < Int(BARS_COUNT) {
            let randomNumber = Int.random(in: 1...Int(BARS_COUNT))
            if( !valueArray.contains(randomNumber) ) {
                valueArray.append( randomNumber )
            }
        }
        drawBars()
    }
    
    private func drawBars() {
        for subview in chartContainer.subviews {
            subview.removeFromSuperview()
        }
        
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
//                bar.translatesAutoresizingMaskIntoConstraints = false
                
                let numberLabel = UILabel()
                numberLabel.text = "\(currentNumber)"
                numberLabel.translatesAutoresizingMaskIntoConstraints = false
                numberLabel.font = UIFont.systemFont(ofSize: 5, weight: .semibold)
                numberLabel.textAlignment = .center
                numberLabel.textColor = .white
                numberLabel.numberOfLines = 1
                numberLabel.sizeToFit()
                bar.addSubview(numberLabel)
                
                bar.addConstraints([
                    numberLabel.topAnchor.constraint(equalTo: bar.topAnchor, constant: -8),
                    numberLabel.centerXAnchor.constraint(equalTo: bar.centerXAnchor)
                ])
                
                self.chartContainer.addSubview(bar)
            }
        }
        
    }

    @IBAction func reloadChart(_ sender: Any) {
        generateChartBars()
    }
    
    @IBAction func bubbleSortAlgorithm(_ sender: UIButton) {
        let bubbleSort = BubbleSort(array: valueArray, chart: chartContainer, duration: 0.1)
        bubbleSort.sort()
    }
    
    
}

