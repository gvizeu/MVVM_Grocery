//
//  AppDelegate.swift
//  Grocery
//
//  Created by Gonzalo Vizeu on 26/2/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        AppCoordinator(window: window)
            .start()
        return true
    }
}
