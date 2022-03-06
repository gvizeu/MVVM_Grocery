//
//  UIRoundedButton.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 2/3/22.
//

import UIKit

final class GroceryRoundedButton: UIButton {

    private init() {
        fatalError("init(coder:) has not been implemented")
    }

    init(with title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        layer.cornerRadius = bounds.size.width/2
        layer.borderWidth = 2
        layer.borderColor = UIColor.groceryBlackText.cgColor
        clipsToBounds = true
        titleLabel?.font = .arialBold(size: 21)
        titleLabel?.textAlignment = .center
    }

    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        super.setTitleColor(.groceryBlackText, for: state)
    }
}
