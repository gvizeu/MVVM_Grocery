//
//  AppCoordinator.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 27/2/22.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {

    private var window: UIWindow?

   lazy var service: API = {
        return GroceryAPI()
    }()

    lazy var database: GroseryDataStorage = {
         return GroseryDataStorage()
     }()

    init(window: UIWindow?) {
        self.window = window
    }
    private var listCoordinator: GroceryListCoordinator!

    @discardableResult
    func start() -> UIViewController {
        listCoordinator = GroceryListCoordinator(service: service, database: database)
        let mainVC = listCoordinator.start()
        self.window?.rootViewController = mainVC
        self.window?.makeKeyAndVisible()
        return mainVC
    }
}
