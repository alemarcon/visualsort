//
//  BarCollectionViewCell.swift
//  sortChart
//
//  Created by Alessandro Marcon on 15/03/22.
//

import UIKit

class BarCollectionViewCell: UICollectionViewCell {
    
    static let XIB_NAME = "BarCollectionViewCell"
    static let IDENTIFIER = "bar_cell"
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        position.text = ""
        setColorFor(position: .unordered)
    }
    
    func setupBar(by model: ChartBarModel, chartCollection: UICollectionView) {
        position.text = "\(model.getBarValue())"
        setColorFor(position: model.getPosition())
        setBarSize(chartCollection: chartCollection, value: model.getBarValue())
        background.roundCorner(radius: 2.0)
    }
    
    func setBarSize(chartCollection: UICollectionView, value: Int) {
        let singleBarMinHeight = chartCollection.frame.size.height/CGFloat(20)
        let currentBarHeight = (CGFloat(value)*singleBarMinHeight)//-CGFloat(3)
        topSpaceConstraint.constant = chartCollection.frame.size.height-currentBarHeight
    }
    
    func setColorFor(position: BarPosition) {
        switch position {
        case .unordered:
            background.backgroundColor = UIColor.Custom.unordered
        case .ordered:
            background.backgroundColor = UIColor.Custom.ordered
        case .selected:
            background.backgroundColor = UIColor.Custom.selected
        }
    }

}
