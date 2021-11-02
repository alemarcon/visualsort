//
//  ViewController.swift
//  sortChart
//
//  Created by Alessandro Marcon on 27/10/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var chartContainer: UIView!
    
    var viewModel = SortViewModel()
    var subscriptions: Set<AnyCancellable> = .init()
    
    private let UNORDERED_BAR_COLOR: UIColor = .red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
        viewModel.generateRandomValues()
    }
    
    private func bindViewModel() {
        
        viewModel.state.sink { state in
            
            switch state {
            case .none:
                print("None")
            case .generatingRandomValues:
                print("Generating random values")
                self.cleanChartsView()
            case .randomValuesGenerated:
                print("Random values generated")
                self.drawBars()
            case .sortingRandomValues:
                print("Sorting values")
            case .randomValuesSorted:
                print("Value sorted")
            }
            
        }.store(in: &subscriptions)
        
    }
    
    private func drawBars() {
        let singleBarWidth = chartContainer.frame.size.width/CGFloat(viewModel.getNumberOfElements())
        let singleBarMinHeight = chartContainer.frame.size.height/CGFloat(viewModel.getNumberOfElements())
        
        DispatchQueue.main.async {
            
            for index in 0..<self.viewModel.randomValuesCount() {
                let currentNumber = self.viewModel.getValueAt(index: index)
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
                bar.backgroundColor = self.UNORDERED_BAR_COLOR
                
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
    
    private func cleanChartsView() {
        for subview in chartContainer.subviews {
            subview.removeFromSuperview()
        }
    }

    @IBAction func reloadChart(_ sender: Any) {
        viewModel.generateRandomValues()
    }
    
    @IBAction func bubbleSortAlgorithm(_ sender: UIButton) {
        viewModel.sortValuesWith(algorithm: .bubbleSort, chartView: chartContainer)
    }
    
    
}

