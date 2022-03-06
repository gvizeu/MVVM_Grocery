//
//  GroceryBarButton.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 3/3/22.
//

import UIKit

final class GroceryBarButton: UIButton {

    init() {
        super.init(frame: .zero)
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }

    fileprivate func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 24
        clipsToBounds = true
        backgroundColor = .groceryCherryColor
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        super.setTitleColor(.groceryWhiteText, for: state)
    }
}
