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
    @IBOutlet weak var algorithmsTable: UITableView!
    
    var viewModel = SortViewModel()
    var subscriptions: Set<AnyCancellable> = .init()

    private let algorithms = ["Bubble Sort"]
    private let BAR_X_OFFSET = CGFloat(1)
    private let BAR_Y_OFFSET = CGFloat(2)
    private let BAR_HEIGHT_OFFSET = CGFloat(3)
    private let CHART_WIDTH_OFFSET = CGFloat(21)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeUI()
        bindViewModel()
        algorithmsTable.dataSource = self
        viewModel.generateRandomValues()
    }
    
    private func customizeUI() {
        chartContainer.roundCorner(radius: 5.0)
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
        let singleBarWidth = (chartContainer.frame.size.width-CHART_WIDTH_OFFSET)/CGFloat(viewModel.getNumberOfElements())
        let singleBarMinHeight = chartContainer.frame.size.height/CGFloat(viewModel.getNumberOfElements())

        for index in 0..<self.viewModel.randomValuesCount() {
            let barAtCurrentIndex = self.viewModel.getBarAt(index: index)
            let currentBarHeight = (CGFloat(barAtCurrentIndex.getChartBarValue())*singleBarMinHeight)-BAR_HEIGHT_OFFSET
            let currentBarX = ((singleBarWidth+BAR_X_OFFSET)*CGFloat(index))+BAR_X_OFFSET
            let currentBarY = self.chartContainer.bounds.size.height-BAR_Y_OFFSET
            barAtCurrentIndex.setupBarFrame(x: currentBarX, y: currentBarY, h: -currentBarHeight, w: singleBarWidth)
            self.chartContainer.addSubview(barAtCurrentIndex)
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


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return algorithms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
