//
//  GroceryLabel.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 2/3/22.
//

import UIKit

final class GroceryLabel: UILabel {
    init(textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .groceryBlackText
        font = .arial(size: 18)
        numberOfLines = 0
    }

}
