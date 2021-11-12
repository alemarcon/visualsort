//
//  AlgorithmTableViewCell.swift
//  sortChart
//
//  Created by Alessandro Marcon on 02/11/21.
//

import UIKit

class AlgorithmTableViewCell: UITableViewCell {
    
    static let XIB_NAME = "AlgorithmTableViewCell"
    static let IDENTIFIER = "algorithm_cell"

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var backgroundContainer: UIView!
    @IBOutlet weak var sortImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundContainer.roundCorner(radius: 5.0)
        name.text = ""
        sortImage.image = nil
    }
    
    func setup(algorithm: AlgorithmModel) {
        self.name.text = algorithm.name
        self.sortImage.image = UIImage(named: algorithm.imageName)
    }
}
