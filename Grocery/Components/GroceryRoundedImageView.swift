//
//  GroceryRoundedImageView.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 3/3/22.
//

import UIKit

final class GroceryRoundedImageView: UIView {

    fileprivate let viewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .grocerySecondaryBackground
        view.layer.shadowColor = UIColor.groceryBlackText.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    fileprivate let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .groceryBlackText
        return img
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(viewContainer)
        viewContainer.addSubview(imageView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: self.topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            imageView.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 0.60),
            imageView.heightAnchor.constraint(equalTo: viewContainer.widthAnchor)
        ])

        viewContainer.layer.cornerRadius = bounds.size.width/2

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

func setImage(_ image: UIImage?) {
    imageView.image = image
    }
}
