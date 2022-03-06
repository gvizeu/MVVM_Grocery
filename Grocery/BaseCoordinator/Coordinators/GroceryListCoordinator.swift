//
//  GroceryListCoordinator.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation
import UIKit

class GroceryListCoordinator: Coordinator {

    private var rootViewController: UINavigationController!
    private let repository: GroceryItemListRepository

    init(service: API, database: GroseryDataStorage) {
        repository = DefaultGroceryItemListRepository(session: service, dataStorage: database)
    }

    func start() -> UIViewController {
        let viewController = GroceryListViewController()
        let viewModel = DefaultGroceryListViewModel(repository: repository)
        viewModel.coordinatorDelegate = self
        viewController.viewModel = viewModel
        rootViewController = UINavigationController(rootViewController: viewController)
        return rootViewController
    }
}

extension GroceryListCoordinator: GroceryListCoordinatorDelegate {
    func checkOut() {
        let checkoutCoordinator = GroseryCheckoutCoordinator(repository: repository)
        let viewController = checkoutCoordinator.start()
        self.rootViewController.pushViewController(viewController, animated: true)
    }
}
