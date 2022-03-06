//
//  UIImage+Extensions.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 6/3/22.
//

import Foundation
import UIKit

extension UIImage {
    static let groceryCartEmpty: UIImage = { return UIImage(named: "iconCart")! }()
    static let groceryCartFill: UIImage = { return UIImage(named: "iconCartFill")! }()
    static let groceryQuit: UIImage = { return UIImage(named: "iconClose")! }()
}
