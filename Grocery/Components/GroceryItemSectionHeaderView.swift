//
//  GroceryItemSectionHeaderView.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 2/3/22.
//

import UIKit

final class GroceryItemSectionHeaderView: UIView {

    fileprivate var separatorTopLine: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .black
        return uiView
    }()

    fileprivate var separatorBottomLine: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        uiView.backgroundColor = .black
        return uiView
    }()

    fileprivate var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    fileprivate var nameLabel: GroceryLabel = {
        let label = GroceryLabel()
        label.font = .arialBold(size: 21)
        return label
    }()

    fileprivate var amountLabel: GroceryLabel = {
        let label = GroceryLabel()
        label.font = .arialBold(size: 21)
        label.textColor = .groceryGreyText
        return label
    }()

    init(name: String, amount: Dynamic<Float>) {
        super.init(frame: .zero)
        self.configureView(name: name, amount: amount)
        setupConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configureView(name: String, amount: Dynamic<Float>) {
        addSubview(stackView)
        addSubview(separatorTopLine)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(UIView())
        addSubview(separatorBottomLine)
        backgroundColor = .groceryPrimaryColor

        amount.bind({
            self.amountLabel.text = $0.asCurrency
        })
        self.nameLabel.text = name.uppercased()
    }

    fileprivate func setupConstraint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 52),

            separatorTopLine.topAnchor.constraint(equalTo: topAnchor),
            separatorTopLine.leftAnchor.constraint(equalTo: leftAnchor),
            separatorTopLine.rightAnchor.constraint(equalTo: rightAnchor),
            separatorTopLine.heightAnchor.constraint(equalToConstant: 2),

            stackView.topAnchor.constraint(equalTo: separatorTopLine.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: separatorTopLine.leftAnchor, constant: 24),
            stackView.rightAnchor.constraint(equalTo: separatorTopLine.rightAnchor, constant: -24),

            separatorBottomLine.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            separatorBottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorBottomLine.leftAnchor.constraint(equalTo: leftAnchor),
            separatorBottomLine.rightAnchor.constraint(equalTo: rightAnchor),
            separatorBottomLine.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}
