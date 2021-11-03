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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        name.text = ""
    }
    
    func setup(algorithmName: String) {
        self.name.text = algorithmName
    }
}
