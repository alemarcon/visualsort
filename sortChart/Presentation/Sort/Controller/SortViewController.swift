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
    
    private let BAR_X_OFFSET = CGFloat(1)
    private let BAR_Y_OFFSET = CGFloat(2)
    private let BAR_HEIGHT_OFFSET = CGFloat(3)
    private let CHART_WIDTH_OFFSET = CGFloat(21)
    private var isUIUnlocked = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customizeUI()
        bindViewModel()
        viewModel.generateRandomValues()
    }
    
    private func customizeUI() {
        chartContainer.roundCorner(radius: 5.0)
        algorithmsTable.dataSource = self
        algorithmsTable.delegate = self
        algorithmsTable.register(UINib(nibName: AlgorithmTableViewCell.XIB_NAME, bundle: nil), forCellReuseIdentifier: AlgorithmTableViewCell.IDENTIFIER)
    }
    
    private func bindViewModel() {
        
        viewModel.state.sink { state in
            
            switch state {
            case .none:
                print("None")
                self.lockUI(isUnLocked: true)
            case .generatingRandomValues:
                print("Generating random values")
                self.lockUI(isUnLocked: false)
                self.cleanChartsView()
            case .randomValuesGenerated:
                print("Random values generated")
                self.drawBars()
                self.lockUI(isUnLocked: true)
            case .sortingRandomValues:
                print("Sorting values")
                self.lockUI(isUnLocked: false)
            case .randomValuesSorted:
                print("Value sorted")
                self.lockUI(isUnLocked: true)
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
    
    private func lockUI(isUnLocked: Bool) {
        isUIUnlocked = isUnLocked
    }
    
    @IBAction func reloadChart(_ sender: Any) {
        if( isUIUnlocked ) {
            viewModel.generateRandomValues()
        }
    }
    
    @IBAction func sortAlgorithm(_ sender: UIButton) {
        if( isUIUnlocked ) {
            viewModel.sortValuesWith(chartView: chartContainer)
        }
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.algorithms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AlgorithmTableViewCell.IDENTIFIER) as? AlgorithmTableViewCell {
            cell.setup(algorithm: viewModel.algorithms[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if( UIScreen.main.bounds.size.width > 400 ) {
            return CGFloat(98)
        } else {
            return CGFloat(60)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if( isUIUnlocked ) {
            for index in 0..<viewModel.algorithms.count {
                viewModel.algorithms[index].selected = indexPath.row == index ? true : false
                if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? AlgorithmTableViewCell {
                    cell.setSelected(viewModel.algorithms[index].selected)
                }
            }
        }
    }
}
