//
//  GroceryItemTableViewCell.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import UIKit

class GroceryItemTableViewCell: UITableViewCell {

    var viewModel: GroceryItemViewModel? {
        didSet {
            fillUI()
        }
    }

    fileprivate func fillUI() {
        nameLabel.text = viewModel?.itemName
        priceLabel.text = viewModel?.itemPrice
        id = viewModel?.itemID ?? 0
        viewModel?.itemamount.bind({
            self.amountLabel.text = $0
        })
    }
    fileprivate var id: Int64 = 0
    fileprivate var nameLabel: GroceryLabel = GroceryLabel(textAlignment: .left)
    fileprivate var priceLabel: GroceryLabel = GroceryLabel(textAlignment: .right)
    fileprivate var amountLabel: GroceryLabel = GroceryLabel()
    fileprivate lazy var minusButton: GroceryRoundedButton = {
        let button = GroceryRoundedButton(with: "－")
        button.addTarget(self, action: #selector(removeItem), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var plusButton: GroceryRoundedButton = {
        let button = GroceryRoundedButton(with: "＋")
        button.addTarget(self, action: #selector(addItem), for: .touchUpInside)
        return button
    }()

    fileprivate lazy var stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        return stackview
    }()

    required init() {
        super.init(style: .default, reuseIdentifier: "GroceryItemTableViewCell")
        setupSubviews()
        setupConstraints()
        fillUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(minusButton)
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(plusButton)
        contentView.backgroundColor = .groceryPrimaryColor
    }

    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 24),
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

                priceLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 20),
                priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
                priceLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),

                minusButton.heightAnchor.constraint(equalToConstant: 32),
                minusButton.widthAnchor.constraint(equalToConstant: 32),

                plusButton.heightAnchor.constraint(equalToConstant: 32),
                plusButton.widthAnchor.constraint(equalToConstant: 32),

                stackView.topAnchor.constraint(equalTo: nameLabel.topAnchor),
                stackView.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
                stackView.leftAnchor.constraint(equalTo: priceLabel.rightAnchor, constant: 20),
                stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
                stackView.widthAnchor.constraint(equalToConstant: 120)
            ]
        )
        let constraint = NSLayoutConstraint(item: contentView, attribute: .height,
                                            relatedBy: .equal, toItem: nil,
                                            attribute: .height, multiplier: 1, constant: 50)
        constraint.priority = UILayoutPriority(999)
        constraint.isActive = true
    }

    @objc fileprivate func addItem(sender: UIButton) {
        viewModel?.addItem()
    }

    @objc fileprivate func removeItem(sender: UIButton) {
        viewModel?.removeItem()
    }
}
