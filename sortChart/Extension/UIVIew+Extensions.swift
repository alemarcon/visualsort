//
//  UIVIew+Extensions.swift
//  sortChart
//
//  Created by Alessandro Marcon on 12/11/21.
//

import Foundation

import UIKit

extension UIView {
    
    func roundCorner(radius: CGFloat) {
        if( radius > 0.0 ) {
            layer.cornerRadius = radius
        }
    }
    
}
