//
//  GroseryCheckoutCoordinator.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 2/3/22.
//

import UIKit

class GroseryCheckoutCoordinator: Coordinator {
    internal init(repository: GroceryItemListRepository) {
        self.repository = repository
    }

    private let repository: GroceryItemListRepository
    private var viewController: GroceryCheckoutViewController?

    func start() -> UIViewController {
        let viewModel = DefaultGroceryCheckoutViewModel(repository: repository)
        viewController = GroceryCheckoutViewController()
        viewModel.coordinatorDelegate = self
        viewController?.viewModel = viewModel
        return viewController ?? UIViewController()
    }
}

extension GroseryCheckoutCoordinator: GroceryCheckoutCoodinatorDelegate {
    func close() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
